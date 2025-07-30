abstract class ConnectivityRepository {
  Stream<bool> get connectivityStream;
  Future<bool> get isConnected;
  Future<bool> hasInternetConnection();
}