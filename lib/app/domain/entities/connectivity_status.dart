// lib/domain/entities/connectivity_status.dart
import 'package:equatable/equatable.dart';

enum NetworkStatus { connected, disconnected }

class ConnectivityStatus extends Equatable {
  final NetworkStatus status;
  final String? connectionType;

  const ConnectivityStatus({
    required this.status,
    this.connectionType,
  });

  @override
  List<Object?> get props => [status, connectionType];
}