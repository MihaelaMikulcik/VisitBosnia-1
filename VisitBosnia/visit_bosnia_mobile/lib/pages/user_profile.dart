import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/exception/http_exception.dart';
import 'package:visit_bosnia_mobile/model/UserExceptionResponse.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user_update.dart';
import 'package:visit_bosnia_mobile/pages/change_password.dart';
import 'package:visit_bosnia_mobile/pages/loading.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../model/appUser/app_user_register.dart';
import '../pickers/user_image_picker.dart';
import '../providers/appuser_provider.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);
  // AppUser user;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? _userImage;
  bool isLoading = false;

  dynamic response;
  AppUserRegisterRequest request = AppUserRegisterRequest();
  late AppUserProvider _appUserProvider;

  final _formKey = GlobalKey<FormState>();
  final String _requiredMessage = "This field is required!";

  late final TextEditingController firstnameController;
  late final TextEditingController lastnameController;
  late final TextEditingController usernameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;

  FocusNode fcsFirstName = FocusNode();
  FocusNode fcsLastName = FocusNode();
  FocusNode fcsUsername = FocusNode();
  FocusNode fcsEmail = FocusNode();
  FocusNode fcsPhone = FocusNode();

  bool _autoValidate = false;

  bool change = false;

  var user = AppUserProvider.userData;

  bool isChanged = false;
  Future<void> ImageChanged() async {
    if (_userImage != null) {
      var image = base64String(await _userImage!.readAsBytes());
      if (image != user.image) {
        setState(() {
          isChanged = true;
        });
      } else {
        setState(() {
          isChanged = false;
        });
      }
    }
  }

  void DataChanged() {
    if (firstnameController.text != user.firstName ||
        lastnameController.text != user.lastName ||
        usernameController.text != user.userName ||
        emailController.text != user.email ||
        phoneController.text != user.phone) {
      setState(() {
        isChanged = true;
      });
    } else {
      setState(() {
        isChanged = false;
      });
    }
  }

  bool isEmail(String em) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(pattern);

    return regExp.hasMatch(em);
  }

  // bool isPhone(String value) {
  //   String pattern = r'^[0-9]{3}[-]?[0-9]{3}[-]?[0-9]{3,4}$';
  //   RegExp regex = RegExp(pattern);
  //   return regex.hasMatch(value);
  // }

  dynamic updateResult = null;
  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      var request = AppUserUpdateRequest(
        firstName: firstnameController.text,
        lastName: lastnameController.text,
        userName: usernameController.text,
        phone: phoneController.text,
        email: emailController.text,
        image: _userImage != null
            ? base64String(await _userImage!.readAsBytes())
            : AppUserProvider.userData.image,
        changedEmail: emailController.text != AppUserProvider.userData.email
            ? true
            : false,
        changedUsername:
            usernameController.text != AppUserProvider.userData.userName
                ? true
                : false,
        // image: base64String(await _userImage!.readAsBytes())
      );
      if (_userImage != null) {
        request.image = base64String(await _userImage!.readAsBytes());
      }
      setState(() {
        isLoading = true;
      });
      updateResult = await _appUserProvider.updateUserData(user.id!, request);
      setState(() {
        isLoading = false;
      });

      if (updateResult is AppUser) {
        _appUserProvider.changeUserInfo(updateResult);
        Authorization.username = usernameController.text;
        isChanged = false;
        _showDialog(
            true, "You successfully changed your personal information!");
      } else if (updateResult is UserExceptionResponse) {
        _showDialog(false, updateResult.message);
      } else if (updateResult is String) {
        _showDialog(false, "Something went wrong...");
      }
    } else {
      _autoValidate = true;
    }
  }

  _showDialog(bool success, String message) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(success ? "Success" : "Error"),
              content: Text(message),
              actions: [
                TextButton(
                    child: const Text("Ok"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            ));
  }

  void _pickedImage(File image) {
    _userImage = image;
    ImageChanged();
  }

  @override
  void initState() {
    super.initState();
    firstnameController = TextEditingController(text: user.firstName);
    lastnameController = TextEditingController(text: user.lastName);
    usernameController = TextEditingController(text: user.userName);
    emailController = TextEditingController(text: user.email);
    phoneController = TextEditingController(text: user.phone);
    fcsFirstName.addListener(DataChanged);
    fcsLastName.addListener(DataChanged);
    fcsUsername.addListener(DataChanged);
    fcsEmail.addListener(DataChanged);
    fcsPhone.addListener(DataChanged);
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _appUserProvider = Provider.of<AppUserProvider>(context);
    if (isLoading == false) {
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
                      UserImagePicker(
                        imagePickFn: _pickedImage,
                        isProfile: true,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autoValidate
                      ? AutovalidateMode.onUserInteraction
                      : AutovalidateMode.disabled,
                  child: Column(
                    children: [
                      txtFirstName(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      txtLastName(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      txtEmail(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      txtUsername(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      txtPhone(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChangePassword()));
                          },
                          child: Text(
                            "Change password?",
                            style: TextStyle(
                                color: Color.fromARGB(255, 18, 87, 143)),
                          ),
                        ),
                      ),
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
    } else {
      return const Loading();
    }
  }

  // Widget changePassword() {
  //   return widget(
  //     child: Container(
  //       height: 100,
  //       width: MediaQuery.of(context).size.width,
  //       color: Colors.red,
  //     ),
  //   );
  // }

  Widget txtFirstName() {
    return TextFormField(
      controller: firstnameController,
      focusNode: fcsFirstName,
      validator: (value) {
        if (value!.isEmpty) {
          return _requiredMessage;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "First name", border: UnderlineInputBorder()),
    );
  }

  Widget txtLastName() {
    return TextFormField(
      controller: lastnameController,
      focusNode: fcsLastName,
      validator: (value) {
        if (value!.isEmpty) {
          return _requiredMessage;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Last name", border: UnderlineInputBorder()),
    );
  }

  Widget txtEmail() {
    return TextFormField(
      controller: emailController,
      focusNode: fcsEmail,
      validator: (value) {
        if (value!.isEmpty) {
          return _requiredMessage;
        } else if (!isEmail(value)) {
          return "Invalid email format!";
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Email", border: UnderlineInputBorder()),
    );
  }

  Widget txtUsername() {
    return TextFormField(
      controller: usernameController,
      focusNode: fcsUsername,
      validator: (value) {
        if (value!.isEmpty) {
          return _requiredMessage;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Username", border: UnderlineInputBorder()),
    );
  }

  Widget txtPhone() {
    return TextFormField(
      controller: phoneController,
      focusNode: fcsPhone,
      // validator: (value) {
      //   if (value != "" && !isPhone(value!)) {
      //     return "Invalid phone format!";
      //   }
      //   return null;
      // },
      inputFormatters: [
        // MaskedInputFormatter('+387 (00) 000-0000')
        MaskedInputFormatter('+387 00 000-0000')
      ],
      decoration: const InputDecoration(
          labelText: "Phone number", border: UnderlineInputBorder()),
    );
  }

  Widget btnSave() {
    return ElevatedButton(
        onPressed: isChanged ? _trySubmit : null,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text("Save",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        ));
  }
}
