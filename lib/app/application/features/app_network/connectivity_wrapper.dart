import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/app_network/bloc/connectivity_bloc.dart';
import 'package:zyra_momments_app/app/application/features/app_network/bloc/connectivity_state.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const ConnectivityWrapper({
    super.key,
    required this.child,
  });

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  bool _isDialogShowing = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityBloc, ConnectivityState>(
      listenWhen: (previous, current) {
        // Only trigger if:
        // 1. The bloc is initialized
        // 2. The state changed to require showing dialog
        // 3. We're not already showing a dialog
        return current.isInitialized && 
               current.shouldShowDialog && 
               !_isDialogShowing;
      },
      listener: (context, state) {
        if (state.shouldShowDialog) {
          _isDialogShowing = true;
          _showNoInternetDialog(context);
        }
      },
      child: widget.child,
    );
  }

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text(
                'Please turn on your internet connection to continue using the app.'),
            actions: [
              BlocListener<ConnectivityBloc, ConnectivityState>(
                listener: (context, state) {
                  if (state.isConnected) {
                    Navigator.of(context).pop();
                    _isDialogShowing = false;
                  }
                },
                child: TextButton(
                  onPressed: () {
                    if (context.read<ConnectivityBloc>().state.isConnected) {
                      Navigator.of(context).pop();
                      _isDialogShowing = false;
                    }
                  },
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        );
      },
    ).then((_) {
      _isDialogShowing = false;
    });
  }
}


// class SimpleConnectivityWrapper extends StatefulWidget {
//   final Widget child;

//   const SimpleConnectivityWrapper({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   @override
//   State<SimpleConnectivityWrapper> createState() => _SimpleConnectivityWrapperState();
// }

// class _SimpleConnectivityWrapperState extends State<SimpleConnectivityWrapper> {
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;
//   bool _isDialogShown = false;

//   @override
//   void initState() {
//     super.initState();
//     _startListening();
//   }

//   void _startListening() {
//     _connectivitySubscription = Connectivity().onConnectivityChanged.listen((result) {
//       print('Simple connectivity changed: $result'); // Debug log
      
//       if (result == ConnectivityResult.none) {
//         if (!_isDialogShown) {
//           _showDialog();
//         }
//       } else {
//         if (_isDialogShown) {
//           _dismissDialog();
//         }
//       }
//     });
//   }

//   void _showDialog() {
//     if (mounted && !_isDialogShown) {
//       _isDialogShown = true;
//       print('Showing simple dialog'); // Debug log
      
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext dialogContext) {
//           return AlertDialog(
//             title: const Text('No Internet Connection'),
//             content: const Text('Please turn on your internet connection.'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(dialogContext).pop();
//                   _isDialogShown = false;
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   void _dismissDialog() {
//     if (_isDialogShown) {
//       _isDialogShown = false;
//       if (mounted) {
//         Navigator.of(context).pop();
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }