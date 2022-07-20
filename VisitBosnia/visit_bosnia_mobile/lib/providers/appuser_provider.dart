import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user_register.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

import '../model/appUser/app_user.dart';

class AppUserProvider extends BaseProvider<AppUser> {
  AppUserProvider() : super("AppUser");

  @override
  AppUser fromJson(data) {
    // TODO: implement fromJson
    return AppUser();
  }

  Future<AppUser> login(String username, String password) async {
    var url =
        "https://10.0.2.2:44373/Login?Username=$username&Password=$password";
    // var url =
    //     "https://192.168.0.31/:44373Login?Username=$username&Password=$password";
    var uri = Uri.parse(url);

    Map<String, String> headers = createHeaders();
    print("get me");
    var response = await http!.get(uri, headers: headers);
    print("done $response");
    if (isValidResponseCode(response)) {
      var data = jsonDecode(response.body);
      return AppUser.fromJson(data);

      //return data;
    } else {
      throw Exception("Exception... handle this gracefully");
    }
  }

  Future<AppUser?> register(AppUserRegisterRequest request) async {
    final String baseUrl = "https://10.0.2.2:44373/AppUser/Register";
    final response = await http!.post(Uri.parse(baseUrl),
        body: jsonEncode(request.toJson()),
        headers: <String, String>{'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      // Client data = Client.fromJsonLimited(json.decode(response.body));
      // return data;
      var data = jsonDecode(response.body);
      return AppUser.fromJson(data);
    } else {
      return null;
    }
  }
}
