part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

// For Connect Socket

class ConnectToSocketEvnet extends ChatEvent {
  final String userId;
  final String userType;

  const ConnectToSocketEvnet({required this.userId, required this.userType});

    @override
  List<Object> get props => [userId , userType];
}


// For sendMessge

class SendMessageEvent extends ChatEvent{
  final String chatRoomId;
  final String senderId;
  final String senderType;
  final String content;

 const SendMessageEvent({required this.chatRoomId, required this.senderId, required this.senderType, required this.content});

   @override
  List<Object> get props => [chatRoomId , senderId , senderType, content];
}

// For chat history

class GetChatHistoryEvent extends ChatEvent{
  final String chatRoomId;

 const GetChatHistoryEvent({required this.chatRoomId});
  
    @override
  List<Object> get props => [chatRoomId];
}

// For message recieved

class MessageReceivedEvent extends ChatEvent{
  final ChatMessageModel message;

 const MessageReceivedEvent({required this.message});

   @override
  List<Object> get props => [message];
}

// For chat history received
class ChatHistoryReceivedEvent extends ChatEvent{
  final List<ChatMessageModel> messages;

const  ChatHistoryReceivedEvent({required this.messages});
   @override
  List<Object> get props => [messages];
}

// For message as read
class MarkMessageAsReadEvent extends ChatEvent{
  final String chatRoomId;
  final String userId;
  final String userType;

 const MarkMessageAsReadEvent({required this.chatRoomId, required this.userId, required this.userType});
   @override
  List<Object> get props => [chatRoomId , userId , userType ];
}
// For disconnect socket

class DisconnectSocketEvent extends ChatEvent{}