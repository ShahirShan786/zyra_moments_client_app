
class ChatSummaryModel {
  final String chatRoomId;
  final String recipientId;
  final String recipientName;
  final String? recipientAvatar;
  final String? lastMessage;
  final DateTime? lastMessageTime;
  final int unreadCount;
  final String recipientStatus;
  final DateTime updatedAt;

  ChatSummaryModel({
    required this.chatRoomId,
    required this.recipientId,
    required this.recipientName,
    this.recipientAvatar,
    this.lastMessage,
    this.lastMessageTime,
    required this.unreadCount,
    required this.recipientStatus,
    required this.updatedAt,
  });

  factory ChatSummaryModel.fromJson(Map<String, dynamic> json) {
    return ChatSummaryModel(
      chatRoomId: json['chatRoomId'],
      recipientId: json['recipientId'],
      recipientName: json['recipientName'],
      recipientAvatar: json['recipientAvatar'],
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'] != null
          ? DateTime.tryParse(json['lastMessageTime'])
          : null,
      unreadCount: json['unreadCount'] ?? 0,
      recipientStatus: json['recipientStatus'],
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatRoomId': chatRoomId,
      'recipientId': recipientId,
      'recipientName': recipientName,
      'recipientAvatar': recipientAvatar,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime?.toIso8601String(),
      'unreadCount': unreadCount,
      'recipientStatus': recipientStatus,
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ChatSummaryModel(chatRoomId: $chatRoomId, recipientName: $recipientName)';
  }
}



// // lib/domain/entities/chat_summary_model.dart

// class ChatSummaryModel {
//   final String chatRoomId;
//   final List<String> participants;
//   final String? lastMessage;
//   final DateTime? lastMessageTime;

//   ChatSummaryModel({
//     required this.chatRoomId,
//     required this.participants,
//     this.lastMessage,
//     this.lastMessageTime,
//   });

//   factory ChatSummaryModel.fromJson(Map<String, dynamic> json) {
//     return ChatSummaryModel(
//       chatRoomId: json['chatRoomId'],
//       participants: List<String>.from(json['participants']),
//       lastMessage: json['lastMessage']?['content'],
//       lastMessageTime: json['lastMessage']?['sendAt'] != null
//           ? DateTime.parse(json['lastMessage']['sendAt'])
//           : null,
//     );
//   }
// }
