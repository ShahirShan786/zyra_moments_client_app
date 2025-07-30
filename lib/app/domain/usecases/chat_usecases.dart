import 'package:zyra_momments_app/app/domain/entities/chat_message_model.dart';
import 'package:zyra_momments_app/app/domain/entities/chat_summary_model.dart';
import 'package:zyra_momments_app/app/domain/repository/chat_repository.dart';

class ChatUsecases {
  final ChatRepository chatRepository;

  ChatUsecases({required this.chatRepository});

//  For connect Socket

  Future<void> connectToSocket({
    required String userId,
    required String userType,
    required Function(ChatMessageModel) onMessage,
    required Function(List<ChatMessageModel>) onChatHistory,
  }) async {
    chatRepository.connectToSocket(
        userId: userId, userType: userType, onMessage: onMessage ,onChatHistory: onChatHistory );
  }

// For send message

  Future<void> sendMessage({
    required String chatRoomId,
    required String senderId,
    required String senderType,
    required String content,
  }) async {
    chatRepository.sendMessage(
        chatRoomId: chatRoomId,
        senderId: senderId,
        senderType: senderType,
        content: content);
  }

// For getting chat history

Future<List<ChatMessageModel>> getChatHistory(String chatRoomId)async{
return await chatRepository.getChatHistory(chatRoomId);
}

// Mark message as read

Future<void> markMessageAsRead({
  required String chatRoomId,
  required String userId,
  required String userType,
})async {
  chatRepository.markMessageAsRead(chatRoomId: chatRoomId, userId: userId, userType: userType);
}

// Get user chats
void getUserChats({
  required String userId,
  required String userType,
  required Function(List<ChatSummaryModel>) onChatReceived,
  Function(String)? onError,
}){
  chatRepository.getUserChats(userId: userId, userType: userType, onChatsReceived: onChatReceived, onError: onError);
}
// For disconnect socket

Future<void> disConnectSocket()async{
  chatRepository.disconnectSocket();
}


}
