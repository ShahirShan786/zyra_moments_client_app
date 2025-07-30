
  import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/chat_screens/chat_listing_screen/cubit/chat_list_cubit.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/chat_screens/chat_screen/chat_screen.dart';
import 'package:zyra_momments_app/app/domain/entities/chat_summary_model.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

Widget buildChatList(BuildContext context, List<ChatSummaryModel> chats, String userId , String userType) {
    if (chats.isEmpty) {
      return const Center(
        child: CustomText(text: "No chats found"),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<ChatListCubit>().loadUserChats(userId, userType);
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return _buildChatListItem(context, chat);
        },
      ),
    );
  }

  Widget _buildChatListItem(BuildContext context, ChatSummaryModel chat) {
    final width = MediaQuery.of(context).size.width;

    return Card(
      color: AppTheme.darkSecondaryColor,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: chat.recipientAvatar != null
            ? CircleAvatar(
                radius: width * 0.075,
                backgroundImage: NetworkImage(chat.recipientAvatar!),
              )
            : CircleAvatar(
                radius: width * 0.075,
                backgroundColor: AppTheme.darkPrimaryColor,
                child: CustomText(
                  text: chat.recipientName.isNotEmpty
                      ? chat.recipientName[0].toUpperCase()
                      : "U",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        title: CustomText(
          text: chat.recipientName,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        subtitle: CustomText(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          text: chat.lastMessage ?? "No messages yet",
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: _formatTime(chat.lastMessageTime),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            if (chat.unreadCount > 0) ...[
              const SizedBox(height: 4),
              CircleAvatar(
                radius: width * 0.035,
                backgroundColor: Colors.blueAccent,
                child: CustomText(
                  text: chat.unreadCount.toString(),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                chatRoomId: chat.chatRoomId,
                currentUserId: chat.recipientId,
                currentUserType: "Client",
                recipientName: chat.recipientName,
              ),
            ),
          );
        },
      ),
    );
  }

  String _formatTime(DateTime? time) {
    if (time == null) return "";

    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}m ago";
    } else {
      return "Now";
    }
  }
