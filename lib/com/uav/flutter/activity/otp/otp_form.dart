import 'package:flutter/material.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:localstorage/localstorage.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/button.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';

import 'package:rimlogix/com/uav/flutter/components/form_error.dart';
import 'package:rimlogix/com/uav/flutter/components/http.dart';
import 'package:rimlogix/com/uav/flutter/components/http_response.dart';

// import 'package:rimlogix/screens/login_success/login_success_screen.dart';

// import 'package:rimlogix/com/uav/flutter/vo/member_vo.dart';

class OtpForm extends StatefulWidget {
  /*
  MemberVO memberVO;
  OtpForm(this.memberVO);
  */

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  FocusNode pin1FcousNode;
  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  final pin1Controller = TextEditingController();
  final pin2Controller = TextEditingController();
  final pin3Controller = TextEditingController();
  final pin4Controller = TextEditingController();

  String otp;

  @override
  initState() {
    /*
    await FlutterSession()
        .get("currentMemberDataObj")
        .then((value) => print(value));
*/

    final LocalStorage storage = new LocalStorage('currentMemberVO');
    // print(storage.getItem('userId'));
    print(storage.getItem('currentMemberVO').toString());

    super.initState();

    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      print(focusNode);
      focusNode.requestFocus();
    } else {}
  }

  Future<HttpResponse> verifiyOTP() async {
    var http = new Http();
    var action = "rest/stateless/verifiyOTP";
    var callBackFunc = "";

    otp = pin1Controller.text +
        pin2Controller.text +
        pin3Controller.text +
        pin4Controller.text;

    Object data = {
      // "mobileNo": widget.memberVO.mobileNo,
      "anonymousString": otp
    };
    return http.postRequest(action, data, callBackFunc);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: UavScreenSize.screenHeight * 0.15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: UavScreenSize.getScreenWidth(60),
                child: TextFormField(
                  controller: pin1Controller,
                  autofocus: true,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: UavScreenSize.getScreenWidth(60),
                child: TextFormField(
                  controller: pin2Controller,
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: UavScreenSize.getScreenWidth(60),
                child: TextFormField(
                  controller: pin3Controller,
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: UavScreenSize.getScreenWidth(60),
                child: TextFormField(
                  controller: pin4Controller,
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FocusNode.unfocus();
                      // Then you need to check is the code is correct or not
                    }
                  },
                ),
              ),
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: UavScreenSize.screenHeight * 0.15),
          UavFlatButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                var httpRes = await verifiyOTP();

                if (httpRes.status == "success") {
                  // final dataList = new Map<String, dynamic>.from(httpRes.dataList);

                  // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                } else {
                  //addError(error: httpRes.message);
                }
              }
            },
          )
        ],
      ),
    );
  }
}
