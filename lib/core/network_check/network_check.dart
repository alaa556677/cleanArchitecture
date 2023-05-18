import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkCheck{
  Future <bool> get isConnected;
}

class NetworkCheckImplementation implements NetworkCheck{
  late InternetConnectionChecker connectionChecker;
  NetworkCheckImplementation({required this.connectionChecker});
  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}