// ignore_for_file: implementation_imports, unnecessary_import

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user_register.dart';
import 'package:visit_bosnia_mobile/pages/test.dart';
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

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  dynamic response;
  AppUserRegisterRequest request = AppUserRegisterRequest();
  AppUserProvider? _appUserProvider;

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
    response = await _appUserProvider!.register(request);
  }

  Future<void> _showDialog(String text) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(text),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Sign up",
                      style: TextStyle(
                          fontSize: 27.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    UserImagePicker(imagePickFn: _pickedImage)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
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
          ]),
        ),
      ),
    );
  }

  Widget txtFirstName() {
    return TextField(
      controller: firstNameController,
      decoration: const InputDecoration(
          labelText: "First name", border: UnderlineInputBorder()),
    );
  }

  Widget txtLastName() {
    return TextField(
      controller: lastNameController,
      decoration: const InputDecoration(
          labelText: "Last name", border: UnderlineInputBorder()),
    );
  }

  Widget txtEmail() {
    return TextField(
      controller: emailController,
      decoration: const InputDecoration(
          labelText: "Email", border: UnderlineInputBorder()),
    );
  }

  Widget txtUsername() {
    return TextField(
      controller: usernameController,
      decoration: const InputDecoration(
          labelText: "Username", border: UnderlineInputBorder()),
    );
  }

  Widget txtPassword() {
    return TextField(
      controller: passwordController,
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
    );
  }

  Widget txtConfirmPassword() {
    return TextField(
      controller: confirmPasswordController,
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
    );
  }

  Widget btnSignUp() {
    return InkWell(
        onTap: () async {
          request.firstName = firstNameController.text;
          request.lastName = lastNameController.text;
          request.email = emailController.text;
          request.userName = usernameController.text;
          request.password = passwordController.text;
          request.passwordConfirm = confirmPasswordController.text;
          if (_userImage != null) {
            request.image = base64String(await _userImage!.readAsBytes());
          }

          // Authorization.username = usernameController.text;
          try {
            await getData(request);
            if (response is AppUser) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text("Uspjeh"),
                        content: Text("Uspjesna registracija"),
                        actions: [
                          TextButton(
                            child: Text("Ok"),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ));
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                        title: Text("Greska"),
                        content: Text("Neuspjesna registracija"),
                        actions: [
                          TextButton(
                            child: Text("Ok"),
                            onPressed: () => Navigator.pop(context),
                          )
                        ],
                      ));
            }
          } catch (e) {
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text("Error"),
                      content: Text("Doslo je do greske"),
                      actions: [
                        TextButton(
                          child: Text("Ok"),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ));
          }
          // if (response == null) {
          //   _showDialog('Došlo je do pogreške!');
          // } else {
          //   var korisnik = AppUser.fromJson(response);
          //   Navigator.pushNamed(context, Test.routeName);
          // }
        },
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

  // Widget profileImage() {
  //   return SizedBox(
  //       height: 150,
  //       width: 150,
  //       child: Stack(
  //         clipBehavior: Clip.none,
  //         fit: StackFit.expand,
  //         children: [
  //           CircleAvatar(
  //             //backgroundImage: AssetImage("assets/images/user.png"),
  //             backgroundImage: _userImage != null
  //                 ? FileImage(_userImage!)
  //                 : AssetImage("assets/images/user3.jpg")
  //                     as ImageProvider<Object>?,
  //             backgroundColor: Color.fromARGB(255, 123, 179, 231),
  //             // radius: 70.0,
  //           ),
  //           // ClipOval(
  //           //     child: image != null
  //           //         ? Image.file(image!)
  //           //         : const Image(
  //           //             image: AssetImage("assets/images/user.png"),
  //           //             height: 150,
  //           //             width: 150,
  //           //             fit: BoxFit.cover,
  //           //           )),
  //           Positioned(
  //             bottom: 0,
  //             right: -10,
  //             child: RawMaterialButton(
  //               onPressed: () {
  //                 showModalBottomSheet(
  //                     context: context,
  //                     builder: ((builder) => imageBottomSheet()));
  //               },
  //               elevation: 2.0,
  //               fillColor: Colors.blue,
  //               padding: const EdgeInsets.all(10.0),
  //               shape: const CircleBorder(),
  //               child: const Icon(
  //                 Icons.camera_alt_outlined,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           )
  //         ],
  //       ));
  // }

  // Future pickImage(ImageSource source) async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: source);
  //     if (image == null) return;
  //     final imageTemporary = File(image.path);
  //     setState(() => this._userImage = imageTemporary);
  //   } on PlatformException catch (e) {
  //     print('Failed to pick image: $e');
  //   }
  // }

  // Widget imageBottomSheet() {
  //   return Container(
  //     height: 100.0,
  //     width: MediaQuery.of(context).size.width,
  //     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  //     child: Column(
  //       children: [
  //         const Text("Choose profile photo", style: TextStyle(fontSize: 20.0)),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             TextButton.icon(
  //                 style: TextButton.styleFrom(
  //                   primary: Colors.black,
  //                 ),
  //                 onPressed: () {
  //                   pickImage(ImageSource.camera);
  //                 },
  //                 icon: const Icon(Icons.camera),
  //                 label: const Text("Camera")),
  //             TextButton.icon(
  //                 style: TextButton.styleFrom(
  //                   primary: Colors.black,
  //                 ),
  //                 onPressed: () {
  //                   pickImage(ImageSource.gallery);
  //                 },
  //                 icon: const Icon(Icons.image),
  //                 label: const Text("Gallery"))
  //           ],
  //         )
  //       ],
  //     ),
  //   );
  // }
}
