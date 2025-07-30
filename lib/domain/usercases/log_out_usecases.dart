import 'package:zyra_momments_app/data/repository/log_out_repository_impl.dart';

import 'package:zyra_momments_app/domain/repository/log_out_repository.dart';


class LogOutUsecases {
LogOutRepository logOutRepository = LogOutRepositoryImpl();
  Future<void> logOutCall(String accessToken , String refreshToken){
  return logOutRepository.logOut(accessToken, refreshToken);
  }
}
