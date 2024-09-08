// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../core/error_handler.dart';
import 'package:dartz/dartz.dart';
import "package:http/http.dart" as http;

abstract class LoginRepo {
  Future<Either<Failure, String>> login(String username,String password);
}
@LazySingleton(as: LoginRepo)
class LoginRepoImpl extends LoginRepo {
  
  @override
  Future<Either<Failure, String>> login(String username,String password) async {
    try {
      final response = await http.post(Uri.parse("https://focali-uat.azurewebsites.net/connect/token"), headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': 'application/json',
    },
    body: {
      'grant_type': 'password',
      'scope': 'offline_access AgencyPlatform',
      'username': username,
      'password': password,
      'client_id': 'AgencyPlatform_App',
      'client_secret': '1q2w3e*',
    },);
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);

        if (responseBody.containsKey('access_token')) {
          final String accessToken = responseBody['access_token'];
          return Right(accessToken);
        } else {
          return Left(handleStatusCode(response.statusCode, "No access token found in response"));
        }
      } else {
        return Left(handleStatusCode(response.statusCode, "error"));
      }
    } catch (e) {
      print(e);
      return Left(handleException(e));
    }
  }
}
