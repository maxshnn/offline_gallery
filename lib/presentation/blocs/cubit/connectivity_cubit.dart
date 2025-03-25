import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'connectivity_state.dart';

class ConnectivityCubit extends Cubit<ConnectivityState> {
  ConnectivityCubit() : super(ConnectivityInitial()) {
    _initialize();
  }

  void _initialize() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    _emitConnectionStatus(connectivityResult.last);

    Connectivity().onConnectivityChanged.listen((result) {
      _emitConnectionStatus(result.last);
    });
  }

  void _emitConnectionStatus(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      if (state is! ConnectivityConnected) {
        emit(ConnectivityConnected());
      }
    } else {
      emit(ConnectivityDisconnected());
    }
  }
}
