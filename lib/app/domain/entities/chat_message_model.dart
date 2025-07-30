class ChatMessageModel {
  final String chatRoomId;
  final String senderId;
  final String content;
  final DateTime sendAt;
  final String senderType;
  final bool? isRead;

  ChatMessageModel({
    required this.chatRoomId,
    required this.senderId,
    required this.content,
    required this.sendAt,
    required this.senderType,
    this.isRead,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      chatRoomId: json['chatRoomId'] ?? '',
      senderId: json['senderId'] ?? '',
      content: json['content'] ?? '',
      sendAt: DateTime.parse(json['sendAt'] ?? DateTime.now().toIso8601String()),
      senderType: json['senderType'] ?? '',
      isRead: json['isRead'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'senderId': senderId,
      'content': content,
      'sendAt': sendAt.toIso8601String(),
      'senderType': senderType,
      'isRead': isRead,
    };
  }

  // Add copyWith method for updating isRead status
  ChatMessageModel copyWith({
    String? chatRoomId,
    String? senderId,
    String? content,
    DateTime? sendAt,
    String? senderType,
    bool? isRead,
  }) {
    return ChatMessageModel(
      chatRoomId: chatRoomId ?? this.chatRoomId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      sendAt: sendAt ?? this.sendAt,
      senderType: senderType ?? this.senderType,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChatMessageModel &&
        other.chatRoomId == chatRoomId &&
        other.senderId == senderId &&
        other.content == content &&
        other.sendAt == sendAt &&
        other.senderType == senderType &&
        other.isRead == isRead;
  }

  @override
  int get hashCode {
    return chatRoomId.hashCode ^
        senderId.hashCode ^
        content.hashCode ^
        sendAt.hashCode ^
        senderType.hashCode ^
        isRead.hashCode;
  }
}







// class ChatMessageModel {
//   final String chatRoomId;
//   final String senderId;
//   final String senderType;
//   final String content;
//   final DateTime sendAt;
//   final bool isRead;
//   final String? id;

//   ChatMessageModel({
//     required this.chatRoomId,
//     required this.senderId,
//     required this.senderType,
//     required this.content,
//     required this.sendAt,
//     this.isRead = false,
//     this.id,
//   });

//   factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
//     return ChatMessageModel(
//       id: json['_id']?.toString(),
//       chatRoomId: json['chatRoomId']?.toString() ?? '',
//       senderId: json['senderId']?.toString() ?? '',
//       senderType: json['senderType']?.toString() ?? '',
//       content: json['content']?.toString() ?? '',
//       sendAt: json['createdAt'] != null 
//           ? DateTime.parse(json['createdAt'].toString())
//           : DateTime.now(),
//       isRead: json['read'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() => {
//     if (id != null) '_id': id,
//     'chatRoomId': chatRoomId,
//     'senderId': senderId,
//     'senderType': senderType,
//     'content': content,
//     'createdAt': sendAt.toIso8601String(),
//     'read': isRead,
//   };
// }


// // // lib/domain/entities/chat_message_model.dart

// // class ChatMessageModel {
// //   final String chatRoomId;
// //   final String senderId;
// //   final String content;
// //   final DateTime sendAt;

// //   ChatMessageModel({
// //     required this.chatRoomId,
// //     required this.senderId,
// //     required this.content,
// //     required this.sendAt,
// //   });

// //   factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
// //     return ChatMessageModel(
// //       chatRoomId: json['chatRoomId'],
// //       senderId: json['senderId'],
// //       content: json['content'],
// //       sendAt: DateTime.parse(json['sendAt']),
// //     );
// //   }
// // }
