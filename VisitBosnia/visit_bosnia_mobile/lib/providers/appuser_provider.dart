import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:visit_bosnia_mobile/exception/http_exception.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user_register.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/appUser/app_user.dart';

class AppUserProvider extends BaseProvider<AppUser> {
  AppUserProvider() : super("AppUser");

  late AppUser userData;

  @override
  AppUser fromJson(data) {
    // TODO: implement fromJson
    return AppUser.fromJson(data);
  }

  // @override
  // Future<AppUser?> update(int id, [request]) {
  //   // TODO: implement update
  //   try {
  //     return super.update(id, request);
  //   } catch (e) {
  //     if (e.toString().contains("Bad request")) {
  //       throw UserException(e.toString());
  //     }
  //   }
  //   throw ("Unexpected error...");
  // }

  void changeUserInfo(AppUser newUserData) {
    userData = newUserData;
    notifyListeners();
  }

  Future<AppUser> login(String username, String password) async {
    var response = null;
    var url =
        "https://10.0.2.2:44373/Login?Username=$username&Password=$password";
    //var url =
    //   "https://192.168.0.31/:44373/Login?Username=$username&Password=$password";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    try {
      response = await http!.get(uri, headers: headers);
      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        userData = AppUser.fromJson(data);
        return AppUser.fromJson(data);
      } else {
        throw Exception("Something went wrong!");
      }
    } catch (e) {
      if (response != null && response.body == "") {
        throw UserException("Username or password incorrect!");
      } else {
        throw UserException("Something went wrong, please try again later...");
      }
    }
  }

  Future<AppUser?> register(AppUserRegisterRequest request) async {
    const String url = "https://10.0.2.2:44373/AppUser/Register";
    try {
      final response = await http!.post(Uri.parse(url),
          body: jsonEncode(request.toJson()),
          headers: <String, String>{'Content-Type': 'application/json'});

      if (isValidResponseCode(response)) {
        var data = jsonDecode(response.body);
        userData = AppUser.fromJson(data);
        return AppUser.fromJson(data);
      }
    } catch (e) {
      if (e.toString().contains("Bad request")) {
        throw UserException("Username already exists!");
      } else {
        rethrow;
      }
    }
  }
}
