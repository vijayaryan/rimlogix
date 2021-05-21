import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/button.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';

import 'package:rimlogix/com/uav/flutter/activity/sign_in/sign_in_view.dart';
import 'package:rimlogix/com/uav/flutter/activity/splash/splash_content.dart';

class SplashBody extends StatefulWidget {
  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> {
  int currentPage = 0;
  List<Map<String, String>> splashData = [
    {"text": "Welcome to Rim Logix", "image": "assets/images/splash_1.png"},
    {
      /*
      "text":
          "We help people conect with store \naround United State of America",
      */
      "text": "We help people conect with transporter.",
      "image": "assets/images/splash_2.png"
    },
    {
      // "text": "We show the easy way to shop. \nJust stay at home with us",
      "text":
          "We show the easy way to book consignment. \n Just stay at home with us",
      "image": "assets/images/splash_3.png"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: PageView.builder(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context, index) => SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]['text'],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: UavScreenSize.getScreenWidth(20)),
                child: Column(
                  children: <Widget>[
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                    Spacer(flex: 3),
                    UavFlatButton(
                      text: "Continue",
                      press: () {
                        Navigator.pushNamed(context, SignInView.routeName);
                      },
                    ),
                    Spacer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: UavAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? UavPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
