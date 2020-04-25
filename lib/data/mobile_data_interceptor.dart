import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:connectivity/connectivity.dart';

class MobileDataInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final connectivityResult = await Connectivity().checkConnectivity();
    final isMobile = connectivityResult == ConnectivityResult.mobile;
    final isWifi = connectivityResult == ConnectivityResult.wifi;
    final isLargeFile = request.url.contains(RegExp(r'(/large|/video|/posts)'));

    if (isMobile) {
      throw MobileDataCostException();

    }else if (isWifi){
      throw WifiDataCostException();

    }else{
      throw NoDataCostException();
    }
    return request;

  }
}

class MobileDataCostException {
  final message = "Warning !! Download Large File with LTE Internet .";

  @override
  String toString() => message;
}
class WifiDataCostException {
  final message = "OK !! Download Large File with WIFI Internet .";

  @override
  String toString() => message;
}
class NoDataCostException {
  final message = "No Internet .";

  @override
  String toString() => message;
}
