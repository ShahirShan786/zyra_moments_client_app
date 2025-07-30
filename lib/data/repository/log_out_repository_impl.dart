import 'package:zyra_momments_app/data/data_source/log_out_remote_data_source.dart';
import 'package:zyra_momments_app/domain/repository/log_out_repository.dart';

class LogOutRepositoryImpl implements LogOutRepository{
  LogOutRemoteDataSource logOutRemoteDataSource = LogOutRemoteDataSourceImpl();
  @override
  Future<void> logOut(String accessToken, String refreshToken) {
    return logOutRemoteDataSource.logOut(accessToken, refreshToken);
    
  }
}