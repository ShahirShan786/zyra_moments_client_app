  import 'package:flutter/material.dart';
import 'package:zyra_momments_app/app/domain/entities/chat_message_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildMessagesList(List<ChatMessageModel> messages ,ScrollController scrollController  , String currentUserId , String? recipientAvatar , String recipientName) {
    if (messages.isEmpty) {
      return const Center(
        child: Text(
          'No messages yet\nStart a conversation!',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        final isMe = message.senderId == currentUserId;

        return _buildMessageBubble(message, isMe , recipientAvatar , recipientName , context);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessageModel message, bool isMe,
   String? recipientAvatar , String recipientName , BuildContext context
  ) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (!isMe) ...[
              CircleAvatar(
                radius: 16,
                backgroundColor: Colors.grey[800],
                backgroundImage: recipientAvatar != null
                    ? NetworkImage(recipientAvatar)
                    : null,
                child: recipientAvatar == null
                    ? Text(
                        recipientName.isNotEmpty
                            ? recipientName[0].toUpperCase()
                            : 'U',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      )
                    : null,
              ),
              const SizedBox(width: 8),
            ],
            Flexible(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: isMe
                      ? AppTheme.darkTextColorSecondary
                      : AppTheme.darkSecondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: message.content,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isMe
                          ? AppTheme.darkBlackColor
                          : AppTheme.darkTextColorSecondary,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: _formatTime(message.sendAt),
                          color:
                              isMe ? AppTheme.darkBlackColor : Colors.grey[400],
                          fontSize: 12,
                        ),
                        if (isMe) ...[
                          const SizedBox(width: 4),
                          _buildSeenTick(message.isRead ?? false),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (isMe) const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildSeenTick(bool isRead) {
    return Icon(
      isRead ? Icons.done_all : Icons.done,
      size: 16,
      color: isRead ? Colors.lightBlue : Colors.white70,
    );
  }

  
  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else if (difference.inHours > 0) {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }
