import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/pages/login.dart';
import 'package:visit_bosnia_mobile/pages/register.dart';
import 'package:visit_bosnia_mobile/pages/home_page.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
import 'package:visit_bosnia_mobile/providers/base_provider.dart';

void main() => runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => AppUserProvider())],
    child: MaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Login(),
        onGenerateRoute: (settings) {
          if (settings.name == Register.routeName) {
            return MaterialPageRoute(builder: ((context) => const Register()));
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
