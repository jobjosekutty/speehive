// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/app_url.dart';
import '../../core/error_handler.dart';
import '../models/item_model.dart';
import 'package:dartz/dartz.dart';
import "package:http/http.dart" as http;

abstract class ItemRepo {
  Future<Either<Failure, ItemDetailsModel>> getItem();
}
@LazySingleton(as: ItemRepo)
class ItemRepoImpl extends ItemRepo {
  
  @override
  Future<Either<Failure, ItemDetailsModel>> getItem() async {
     final SharedPreferences preferences = await SharedPreferences.getInstance();
       var auth = preferences.getString("token");
    try {
      
      final response = await http.get(Uri.parse(AppUrl.ApiUrl),headers: {'Authorization': 'Bearer ${auth}',});
      if (response.statusCode == 200) { 
       final data = itemDetailsModelFromJson(response.body);
       return Right(data);
      } else {
        return Left(handleStatusCode(response.statusCode, "error"));
      }
    } catch (e) {
      print(e);
      return Left(handleException(e));
    }
  }
}
