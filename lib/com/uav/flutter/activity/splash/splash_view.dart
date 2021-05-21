import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/activity/splash/splash_body.dart';

class SplashView extends StatelessWidget {
  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    UavScreenSize().init(context);
    return Scaffold(
      body: SplashBody(),
    );
  }
}
