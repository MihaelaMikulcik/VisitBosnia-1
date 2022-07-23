import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/exception/http_exception.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';
import 'package:visit_bosnia_mobile/pages/register.dart';
import 'package:visit_bosnia_mobile/pages/home_page.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AppUserProvider? _appUserProvider;
  dynamic result;
  Future<void> login() async {
    result = await _appUserProvider?.login(
        _usernameController.text, _passwordController.text);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appUserProvider = context.read<AppUserProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(70),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: Image(
                          image: AssetImage("assets/images/bosnia_icon.png"),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        child: Text(
                          "VisitBosnia",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 33.0,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 35,
                    child: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Username',
                          hintStyle: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      autofocus: false,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 35,
                    child: TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          hintStyle: const TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold)),
                      obscureText: true,
                      autofocus: false,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 35,
                    margin: const EdgeInsets.fromLTRB(0, 15, 0, 10),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color.fromRGBO(29, 76, 120, 1),
                    ),
                    child: InkWell(
                      onTap: () async {
                        if (_usernameController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              "Please insert username and password",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            duration: Duration(seconds: 2),
                            backgroundColor: Color.fromARGB(255, 165, 46, 37),
                          ));
                          return;
                        }
                        try {
                          Authorization.username = _usernameController.text;
                          Authorization.password = _passwordController.text;
                          await login();
                          if (result is AppUser) {
                            Navigator.pushNamed(context, Homepage.routeName);
                          } else {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: const Text("Doslo je do greske"),
                                      actions: [
                                        TextButton(
                                          child: const Text("Ok"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        )
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
                                backgroundColor:
                                    const Color.fromARGB(255, 165, 46, 37)));
                          }
                          // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          //     content: Text(
                          //       e.toString().substring(
                          //           e.toString().indexOf(':') + 2,
                          //           e.toString().length),
                          //       style: TextStyle(color: Colors.white),
                          //     ),
                          //     duration: Duration(seconds: 2),
                          //     backgroundColor:
                          //         Color.fromARGB(255, 165, 46, 37)));
                        }
                      },
                      child: const Text("Login",
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Register.routeName);
                        },
                        child: const Text("Create account",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const Text(" | ",
                          style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                      const InkWell(
                        child: Text("Forgot password?",
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
