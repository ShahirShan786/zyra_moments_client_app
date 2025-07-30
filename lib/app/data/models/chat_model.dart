// lib/domain/models/chat_model.dart


class ChatModel {
  final String id;
  final List<String> participants;
  final MessageModel? lastMessage;

  ChatModel({
    required this.id,
    required this.participants,
    this.lastMessage,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['_id'],
      participants: List<String>.from(json['participants']),
      lastMessage: json['lastMessage'] != null
          ? MessageModel.fromJson({
              "_id": "",
              "senderId": "",
              "content": json['lastMessage']['content'],
              "sendAt": json['lastMessage']['sendAt']
            })
          : null,
    );
  }
}


// lib/domain/models/chat_message_model.dart

class MessageModel {
  final String id;
  final String senderId;
  final String content;
  final DateTime sendAt;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.content,
    required this.sendAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] ?? '',
      senderId: json['senderId'] ?? '',
      content: json['content'],
      sendAt: DateTime.parse(json['sendAt']),
    );
  }
}
