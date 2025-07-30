import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/chat_screens/chat_listing_screen/cubit/chat_list_cubit.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/chat_screens/chat_listing_screen/widgets/build_chatList_shimmer.dart';
import 'package:zyra_momments_app/app/application/features/home/chat/chat_screens/chat_listing_screen/widgets/build_chat_list.dart';
import 'package:zyra_momments_app/app/domain/repository/chat_repository.dart';
import 'package:zyra_momments_app/application/config/theme.dart';
import 'package:zyra_momments_app/application/config/widgets/app_text.dart';

class ChatListingScreen extends StatelessWidget {
  final String userId;
  final String userType;
  
  const ChatListingScreen({
    super.key, 
    required this.userId, 
    required this.userType
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => 
          ChatListCubit(ChatRepository())..loadUserChats(userId, userType),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      foregroundColor: AppTheme.darkTextColorSecondary,
      title: CustomText(
        text: "Chats",
        fontSize: 25,
        fontWeight: FontWeight.w500,
      ),
      backgroundColor: AppTheme.darkSecondaryColor,
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<ChatListCubit, ChatListState>(
      builder: (context, state) {
        if (state is ChatListLoadingState) {
          return buildChatListShimmer(context);
        } else if (state is ChatListFailureState) {
          return _buildErrorState(context, state);
        } else if (state is ChatListLoadedState) {
          
          return buildChatList(context, state.chats, userId , userType);
        }
        return const SizedBox();
      },
    );
  }

  

  Widget _buildErrorState(BuildContext context, ChatListFailureState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(text: state.errorMessage),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<ChatListCubit>().loadUserChats(userId, userType);
            },
            child: const CustomText(text: "Retry"),
          ),
        ],
      ),
    );
  }
}


