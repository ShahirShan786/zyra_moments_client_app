import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:zyra_momments_app/app/data/web_socket/socket_services.dart';
import 'package:zyra_momments_app/app/domain/entities/chat_message_model.dart';
import 'package:zyra_momments_app/app/domain/entities/chat_summary_model.dart';

class ChatRepository {
  final SocketService socketService = SocketService();

  /// Connect to the WebSocket and listen for incoming messages
  Future<void> connectToSocket({
    required String userId,
    required String userType,
    required Function(ChatMessageModel) onMessage,
    required Function(List<ChatMessageModel>) onChatHistory,
  }) async {
    socketService.connect(
      userId: userId,
      userType: userType,
      onMessage: onMessage,
      onChatHistory: onChatHistory,
    );
  }

  /// Send a message to the chat room
  void sendMessage({
    required String chatRoomId,
    required String senderId,
    required String senderType,
    required String content,
  }) {
    socketService.sendMessage(
      chatRoomId: chatRoomId,
      senderId: senderId,
      senderType: senderType,
      content: content,
    );
  }

  /// Request the chat history for a specific chat room
  Future<List<ChatMessageModel>> getChatHistory(String chatRoomId) async {
    // Create a completer to handle the async socket response
    final completer = Completer<List<ChatMessageModel>>();
    
    // Set up one-time listener for chat history
    socketService.socket.once("chatHistory", (data) {
      try {
        if (data != null && data is List) {
          final messages = data
              .map((json) => ChatMessageModel.fromJson(json))
              .toList();
          completer.complete(messages);
        } else {
          completer.complete([]);
        }
      } catch (e) {
        completer.completeError("Failed to parse chat history: $e");
      }
    });

    // Set up error timeout
    Timer(Duration(seconds: 10), () {
      if (!completer.isCompleted) {
        completer.completeError("Chat history request timeout");
      }
    });

    // Request chat history
    socketService.getChatHistory(chatRoomId);
    
    return completer.future;
  }

  /// Mark messages as read
  void markMessageAsRead({
    required String chatRoomId,
    required String userId,
    required String userType,
  }) {
    socketService.markMessageAsRead(
      chatRoomId: chatRoomId,
      userId: userId,
      userType: userType,
    );
  }

  /// Request all chats for the logged-in user
 void getUserChats({
    required String userId,
    required String userType,
    required Function(List<ChatSummaryModel>) onChatsReceived,
    Function(String)? onError,
  }) {
    try {
      // Step 1: Connect the socket if not already connected
      socketService.connect(
        userId: userId,
        userType: userType,
        onMessage: (_) {}, // Empty callback since we're only fetching chats
        onChatHistory: (_) {}, // Empty callback
      );

      // Set up error handling
      socketService.socket.on('error', (error) {
        onError?.call(error.toString());
      });

      socketService.socket.on('connect_error', (error) {
        onError?.call('Connection failed: ${error.toString()}');
      });

      // Step 2: Handle successful connection
      socketService.socket.on('connect', (_) {
        print('Socket connected successfully');
        socketService.socket.emit("getUserChats", {
          "userId": userId,
          "userType": userType,
        });
      });

      // Step 3: Listen for response
      socketService.socket.once("userChats", (data) {
        try {
          log('🟢 RESPONSE RECEIVED: userChats event');
          log('📦 Raw response data type: ${data.runtimeType}');
          log('📦 Raw response data: ${jsonEncode(data)}');

          if (data == null) {
            log('⚠️ Response data is null');
            onChatsReceived([]);
            return;
          }

          final chatList = (data as List)
              .map((json) => ChatSummaryModel.fromJson(json))
              .toList();
          onChatsReceived(chatList);
        } catch (e) {
          onError?.call('Failed to parse chat data: ${e.toString()}');
        }
      });

      // Handle timeout
      Future.delayed(Duration(seconds: 10), () {
        if (!socketService.socket.connected) {
          onError?.call('Connection timeout');
        }
      });

    } catch (e) {
      onError?.call('Failed to connect: ${e.toString()}');
    }
  } 

  /// Disconnect the socket
  void disconnectSocket() {
    socketService.disconnect();
  }
}







// import 'package:zyra_momments_app/app/data/web_socket/socket_services.dart';
// import 'package:zyra_momments_app/app/domain/entities/chat_message_model.dart';
// import 'package:zyra_momments_app/app/domain/entities/chat_summary_model.dart';

// class ChatRepository {
//   final SocketService socketService = SocketService();

//   /// Connect to the WebSocket and listen for incoming messages
//   void connectToSocket({
//     required String userId,
//     required String userType,
//     required Function(ChatMessageModel) onMessage,
//   }) {
//     socketService.connect(
//       userId: userId,
//       userType: userType,
//       onMessage: onMessage,
//     );
//   }

//   /// Send a message to the chat room
//   void sendMessage({
//     required String chatRoomId,
//     required String senderId,
//     required String senderType,
//     required String content,
//   }) {
//     socketService.sendMessage(
//       chatRoomId: chatRoomId,
//       senderId: senderId,
//       senderType: senderType,
//       content: content,
//     );
//   }

//   /// Request the chat history for a specific chat room
//   void getChatHistory(String chatRoomId) {
//     socketService.getChatHistory(chatRoomId);
//   }

//   /// Request all chats for the logged-in user
//   void getUserChats({
//   required String userId,
//   required String userType,
//   required Function(List<ChatSummaryModel>) onChatsReceived,
// }) {
//   // Step 1: Connect the socket if not already connected
//   socketService.connect(
//     userId: userId,
//     userType: userType,
//     onMessage: (_) {},
//   );

//   // Step 2: Use .on('connect') instead of .onConnect()
//   socketService.socket.on('connect', (_) {
//     socketService.socket.emit("getUserChats", {
//       "userId": userId,
//       "userType": userType,
//     });
//   });

//   // Step 3: Listen for response
//   socketService.socket.once("userChats", (data) {
//     final chatList = (data as List)
//         .map((json) => ChatSummaryModel.fromJson(json))
//         .toList();
//     onChatsReceived(chatList);
//   });
// }


//   /// Disconnect the socket
//   void disconnectSocket() {
//     socketService.disconnect();
//   }
// }
