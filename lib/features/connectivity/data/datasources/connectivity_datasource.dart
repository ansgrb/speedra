import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityDataSource {
  Stream<bool> get isConnected;
}

class ConnectivityDataSourceImpl implements ConnectivityDataSource {
  final Connectivity connectivity;

  ConnectivityDataSourceImpl(this.connectivity);

  @override
  Stream<bool> get isConnected {
    return connectivity.onConnectivityChanged.map((result) {
      return result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile);
    });
  }
}
