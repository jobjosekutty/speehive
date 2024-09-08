// Define a base failure class
import 'dart:io';

import 'package:http/http.dart';

abstract class Failure {
  String get message;
}

// Define specific failure enums extending the base failure class
class ServerFailure extends Failure {
  final String msg;
  ServerFailure({required this.msg});
  @override
  String get message => msg;
}

class CacheFailure extends Failure {
  @override
  String get message => 'Cache Failure';
}

class NetworkFailure extends Failure {
  @override
  String get message => 'No Internet Connection';
}

class UnknownFailure extends Failure {
  @override
  String get message => 'Unknown Failure';
}

class ExceptionFailure extends Failure {
  @override
  String get message => 'Exception Failure';
}

class NotFoundFailure extends Failure {
  @override
  String get message => 'Not Found Failure';
}

class ServerErrorFailure extends Failure {
  @override
  String get message => 'Server Error Failure';
}

class StatusCodeFailure extends Failure {
  final String msg;
  StatusCodeFailure(this.msg);
  @override
  String get message => msg;
}

class UnAuthorizedFailure extends Failure {
  final String msg;
  UnAuthorizedFailure({required this.msg});
  @override
  String get message => msg;
}

class FormatException extends Failure {
  @override
  String get message => 'Format exception';
}

Failure handleStatusCode(int statusCode, String? message) {
  // ignore: avoid_print, unnecessary_brace_in_string_interps
  print("error===${statusCode}");
  switch (statusCode) {
    case 401:
      return UnAuthorizedFailure(msg: message ?? 'UnAuthorized Access');
    case 404:
      return NotFoundFailure();
    case 500:
      return ServerErrorFailure();
    default:
      return StatusCodeFailure(message ?? 'An error occurred');
  }
}

Failure handleException(Object e) {
  if (e is ClientException && e is SocketException) {
    return NetworkFailure();
  } else {
    return UnknownFailure();
  }
}
