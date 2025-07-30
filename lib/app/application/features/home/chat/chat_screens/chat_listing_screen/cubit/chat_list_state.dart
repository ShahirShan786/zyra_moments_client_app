part of 'chat_list_cubit.dart';

sealed class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object> get props => [];
}

final class ChatListInitial extends ChatListState {}

class ChatListLoadingState extends ChatListState {}

class ChatListLoadedState extends ChatListState{
  final List<ChatSummaryModel> chats;

const  ChatListLoadedState({required this.chats});
}

class ChatListFailureState extends ChatListState{
  final String errorMessage;

 const ChatListFailureState({required this.errorMessage});
}