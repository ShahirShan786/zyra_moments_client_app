
// abstract class ChatRemoteDataSource {
//   Future<Either<Failure , List<ChatModel>>> getAllChatListFromRemoteDataSource();
// }

// class ChatRemoteDataSourceImpl implements ChatRemoteDataSource{

//    final client = http.Client();
//   @override
//   Future<Either<Failure, List<ChatModel>>> getAllChatListFromRemoteDataSource() async{
//      final userData = await SecureStorageHelper.loadUser();
//       final accessToken = userData['access_token'];
//       final userId = userData["id"];
//   //    try{
//   //      final url = ""
//   //      final response = 
//   //    }catch(e){}
//   // }
//   }}