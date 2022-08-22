// ignore_for_file: implementation_imports, unnecessary_import

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/exception/http_exception.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user_register.dart';
import 'package:visit_bosnia_mobile/pages/home_page.dart';
import 'package:visit_bosnia_mobile/pickers/user_image_picker.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../model/appUser/app_user.dart';

class Register extends StatefulWidget {
  static const String routeName = "/register";

  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obsecurePass = true;
  bool _obsecureConfirmPass = true;
  File? _userImage;

  TextEditingController passwordController = TextEditingController();

  dynamic response;
  AppUserRegisterRequest request = AppUserRegisterRequest();
  late AppUserProvider _appUserProvider;

  final _formKey = GlobalKey<FormState>();
  final String _requiredMessage = "This field is required!";

  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _username = '';
  String _password = '';
  String _confirmPassword = '';

  bool _autoValidate = false;

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  void _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      if (_formKey.currentState!.validate()) {
        request.firstName = _firstName;
        request.lastName = _lastName;
        request.email = _email;
        request.userName = _username;
        request.password = _password;
        request.passwordConfirm = _confirmPassword;
        // request.isBlocked = false;
        if (_userImage != null) {
          request.image = base64String(await _userImage!.readAsBytes());
        }

        try {
          await getData(request);
          Authorization.username = _username;
          Authorization.password = _password;
          if (response is AppUser) {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: const Text("Uspjeh"),
                      content: const Text("Uspjesna registracija"),
                      actions: [
                        TextButton(
                            child: const Text("Ok"),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Homepage(
                                        user: response as AppUser,
                                      )));
                            })
                      ],
                    ));
          }
        } catch (e) {
          if (e is UserException) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  e.message,
                  style: const TextStyle(color: Colors.white),
                ),
                duration: const Duration(seconds: 2),
                backgroundColor: Color.fromARGB(255, 165, 46, 37)));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Something went wrong, please try again later...",
                  style: TextStyle(color: Colors.white),
                ),
                duration: Duration(seconds: 2),
                backgroundColor: Color.fromARGB(255, 165, 46, 37)));
          }
        }
      }
    } else {
      _autoValidate = true;
    }
  }

  void _pickedImage(File image) {
    _userImage = image;
  }

  @override
  void initState() {
    super.initState();
    // _appUserProvider = Provider.of<AppUserProvider>(context);
    _appUserProvider = context.read<AppUserProvider>();
  }

  Future<void> getData(AppUserRegisterRequest request) async {
    response = await _appUserProvider.register(request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            Container(
              height: 250,
              width: MediaQuery.of(context).size.width,
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(29, 76, 120, 1)),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 27.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    UserImagePicker(imagePickFn: _pickedImage, isProfile: false)
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
                    txtPassword(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    txtConfirmPassword(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    btnSignUp()
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget txtFirstName() {
    return TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return _requiredMessage;
          }
          return null;
        },
        decoration: const InputDecoration(
            labelText: "First name", border: UnderlineInputBorder()),
        onSaved: (value) {
          _firstName = value!;
        });
  }

  Widget txtLastName() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return _requiredMessage;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Last name", border: UnderlineInputBorder()),
      onSaved: (value) {
        _lastName = value!;
      },
    );
  }

  Widget txtEmail() {
    return TextFormField(
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
      onSaved: (value) {
        _email = value!;
      },
    );
  }

  Widget txtUsername() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return _requiredMessage;
        }
        return null;
      },
      decoration: const InputDecoration(
          labelText: "Username", border: UnderlineInputBorder()),
      onSaved: (value) {
        _username = value!;
      },
    );
  }

  Widget txtPassword() {
    return TextFormField(
      controller: passwordController,
      validator: (value) {
        if (value!.isEmpty) {
          return _requiredMessage;
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Password",
          suffixIcon: IconButton(
            icon: Icon(_obsecurePass ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obsecurePass = !_obsecurePass;
              });
            },
          ),
          border: const UnderlineInputBorder()),
      obscureText: _obsecurePass,
      onSaved: (value) {
        _password = value!;
      },
    );
  }

  Widget txtConfirmPassword() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return _requiredMessage;
        }
        if (value != passwordController.text) {
          return "Password and confirmation do not match!";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "Confirm password",
          suffixIcon: IconButton(
            icon: Icon(
                _obsecureConfirmPass ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _obsecureConfirmPass = !_obsecureConfirmPass;
              });
            },
          ),
          border: const UnderlineInputBorder()),
      obscureText: _obsecureConfirmPass,
      onSaved: (value) {
        _confirmPassword = value!;
      },
    );
  }

  Widget btnSignUp() {
    return InkWell(
        onTap: _trySubmit,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(29, 76, 120, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text("Sign up",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ));
  }
}
