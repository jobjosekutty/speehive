import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:speehive/data/repository/item_repo.dart';

import '../../core/error_handler.dart';
import '../../data/models/item_model.dart';

@injectable
class ItemProvider extends ChangeNotifier {
   final ItemRepo _itemRepo;

  ItemProvider({required ItemRepo itemRepo}) : _itemRepo = itemRepo;

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

 ItemDetailsModel? details;

  Future<void> getItem() async {
 
      setLoading = true;
       setFailure =null;
    final res = await _itemRepo.getItem();
    res.fold((error) {
      log(error.toString());
     
      setFailure = error;
      setLoading = false;
    }, (data) {

      // log(data.students.toString());
       details = data;
      // print(students?.toJson())
     notifyListeners();
      setLoading = false;
    });
  }

}