import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visit_bosnia_mobile/main.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';
import 'package:visit_bosnia_mobile/pages/user_profile.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key, required this.user}) : super(key: key);

  AppUser user;

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: const Color.fromRGBO(29, 76, 120, 1),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[buildHeader(context), buildMenuItems(context)],
        )),
      );

  Widget buildDivider() => const Divider(
        color: Color.fromARGB(255, 36, 94, 148),
        thickness: 1.5,
        height: 4,
      );

  Widget buildHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top, bottom: 24),
        child: Column(children: [
          CircleAvatar(
              radius: 58,
              backgroundImage: user.image == ""
                  ? AssetImage("assets/images/user3.jpg")
                  : imageFromBase64String(user.image as String).image),
          const SizedBox(height: 10),
          Text("${user.firstName!} ${user.lastName!}",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 25))
        ]),
      );
  Widget buildMenuItems(BuildContext context) => Wrap(
        runSpacing: 1,
        children: [
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text(
                "My profile",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const UserProfile()));
            },
          ),
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text("Favorites",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {},
          ),
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text("My tickets",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {},
          ),
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text("Forum",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {},
          ),
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text("Sign out",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {},
          ),
          buildDivider()
        ],
      );
}
