import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetWorkInfo{
  Future<bool>get  isConnected ;
}
class NetWorkInfoImpl implements NetWorkInfo{
  final InternetConnectionChecker connectionChecker;

  NetWorkInfoImpl(this.connectionChecker);
  @override
  // TODO: implement isConnected
  Future<bool> get isConnected =>connectionChecker.hasConnection;


}