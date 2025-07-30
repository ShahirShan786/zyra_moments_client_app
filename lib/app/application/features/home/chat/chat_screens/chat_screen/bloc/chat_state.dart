part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  const ChatState();
  
  @override
  List<Object> get props => [];
}

final class ChatInitial extends ChatState {}

final class ChatLoadigState extends ChatState{}

final class ChatLoadedState extends ChatState{
  final List<ChatMessageModel> messages;

const  ChatLoadedState({required this.messages});

  @override
  List<Object> get props => [messages];
}

// For Messages

final class MessageSentState extends ChatState{
  final ChatMessageModel message;

 const MessageSentState({required this.message});

   @override
  List<Object> get props => [message];
}

final class MessageReceivedState extends ChatState{
  final ChatMessageModel message;

const  MessageReceivedState({required this.message});

   @override
  List<Object> get props => [message];
}


final class ChatErrorState extends ChatState{
  final String error;

 const ChatErrorState({required this.error});

    @override
  List<Object> get props => [error];
}