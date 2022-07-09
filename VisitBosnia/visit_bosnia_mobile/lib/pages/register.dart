// ignore_for_file: implementation_imports, unnecessary_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

class Register extends StatefulWidget {
  static const String routeName = "/register";

  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _obsecurePass = true;
  bool _obsecureConfirmPass = true;
  File? image;

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
                    SizedBox(
                        height: 150,
                        width: 150,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            // CircleAvatar(
                            //   // backgroundImage: AssetImage("assets/user.png"),
                            //   backgroundImage: image != null ? Image.file(image!) : Image(image: AssetImage("assets/user.png")),
                            //   backgroundColor: Colors.transparent,

                            // ),
                            ClipOval(
                                child: image != null
                                    ? Image.file(image!)
                                    : const Image(
                                        image: AssetImage(
                                            "assets/images/user.png"),
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      )),
                            Positioned(
                              bottom: 0,
                              right: -10,
                              child: RawMaterialButton(
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) =>
                                          imageBottomSheet()));
                                },
                                elevation: 2.0,
                                fillColor: Colors.blue,
                                padding: const EdgeInsets.all(10.0),
                                shape: const CircleBorder(),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                        labelText: "First name",
                        border: UnderlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        labelText: "Last name", border: UnderlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        labelText: "Email", border: UnderlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                        labelText: "Username", border: UnderlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // const TextField(
                  //   decoration: InputDecoration(
                  //       labelText: "Phone number",
                  //       border: UnderlineInputBorder()),
                  // ),
                  // const TextField(
                  //   decoration: InputDecoration(
                  //       labelText: "Date of birth",
                  //       border: UnderlineInputBorder()),
                  // ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(_obsecurePass
                              ? Icons.remove_red_eye
                              : Icons.lock),
                          onPressed: () {
                            setState(() {
                              _obsecurePass = !_obsecurePass;
                            });
                          },
                        ),
                        border: const UnderlineInputBorder()),
                    obscureText: _obsecurePass,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        labelText: "Confirm password",
                        suffixIcon: IconButton(
                          icon: Icon(_obsecureConfirmPass
                              ? Icons.remove_red_eye
                              : Icons.lock),
                          onPressed: () {
                            setState(() {
                              _obsecureConfirmPass = !_obsecureConfirmPass;
                            });
                          },
                        ),
                        border: const UnderlineInputBorder()),
                    obscureText: _obsecureConfirmPass,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
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
                  ))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Widget imageBottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text("Choose profile photo", style: TextStyle(fontSize: 20.0)),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera),
                  label: const Text("Camera")),
              TextButton.icon(
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text("Gallery"))
            ],
          )
        ],
      ),
    );
  }
}
