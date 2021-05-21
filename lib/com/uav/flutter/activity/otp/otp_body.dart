import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';

// import 'package:rimlogix/com/uav/flutter/vo/member_vo.dart';
import 'package:rimlogix/com/uav/flutter/activity/otp/otp_form.dart';

class OtpBody extends StatelessWidget {
  /*
  final MemberVO memberVO;
  OtpBody(this.memberVO);
*/
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: UavScreenSize.getScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: UavScreenSize.screenHeight * 0.05),
              Text(
                "OTP Verification",
                style: headingStyle,
              ),
              //Text("We sent your code to " + memberVO.mobileNo),
              buildTimer(),
              // OtpForm(this.memberVO),
              OtpForm(),
              SizedBox(height: UavScreenSize.screenHeight * 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: Text(
                  "Resend OTP Code",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("This code will expired in "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: UavPrimaryColor),
          ),
        ),
      ],
    );
  }
}
