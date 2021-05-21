import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/activity/sign_in/sign_in_body.dart';

class SignInView extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign In")),
        automaticallyImplyLeading: false, // remove back arrow button
      ),
      body: SignInBody(),
    );
  }
}
