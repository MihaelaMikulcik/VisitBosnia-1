import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/pages/attraction_details.dart';
import 'package:visit_bosnia_mobile/pages/event_details.dart';
import 'package:visit_bosnia_mobile/pages/login.dart';
import 'package:visit_bosnia_mobile/pages/register.dart';
import 'package:visit_bosnia_mobile/pages/home_page.dart';
import 'package:visit_bosnia_mobile/providers/appuser_role_provider.dart';
import 'package:visit_bosnia_mobile/providers/appuser_favourite_provider.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
import 'package:visit_bosnia_mobile/providers/attraction_provider.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';
import 'package:visit_bosnia_mobile/providers/category_provider.dart';
import 'package:visit_bosnia_mobile/providers/city_provider.dart';
import 'package:visit_bosnia_mobile/providers/event_provider.dart';
import 'package:visit_bosnia_mobile/providers/forum_provider.dart';
import 'package:visit_bosnia_mobile/providers/post_provider.dart';
import 'package:visit_bosnia_mobile/providers/post_reply_provider.dart';
import 'package:visit_bosnia_mobile/providers/review_gallery_provider.dart';
import 'package:visit_bosnia_mobile/providers/review_provider.dart';
import 'package:visit_bosnia_mobile/providers/role_provider.dart';
import 'package:visit_bosnia_mobile/providers/tourist_facility_gallery_provider.dart';
import 'package:visit_bosnia_mobile/providers/tourist_facility_provider.dart';
import 'package:visit_bosnia_mobile/providers/transaction_provider.dart';

void main() => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AppUserProvider()),
          ChangeNotifierProvider(create: (_) => EventProvider()),
          ChangeNotifierProvider(create: (_) => CityProvider()),
          ChangeNotifierProvider(
              create: (_) => TouristFacilityGalleryProvider()),
          ChangeNotifierProvider(create: (_) => TouristFacilityProvider()),
          ChangeNotifierProvider(create: (_) => AttractionProvider()),
          ChangeNotifierProvider(create: (_) => ForumProvider()),
          ChangeNotifierProvider(create: (_) => PostProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => AppUserFavouriteProvider()),
          ChangeNotifierProvider(create: (_) => ReviewProvider()),
          ChangeNotifierProvider(create: (_) => ReviewGalleryProvider()),
          ChangeNotifierProvider(create: (_) => TransactionProvider()),
          ChangeNotifierProvider(create: (_) => PostReplyProvider()),
          ChangeNotifierProvider(create: (_) => RoleProvider()),
          ChangeNotifierProvider(create: (_) => AppUserRoleProvider()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: true,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Login(),
            onGenerateRoute: (settings) {
              if (settings.name == Register.routeName) {
                return MaterialPageRoute(
                    builder: ((context) => const Register()));
              }
              // if (settings.name == Homepage.routeName) {
              //   return MaterialPageRoute(builder: ((context) => Homepage()));
              // }
            })));

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//         ),
//         home: const Login(),
//         onGenerateRoute: (settings) {
//           if (settings.name == Register.routeName) {
//             return MaterialPageRoute(builder: ((context) => const Register()));
//           }
//         });
//   }
// }
