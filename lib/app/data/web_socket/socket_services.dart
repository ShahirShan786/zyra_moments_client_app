import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:zyra_momments_app/app/domain/entities/chat_message_model.dart';
import 'package:zyra_momments_app/application/core/api/api_keys.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  late IO.Socket socket;

  SocketService._internal();

  void connect({
    required String userId,
    required String userType,
    required Function(ChatMessageModel) onMessage,
    required Function(List<ChatMessageModel>) onChatHistory,
  }) {
    socket = IO.io(
      ApiKey().baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setPath('/api/v_1/_chat')
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) {
      log("🟢 Socket connected: ${socket.id}");
      socket.emit("join", {"userId": userId, "userType": userType});
    });

    // Listen for incoming messages
    socket.on("message", (data) {
      try {
        final message = ChatMessageModel.fromJson(data);
        onMessage(message);
      } catch (e) {
        log("❌ Error parsing incoming message: $e");
      }
    });


   
  // Listen for chat history

    socket.on("chatHistory", (data) {
    try {
      log("📦 Chat history received: $data");
      if (data != null && data is Map<String, dynamic>) {
        final messagesData = data['messages'] as List?;
        if (messagesData != null) {
          final messages = messagesData
              .map((json) => ChatMessageModel.fromJson(json))
              .toList();
          onChatHistory(messages);
          return;
        }
      }
      onChatHistory([]);
    } catch (e) {
      log("❌ Error parsing chat history: $e");
      onChatHistory([]);
    }
  });

    
    socket.onConnectError((err) => log("❌ Connect Error: $err"));
    socket.onerror((err) => log("❌ Server Error: $err"));
  }


  

  void sendMessage({
    required String chatRoomId,
    required String senderId,
    required String senderType,
    required String content,
  }) {
    socket.emit("sendMessage", {
      "chatRoomId": chatRoomId,
      "senderId": senderId,
      "senderType": senderType,
      "content": content,
    });
  }

  void getChatHistory(String chatRoomId) {
    socket.emit("getChatHistory", chatRoomId);
  }


  void markMessageAsRead({
    required String chatRoomId,
    required String userId,
    required String userType,
  }){
    socket.emit("messageRead", {
      "chatRoomId" : chatRoomId,
      "userId" : userId,
      "userType" : userType,
    });
  }

  void disconnect() {
    socket.disconnect();
  }



}
