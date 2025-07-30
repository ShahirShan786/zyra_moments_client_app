import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zyra_momments_app/app/application/features/app_network/bloc/connectivity_event.dart';
import 'package:zyra_momments_app/app/application/features/app_network/bloc/connectivity_state.dart';
import 'package:zyra_momments_app/app/domain/repository/connectivity_repository.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityRepository _connectivityRepository;
  StreamSubscription<bool>? _connectivitySubscription;

  ConnectivityBloc({
    required ConnectivityRepository connectivityRepository,
  })  : _connectivityRepository = connectivityRepository,
        super(const ConnectivityState()) {
    on<ConnectivityStarted>(_onConnectivityStarted);
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  Future<void> _onConnectivityStarted(
    ConnectivityStarted event,
    Emitter<ConnectivityState> emit,
  ) async {
    // Check initial connection status
    final isConnected = await _connectivityRepository.isConnected;
    emit(state.copyWith(
      isConnected: isConnected,
      isInitialized: true,
    ));

    // Listen for changes
    _connectivitySubscription = _connectivityRepository.connectivityStream.listen(
      (isConnected) {
        add(ConnectivityChanged(isConnected: isConnected));
      },
      onError: (error) {
        add(ConnectivityChanged(isConnected: false));
      },
    );
  }

  void _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    // Only show dialog when connection is lost (not when regained)
    if (!event.isConnected) {
      emit(state.copyWith(
        isConnected: false,
        shouldShowDialog: true,
      ));
    } else {
      emit(state.copyWith(
        isConnected: true,
        shouldShowDialog: false,
      ));
    }
  }

  @override
  Future<void> close() {
    _connectivitySubscription?.cancel();
    return super.close();
  }
}