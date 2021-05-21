import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/activity/sign_in/sign_in_form.dart';

class SignInBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: UavScreenSize.getScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: UavScreenSize.screenHeight * 0.04),
                Text(
                  //  "Welcome Back",
                  "Welcome",
                  style: TextStyle(
                    color: UavSecondaryColor,
                    fontSize: UavScreenSize.getScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  // "Sign in with your email and password  \n or continue with social media",
                  "Sign in with your mobile number",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: UavScreenSize.screenHeight * 0.08),
                SignInForm(),
                SizedBox(height: UavScreenSize.screenHeight * 0.08),
                /*
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocalCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocalCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    SocalCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                ),
                */
                SizedBox(height: UavScreenSize.getScreenHeight(20)),
                // NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
