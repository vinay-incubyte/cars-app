import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;
  const NetworkInfoImpl({required this.connectionChecker});

  @override
  Future<bool> isConnected() async{
    return await connectionChecker.hasConnection;
  }
}
