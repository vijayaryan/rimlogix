import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
// import 'package:rimlogix/com/uav/flutter/vo/member_vo.dart';
import 'package:rimlogix/com/uav/flutter/activity/otp/otp_body.dart';

class OtpView extends StatelessWidget {
  /* 
  final MemberVO memberVO;
  OtpView(this.memberVO);
  */

  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("OTP Verification")),
        automaticallyImplyLeading: false, // remove back arrow button
      ),
      // body: OtpBody(this.memberVO),
      body: OtpBody(),
    );
  }
}
