import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speedra/features/connectivity/domain/usecases/get_connectivity_status.dart';
import 'package:speedra/features/connectivity/presentation/bloc/connectivity_event.dart';
import 'package:speedra/features/connectivity/presentation/bloc/connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final GetConnectivityStatus getConnectivityStatus;
  late StreamSubscription _connectivitySubscription;

  ConnectivityBloc(this.getConnectivityStatus) : super(ConnectivityInitial()) {
    _connectivitySubscription = getConnectivityStatus().listen((either) {
      either.fold(
        (failure) => add(const ConnectivityChanged(false)),
        (isConnected) => add(ConnectivityChanged(isConnected)),
      );
    });

    on<ConnectivityChanged>((event, emit) {
      if (event.isConnected) {
        emit(ConnectivitySuccess());
      } else {
        emit(ConnectivityFailure());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
