import 'package:dartz/dartz.dart';
import 'package:zyra_momments_app/core/error/exeptions.dart';
import 'package:zyra_momments_app/core/error/failure.dart';
import 'package:zyra_momments_app/data/data_source/login_remote_data_source.dart';
import 'package:zyra_momments_app/domain/entities/login_entity.dart';
import 'package:zyra_momments_app/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource = LoginRemoteDataSourceImpl();
  
  @override
  Future<Either<Failure, ActiveUser>> login(String email, String password) async {
    try {
      final user = await loginRemoteDataSource.login(email, password);
      return Right(user);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(message: e.message));
    } on AuthenticationException catch (e) {
      return Left(AuthenticationFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}






// import 'package:dartz/dartz.dart';
// import 'package:zyra_momments_app/core/error/failure.dart';
// import 'package:zyra_momments_app/data/data_source/login_remote_data_source.dart';
// import 'package:zyra_momments_app/domain/entities/login_entity.dart';
// import 'package:zyra_momments_app/domain/repository/login_repository.dart';

// class LoginRepositoryImpl implements LoginRepository{
//   final LoginRemoteDataSource loginRemoteDataSource = LoginRemoteDataSourceImpl();
//   @override
//   Future<Either<Failure, ActiveUser>> login(String email, String password) async{
//      try{
//       final user = await loginRemoteDataSource.login(email, password);

//       return Right(user);
//      }catch(e){
//        return Left(ServerFailure(message:e.toString()));
//      }
   
//   }
// }