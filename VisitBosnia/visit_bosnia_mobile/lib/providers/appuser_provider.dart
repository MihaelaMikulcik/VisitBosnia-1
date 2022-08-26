import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:visit_bosnia_mobile/exception/http_exception.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user_change_pass_request.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user_register.dart';
import 'package:visit_bosnia_mobile/model/attractions/attraction.dart';
import 'package:visit_bosnia_mobile/model/events/event.dart';
import 'package:visit_bosnia_mobile/model/tourist_facility.dart';
import 'package:visit_bosnia_mobile/providers/appuser_role_provider.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../model/UserExceptionResponse.dart';
import '../model/appUser/app_user.dart';
import '../model/roles/appuser_role_search_object.dart';

class AppUserProvider extends BaseProvider<AppUser> {
  AppUserProvider() : super("AppUser");

  // late AppUser userData;
  static late AppUser userData;
  static late String role;

  @override
  AppUser fromJson(data) {
    // TODO: implement fromJson
    return AppUser.fromJson(data);
  }

  Future<dynamic> updateUserData(int id, [request]) async {
    // TODO: implement update
    try {
      var url = "${BaseProvider.baseUrl}AppUser/$id";
      var uri = Uri.parse(url);

      Map<String, String> headers = createHeaders();

      var response =
          await http!.put(uri, headers: headers, body: jsonEncode(request));
      // var response = await update(id, request);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        userData = AppUser.fromJson(data);
        return AppUser.fromJson(data);
      } else if (response.statusCode == 400) {
        return UserExceptionResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      return "Something went wrong...";
    }
  }

  void changeUserInfo(AppUser newUserData) {
    userData = newUserData;
    notifyListeners();
  }

  Future<dynamic> login(String username, String password) async {
    var response = null;
    var url =
        "${BaseProvider.baseUrl}Login?Username=$username&Password=$password";
    // var url =
    //     "https://10.0.2.2:44373/Login?Username=$username&Password=$password";
    // var url =
    //     "https://192.168.0.24/:44373/Login?Username=$username&Password=$password";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    try {
      response = await http!.get(uri, headers: headers);
      if (isValidResponseCode(response)) {
        if (response.body != "") {
          var data = jsonDecode(response.body);
          userData = AppUser.fromJson(data);
          return AppUser.fromJson(data);
        } else {
          return "Username or password incorrect";
        }
      } else {
        return "Something went wrong";
        // throw Exception("Something went wrong!");
      }
    } catch (e) {
      return "Something went wrong";
      // if (response != null && response.body == "") {
      //   throw UserException("Username or password incorrect!");
      // } else {
      //   throw UserException("Something went wrong, please try again later...");
      // }
    }
  }

  Future<dynamic> register(AppUserRegisterRequest request) async {
    var url = "${BaseProvider.baseUrl}AppUser/Register";
    // const String url = "https://10.0.2.2:44373/AppUser/Register";
    try {
      final response = await http!.post(Uri.parse(url),
          body: jsonEncode(request.toJson()),
          headers: <String, String>{'Content-Type': 'application/json'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        userData = AppUser.fromJson(data);
        return AppUser.fromJson(data);
      } else if (response.statusCode == 400) {
        return UserExceptionResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      return "Something went wrong...";
      // if (e.toString().contains("Bad request")) {
      //   throw UserException("Username already exists!");
      // } else {
      //   rethrow;
      // }
    }
  }

  Future<dynamic> changePassword(AppUserChangePasswordRequest request) async {
    var url = "${BaseProvider.baseUrl}AppUser/ChangePassword";
    try {
      var uri = Uri.parse(url);
      Map<String, String> headers = createHeaders();
      final response = await http!
          .post(uri, body: jsonEncode(request.toJson()), headers: headers);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Authorization.password = request.newPassword;
        // userData = AppUser.fromJson(data);
        return AppUser.fromJson(data);
      } else if (response.statusCode == 400) {
        return UserExceptionResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      return "Something went wrong...";
    }
  }

  // Future<AppUser?> register(AppUserRegisterRequest request) async {
  //   var url = "${BaseProvider.baseUrl}AppUser/Register";
  //   // const String url = "https://10.0.2.2:44373/AppUser/Register";
  //   try {
  //     final response = await http!.post(Uri.parse(url),
  //         body: jsonEncode(request.toJson()),
  //         headers: <String, String>{'Content-Type': 'application/json'});

  //     if (isValidResponseCode(response)) {
  //       var data = jsonDecode(response.body);
  //       userData = AppUser.fromJson(data);
  //       return AppUser.fromJson(data);
  //     }
  //   } catch (e) {
  //     if (e.toString().contains("Bad request")) {
  //       throw UserException("Username already exists!");
  //     } else {
  //       rethrow;
  //     }
  //   }
  // }

  Future<List<Attraction>> recommendAttractions(
      int appUserId, int? categoryId) async {
    var url =
        "${BaseProvider.baseUrl}AppUser/RecommendAttractions?appUserId=${appUserId.toString()}&categoryId=${categoryId.toString()}";
    // var url =
    //     "https://10.0.2.2:44373/AppUser/RecommendAttractions?appUserId=${appUserId.toString()}&categoryId=${categoryId.toString()}";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    var response = await http!.get(uri, headers: headers);
    // print("done $response");
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      // return Attraction.fromJson(data);
      return data
          .map((x) => Attraction.fromJson(x))
          .cast<Attraction>()
          .toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<List<Event>> recommendEvents(int appUserId, int? categoryId) async {
    var url =
        "${BaseProvider.baseUrl}AppUser/RecommendEvents?appUserId=${appUserId.toString()}&categoryId=${categoryId.toString()}";
    // var url =
    //     "https://10.0.2.2:44373/AppUser/RecommendAttractions?appUserId=${appUserId.toString()}&categoryId=${categoryId.toString()}";
    var uri = Uri.parse(url);
    Map<String, String> headers = createHeaders();
    var response = await http!.get(uri, headers: headers);
    // print("done $response");
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      // return Attraction.fromJson(data);
      return data.map((x) => Event.fromJson(x)).cast<Event>().toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
