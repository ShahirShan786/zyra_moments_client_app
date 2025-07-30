import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/chat_screens/chat_screen/bloc/chat_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/widgets/build_app_bar.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/widgets/build_chat_shimmer_loading.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/widgets/build_message_input.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/widgets/build_message_list.dart';

class ChatScreen extends StatefulWidget {
  final String chatRoomId;
  final String currentUserId;
  final String currentUserType;
  final String recipientName;
  final String? recipientAvatar;

  const ChatScreen({
    super.key,
    required this.chatRoomId,
    required this.currentUserId,
    required this.currentUserType,
    required this.recipientName,
    this.recipientAvatar,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  void _initializeChat() async {
    context.read<ChatBloc>().add(ConnectToSocketEvnet(
          userId: widget.currentUserId,
          userType: widget.currentUserType,
        ));

    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      context.read<ChatBloc>().add(GetChatHistoryEvent(
            chatRoomId: widget.chatRoomId,
          ));
      _isInitialized = true;
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    context.read<ChatBloc>().add(DisconnectSocketEvent());
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      context.read<ChatBloc>().add(SendMessageEvent(
            chatRoomId: widget.chatRoomId,
            senderId: widget.currentUserId,
            senderType: widget.currentUserType,
            content: message,
          ));
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _markMessagesAsRead() {
    context.read<ChatBloc>().add(MarkMessageAsReadEvent(
          chatRoomId: widget.chatRoomId,
          userId: widget.currentUserId,
          userType: widget.currentUserType,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: buildChatAppBar(context , widget.recipientAvatar , widget.recipientName),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is MessageSentState ||
                    state is MessageReceivedState) {
                  _scrollToBottom();
                }
                if (state is ChatLoadedState) {
                  Future.delayed(const Duration(milliseconds: 500), () {
                    _markMessagesAsRead();
                    _scrollToBottom();
                  });
                }
              },
              builder: (context, state) {
                if (state is ChatLoadigState && !_isInitialized) {
                  return buildChatShimmerLoading();
                }

                if (state is ChatErrorState) {
                  return _buildErrorState(state , _initializeChat);
                }

                if (state is ChatLoadedState) {
                  return buildMessagesList(
                      state.messages,
                      _scrollController,
                      widget.currentUserId,
                      widget.recipientAvatar,
                      widget.recipientName);
                }

                return buildMessagesList(
                  [],
                  _scrollController,
                  widget.currentUserId,
                  widget.recipientAvatar,
                  widget.recipientName,
                );
              },
            ),
          ),
          buildMessageInput(_messageController , _sendMessage , context),
        ],
      ),
    );
  }
}



Widget _buildErrorState(ChatErrorState state ,VoidCallback initializeChat ) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 64,
        ),
        const SizedBox(height: 16),
        const Text(
          'Error loading chat',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          state.error,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: initializeChat,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF007AFF),
          ),
          child: const Text(
            'Retry',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    ),
  );
}











