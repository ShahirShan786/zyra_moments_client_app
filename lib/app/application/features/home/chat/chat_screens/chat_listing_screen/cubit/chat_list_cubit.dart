// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:zyra_momments_app/app/domain/entities/chat_summary_model.dart';
// import 'package:zyra_momments_app/app/domain/repository/chat_repository.dart';

// part 'chat_list_state.dart';

// class ChatListCubit extends Cubit<ChatListState> {
//   final ChatRepository repository;

//   ChatListCubit(this.repository) : super(ChatListInitial());

//   void loadUserChats(String userId, String userType) {
//     if (isClosed) return;
    
//     log("🚀 DEBUG: Starting to load user chats");
//     log("👤 DEBUG: UserId: $userId, UserType: $userType");
    
//     emit(ChatListLoadingState());
    
//     try {
//       repository.getUserChats(
//         userId: userId,
//         userType: userType,
//         onChatsReceived: (List<ChatSummaryModel> chats) {
//           log("📨 DEBUG: Received ${chats.length} chats in cubit");
//           if (!isClosed) {
//             if (chats.isEmpty) {
//               log("❌ DEBUG: No chats received - emitting empty state");
//             } else {
//               log("✅ DEBUG: Emitting loaded state with ${chats.length} chats");
//               for (var chat in chats) {
//                 log("💬 DEBUG: Chat - ${chat.recipientName}: ${chat.lastMessage}");
//               }
//             }
//             emit(ChatListLoadedState(chats: chats));
//           }
//         },
//         onError: (String error) {
//           log("❌ DEBUG: Error received in cubit: $error");
//           if (!isClosed) {
//             emit(ChatListFailureState(errorMessage: error));
//           }
//         },
//       );
//     } catch (e) {
//       log("❌ DEBUG: Exception in loadUserChats: $e");
//       if (!isClosed) {
//         emit(ChatListFailureState(errorMessage: e.toString()));
//       }
//     }
//   }

//   @override
//   Future<void> close() {
//     log("🔌 DEBUG: Closing ChatListCubit");
//     // Disconnect socket when cubit is closed
//     repository.disconnectSocket();
//     return super.close();
//   }
// }



import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:zyra_momments_app/app/domain/entities/chat_summary_model.dart';
import 'package:zyra_momments_app/app/domain/repository/chat_repository.dart';

part 'chat_list_state.dart';

class ChatListCubit extends Cubit<ChatListState> {
  final ChatRepository repository;

  ChatListCubit(this.repository) : super(ChatListInitial());

  void loadUserChats(String userId, String userType) {
    if (isClosed) return;
    
    emit(ChatListLoadingState());
    
    try {
      repository.getUserChats(
        userId: userId,
        userType: userType,
        onChatsReceived: (List<ChatSummaryModel> chats) {
          if (!isClosed) {
            emit(ChatListLoadedState(chats: chats));
          }
        },
        onError: (String error) {
          if (!isClosed) {
            emit(ChatListFailureState(errorMessage: error));
          }
        },
      );
    } catch (e) {
      if (!isClosed) {
        emit(ChatListFailureState(errorMessage: e.toString()));
      }
    }
  }

  @override
  Future<void> close() {
    // Disconnect socket when cubit is closed
    repository.disconnectSocket();
    return super.close();
  }
}