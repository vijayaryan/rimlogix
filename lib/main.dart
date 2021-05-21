/*
import 'package:flutter_launcher_icons/android.dart';
import 'package:flutter_launcher_icons/constants.dart';
import 'package:flutter_launcher_icons/custom_exceptions.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_launcher_icons/utils.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
*/

import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/components/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rim Logix',
      theme: theme(),
      // home: SplashScreen(),
      // routes: routes,
      // We use routeName so that we dont need to remember the name
      // initialRoute: UavRoutes.Login,
      initialRoute: UavRoutes.MemberType,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
