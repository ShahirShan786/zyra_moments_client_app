

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/domain/entities/chat_message_model.dart';
import 'package:zyra_momments_app/app/domain/usecases/chat_usecases.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatUsecases chatUsecases;
  List<ChatMessageModel> _messages = [];
    // final bool _isSocketConnected = false;
  String? _currentChatRoomId;
  ChatBloc(this.chatUsecases) : super(ChatInitial()) {
    on<ConnectToSocketEvnet>(_onConnectToSocket);
    on<SendMessageEvent>(_onSentMessage);
    on<GetChatHistoryEvent>(_onGetChatHistory);
    on<MessageReceivedEvent>(_onMessageRecieved);
    on<ChatHistoryReceivedEvent>(_onChatHistoryReceived);
     on<MarkMessageAsReadEvent>(_onMarkMessageAsRead);
    on<DisconnectSocketEvent>(_onDisconnectSocket);
  }

  void _onConnectToSocket(
    ConnectToSocketEvnet event,
    Emitter<ChatState> emit,
  ) async {
    try {
      emit(ChatLoadigState());
      await chatUsecases.connectToSocket(
          userId: event.userId,
          userType: event.userType,
          onMessage: (message) {
           if (_currentChatRoomId == null || message.chatRoomId == _currentChatRoomId) {
              add(MessageReceivedEvent(message: message));
            }
          },
          onChatHistory: (message) {
            add(ChatHistoryReceivedEvent(messages: message));
          },
          );
    } catch (e) {
      emit(ChatErrorState(error: e.toString()));
    }
  }


  void _onSentMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  )async{
   try{
     await chatUsecases.sendMessage(chatRoomId: event.chatRoomId,
     senderId: event.senderId, senderType: event.senderType, content: event.content);

     final tempMessage = ChatMessageModel(chatRoomId: DateTime.now().millisecondsSinceEpoch.toString(),
      senderId: event.senderId, content: event.content, sendAt: DateTime.now(), senderType: event.senderType);

      _messages.add(tempMessage);
      emit(MessageSentState(message: tempMessage));
      emit(ChatLoadedState(messages: _messages));

   }catch(e){
    emit(ChatErrorState(error: e.toString()));
   }
  }

  

  void _onGetChatHistory(
    GetChatHistoryEvent event,
    Emitter<ChatState> emit,
  )async{
    try{
      emit(ChatLoadigState());
      final message = await chatUsecases.getChatHistory(event.chatRoomId);
      _messages = message;
      emit(ChatLoadedState(messages: List.from(_messages)));

    }catch(e){
      emit(ChatErrorState(error: e.toString()));
    }
  }
void _onMessageRecieved(
  MessageReceivedEvent event,
  Emitter<ChatState> emit,
) {
  // Check if message already exists
  final existingIndex = _messages.indexWhere((msg) => 
    msg.senderId == event.message.senderId && 
    msg.content == event.message.content &&
    msg.sendAt.difference(event.message.sendAt).inSeconds.abs() < 5
  );

  if (existingIndex == -1) {
    _messages.add(event.message);
    // Sort messages again
    _messages.sort((a, b) => a.sendAt.compareTo(b.sendAt));
    emit(ChatLoadedState(messages: List.from(_messages)));
  }
}


  // void _onMessageRecieved(
  //   MessageReceivedEvent event,
  //   Emitter<ChatState> emit,
  // ) {

  //   // check if message already exists (to avoid duplicates)

  //  final existingIndex = _messages.indexWhere((msg) => 
  //     msg.senderId == event.message.senderId && 
  //     msg.content == event.message.content &&
  //     msg.sendAt.difference(event.message.sendAt).inSeconds.abs() < 5
  //   );

  //   if (existingIndex == -1) {
  //     _messages.add(event.message);
  //     emit(MessageReceivedState(message: event.message));
  //     emit(ChatLoadedState(messages: List.from(_messages)));
  //   }
  // }

  // For the chat historyReceived

  // void _onChatHistoryReceived(
  //   ChatHistoryReceivedEvent event,
  //   Emitter<ChatState> emit,
  // ) {
  //   _messages = event.messages;
  //   emit(ChatLoadedState(messages: List.from(_messages)));
  // }

  void _onChatHistoryReceived(
  ChatHistoryReceivedEvent event,
  Emitter<ChatState> emit,
) {
  // Clear existing messages to avoid duplicates
  _messages.clear();
  // Add new messages
  _messages.addAll(event.messages);
  // Sort messages by timestamp (oldest first)
  _messages.sort((a, b) => a.sendAt.compareTo(b.sendAt));
  emit(ChatLoadedState(messages: List.from(_messages)));
}


// For MessageMar as read
void _onMarkMessageAsRead(
  MarkMessageAsReadEvent event,
  Emitter<ChatState> emit,
) async {
  try{
    await chatUsecases.markMessageAsRead(chatRoomId: event.chatRoomId, userId: event.userId, userType: event.userType);
  }catch(e){
    log('Error marking message as read: $e');
  }
}

  void _onDisconnectSocket(
    DisconnectSocketEvent event,
    Emitter<ChatState> emit
  )async{
    await chatUsecases.disConnectSocket();
    _messages.clear();
    emit(ChatInitial());
  }
}
