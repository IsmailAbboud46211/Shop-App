import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'internet_connection_state.dart';

class InternetConnectionCubit extends Cubit<InternetConnectionState> {
  StreamSubscription? _streamSubscription;
  InternetConnectionCubit() : super(InternetConnectionInitial());

  void connected() => emit(InternetConnected());
  void disconnected() => emit(InternetDisconnected());
  void checkConnection() {
    _streamSubscription = Connectivity().onConnectivityChanged.listen((result) {
      if (result[0] == ConnectivityResult.none) {
        disconnected();
      } else {
        connected();
      }
    });
  }

  @override
  Future<void> close() {
    _streamSubscription!.cancel();
    return super.close();
  }
}
