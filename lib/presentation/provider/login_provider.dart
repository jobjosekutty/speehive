// ignore_for_file: avoid_print
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speehive/data/repository/login_repo.dart';

import '../../core/error_handler.dart';

@injectable
class LoginProvider extends ChangeNotifier {
   final LoginRepo _loginRepo;

  LoginProvider({required LoginRepo loginRepo}) : _loginRepo = loginRepo;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Failure? _failure;

  Failure? get homeFailure => _failure;
  set setFailure(Failure? value) {
    _failure = value;
    notifyListeners();
  }

  bool loginSucess = false;

  Future<void> login(String username,String password) async {
 
      setLoading = true;
       setFailure =null;
    final res = await _loginRepo.login(username,password);
    res.fold((error) {
      log(error.toString());
     
      setFailure = error;
      setLoading = false;
    }, (data) async{
      // ignore: unnecessary_brace_in_string_interps
      print("========${data}");
      final SharedPreferences preferences = await SharedPreferences.getInstance();
           preferences.setString("token",data);
           
      loginSucess =true;
     notifyListeners();
      setLoading = false;
    });
  }

}