import 'package:equatable/equatable.dart';

class ConnectivityState extends Equatable {
  final bool isConnected;
  final bool shouldShowDialog;
  final bool isInitialized;

  const ConnectivityState({
    this.isConnected = true,
    this.shouldShowDialog = false,
    this.isInitialized = false,
  });

  ConnectivityState copyWith({
    bool? isConnected,
    bool? shouldShowDialog,
    bool? isInitialized,
  }) {
    return ConnectivityState(
      isConnected: isConnected ?? this.isConnected,
      shouldShowDialog: shouldShowDialog ?? this.shouldShowDialog,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  @override
  List<Object> get props => [isConnected, shouldShowDialog, isInitialized];
}