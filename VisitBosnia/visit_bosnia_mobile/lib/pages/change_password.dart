// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/main.dart';
import 'package:visit_bosnia_mobile/model/UserExceptionResponse.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user_change_pass_request.dart';
import 'package:visit_bosnia_mobile/pages/home_page.dart';
import 'package:visit_bosnia_mobile/pages/user_profile.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import 'login.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  late AppUserProvider _appUserProvider;

  dynamic response;

  bool _autovalidateMode = false;

  Future getData(AppUserChangePasswordRequest request) async {
    response = await _appUserProvider.changePassword(request);
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      var request = AppUserChangePasswordRequest(
          userName: AppUserProvider.userData.userName,
          oldPassword: oldPasswordController.text,
          newPassword: newPasswordController.text,
          newPasswordConfirm: confirmPasswordController.text);
      await getData(request);
      if (response is AppUser) {
        Authorization.password = newPasswordController.text;

        _showDialog(true,
            "Password changed successfully, please log in with your new password!");
      } else if (response is UserExceptionResponse) {
        _showDialog(false, response.message!);
      } else if (response is String) {
        _showDialog(false, response);
      }
    }
  }

  _showDialog(bool success, String message) {
    return showDialog(
        context: navigatorKey.currentContext!,
        builder: (BuildContext context) => AlertDialog(
              title: Text(success ? "Success" : "Error"),
              content: Text(message),
              actions: [
                TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      if (success) {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Login(),
                          ),
                          (route) => false,
                        );
                      } else {
                        Navigator.of(context).pop();
                      }
                    })
              ],
            ));
  }

  Widget btnSave() {
    return ElevatedButton(
        onPressed: _trySubmit,
        child: SizedBox(
          width: double.infinity,
          child: Container(
            alignment: Alignment.center,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text("Save",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ),
        ));
  }

  Widget txtOldPassword() {
    return TextFormField(
      controller: oldPasswordController,
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required!";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Current password",
          suffixIcon: Icon(Icons.lock),
          border: const UnderlineInputBorder()),
      obscureText: true,
    );
  }

  Widget txtNewPassword() {
    return TextFormField(
      controller: newPasswordController,
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required!";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "New password",
          suffixIcon: Icon(Icons.lock),
          border: const UnderlineInputBorder()),
      obscureText: true,
      onChanged: (_) => _autovalidateMode = true,
    );
  }

  Widget txtConfirmPassword() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "This field is required!";
        }
        if (value != newPasswordController.text) {
          return "Password and confirmation do not match!";
        }
        return null;
      },
      controller: confirmPasswordController,
      decoration: InputDecoration(
          labelText: "Confirm password",
          suffixIcon: Icon(Icons.lock),
          border: const UnderlineInputBorder()),
      obscureText: true,
      onChanged: (_) => _autovalidateMode = true,
    );
  }

  @override
  Widget build(BuildContext context) {
    _appUserProvider = context.read<AppUserProvider>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(29, 76, 120, 1)),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 160,
                        width: 160,
                        child: Image.asset("assets/images/lock.png"))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    txtOldPassword(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    txtNewPassword(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    txtConfirmPassword(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    btnSave(),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
