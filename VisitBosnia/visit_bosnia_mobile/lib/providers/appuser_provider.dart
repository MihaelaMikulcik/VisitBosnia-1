import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
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

  static late AppUser userData;
  static late String role;

  @override
  AppUser fromJson(data) {
    // TODO: implement fromJson
    return AppUser.fromJson(data);
  }

  Future<dynamic> updateUserData(int id, [request]) async {
    try {
      var url = "${BaseProvider.baseUrl}AppUser/$id";
      var uri = Uri.parse(url);

      Map<String, String> headers = createHeaders();

      var response =
          await http!.put(uri, headers: headers, body: jsonEncode(request));
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
      }
    } catch (e) {
      return "Something went wrong";
    }
  }

  Future<dynamic> register(AppUserRegisterRequest request) async {
    var url = "${BaseProvider.baseUrl}AppUser/Register";
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
        return AppUser.fromJson(data);
      } else if (response.statusCode == 400) {
        return UserExceptionResponse.fromJson(json.decode(response.body));
      }
    } catch (e) {
      return "Something went wrong...";
    }
  }

  Future<List<Attraction>> recommendAttractions(
      int appUserId, int? categoryId) async {
    var url =
        "${BaseProvider.baseUrl}AppUser/RecommendAttractions?appUserId=${appUserId.toString()}&categoryId=${categoryId.toString()}";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
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
    var uri = Uri.parse(url);
    Map<String, String> headers = createHeaders();
    var response = await http!.get(uri, headers: headers);
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return data.map((x) => Event.fromJson(x)).cast<Event>().toList();
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }
}
