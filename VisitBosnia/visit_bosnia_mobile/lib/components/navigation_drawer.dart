// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/main.dart';
import 'package:visit_bosnia_mobile/pages/forum_filter.dart';
import 'package:visit_bosnia_mobile/pages/guide_events.dart';
import 'package:visit_bosnia_mobile/pages/home_page.dart';
import 'package:visit_bosnia_mobile/pages/login.dart';
import 'package:visit_bosnia_mobile/pages/user_profile.dart';
import 'package:visit_bosnia_mobile/providers/appuser_role_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../pages/my_tickets.dart';
import '../pages/user_favourites.dart';
import '../providers/appuser_provider.dart';

class NavigationDrawer extends StatelessWidget {
  NavigationDrawer({Key? key}) : super(key: key);

  bool isLoading = true;
  late AppUserRoleProvider _appUserRoleProvider;

  @override
  Widget build(BuildContext context) => Drawer(
        backgroundColor: const Color.fromRGBO(29, 76, 120, 1),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            AppUserProvider.role == "User"
                ? buildUserMenuItems(context)
                : buildEmployeeMenuItems(context)
          ],
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
      child: Consumer<AppUserProvider>(
        builder: ((context, value, child) {
          return Column(children: [
            CircleAvatar(
                radius: 58,
                backgroundColor: Color.fromARGB(255, 211, 208, 208),
                backgroundImage: AppUserProvider.userData.image == ""
                    ? const AssetImage("assets/images/user3.jpg")
                    : imageFromBase64String(
                            AppUserProvider.userData.image as String)
                        .image),
            const SizedBox(height: 10),
            Text(
                "${AppUserProvider.userData.firstName!} ${AppUserProvider.userData.lastName!}",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 25))
          ]);
        }),
      ));
  Widget buildUserMenuItems(BuildContext context) => Wrap(
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UserProfile()));
            },
          ),
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text("Favorites",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Homepage(user: AppUserProvider.userData);
              }), (route) => false);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UserFavourites()));
            },
          ),
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text("My tickets",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Homepage(user: AppUserProvider.userData);
              }), (route) => false);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => MyTickets()));
            },
          ),
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text("Forum",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return Homepage(user: AppUserProvider.userData);
              }), (route) => false);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ForumFilter()));
            },
          ),
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text("Sign out",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => Login(),
                ),
                (route) => false,
              );
            },
          ),
          buildDivider()
        ],
      );

  Widget buildEmployeeMenuItems(BuildContext context) => Wrap(
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => UserProfile()));
            },
          ),
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text("Forum",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return GuideEvents();
              }), (route) => false);
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => ForumFilter()));
            },
          ),
          buildDivider(),
          ListTile(
            title: const Center(
              child: Text("Sign out",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => Login(),
                ),
                (route) => false,
              );
            },
          ),
          buildDivider()
        ],
      );
}
