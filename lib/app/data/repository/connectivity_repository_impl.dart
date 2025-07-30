// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:zyra_momments_app/app/domain/repository/connectivity_repository.dart';

// class ConnectivityRepositoryImpl implements ConnectivityRepository {
//   final Connectivity _connectivity;
//   final InternetConnectionChecker _internetChecker;
//   StreamController<bool>? _controller;

//   ConnectivityRepositoryImpl({
//     Connectivity? connectivity,
//     InternetConnectionChecker? internetChecker,
//   })  : _connectivity = connectivity ?? Connectivity(),
//         _internetChecker = internetChecker ?? InternetConnectionChecker();

//   @override
//   Stream<bool> get connectivityStream {
//     _controller ??= StreamController<bool>.broadcast();
    
//     _connectivity.onConnectivityChanged.listen((result) async {
//       if (result == ConnectivityResult.none) {
//         _controller?.add(false);
//       } else {
//         final hasInternet = await _internetChecker.hasConnection;
//         _controller?.add(hasInternet);
//       }
//     });
    
//     return _controller!.stream;
//   }

//   @override
//   Future<bool> get isConnected async {
//     final result = await _connectivity.checkConnectivity();
//     if (result == ConnectivityResult.none) return false;
//     return await _internetChecker.hasConnection;
//   }

//   @override
//   Future<bool> hasInternetConnection() => _internetChecker.hasConnection;

//   void dispose() {
//     _controller?.close();
//     _controller = null;
//   }
// }