import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visit_bosnia_mobile/helpers/navigation_drawer.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homepage";

  Homepage({Key? key, required this.user}) : super(key: key);
  AppUser user;

  @override
  State<Homepage> createState() => _HomepageState(user);
}

class _HomepageState extends State<Homepage> {
  AppUser user;
  _HomepageState(this.user);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(29, 76, 120, 1),
          ),
          drawer: NavigationDrawer(),
          body: Center(
            child: Text("HomePage"),
          ),
        ));
  }
}
