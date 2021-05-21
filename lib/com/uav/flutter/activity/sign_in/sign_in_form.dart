import 'package:flutter/material.dart';
// import 'package:flutter_session/flutter_session.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:localstorage/localstorage.dart';
// import 'package:flutter_session/flutter_session.dart';
import 'package:rimlogix/com/uav/flutter/activity/otp/otp_view.dart';

import 'dart:async';
import 'dart:io';

import 'package:rimlogix/com/uav/flutter/components/http.dart';
import 'package:rimlogix/com/uav/flutter/components/http_response.dart';
import 'package:rimlogix/com/uav/flutter/components/form_error.dart';
// import 'package:rimlogix/com/uav/flutter/components/session.dart';

// import 'package:rimlogix/com/uav/flutter/activity/otp/otp_view.dart';

import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/button.dart';

import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
// import 'package:rimlogix/com/uav/flutter/components/session.dart';

// import 'package:rimlogix/screens/forgot_password/forgot_password_screen.dart';
// import 'package:rimlogix/screens/login_success/login_success_screen.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String mobileNumber;
  String password;
  List<String> errors = [];
  bool isShowLoader = false;
  // String email;
  // bool remember = false;

  MemberVO memberVO = new MemberVO();
  HttpResponse httpResponse = new HttpResponse();

  @override
  void initState() {
    errors = [];
    super.initState();
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

  Future<void> getMemberByMobileNo() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      setState(() {
        errors = [];
        // UavLoader.show();
      });

      try {
        var http = new Http();
        var action = "rest/stateless/getCustomerByMobileNumber";
        var callBackFunc = "";
        //Object data = {"mobileNo": memberVO.mobileNo};
        Object data = {"mobileNo": "9887317538"};
        var httpRes = await http
            .postRequest(action, data, callBackFunc)
            .whenComplete(() => setState(() {
                  // UavLoader.hide();
                }));

        if (httpRes.status == "success") {
          print(httpRes.message);
          print(httpRes.dataList);
          MemberVO currentMemberVO =
              MemberVO(); //MemberVO.fromJson(httpRes.dataList);
/*
          final prefs = await SharedPreferences.getInstance();
          List<String> data = new List<String>();
          data[0] = currentMemberVO.mobileNo;
          prefs.setStringList("currentMember", currentMemberVO);
*/

          final LocalStorage storage = new LocalStorage('currentMemberVO');
          // storage.setItem("userId", currentMemberVO.userId);
          storage.setItem("currentMemberVO", currentMemberVO);

          /*
          await FlutterSession()
              .set("currentMemberDataObj", currentMemberVO.toJson());
          */
          // Data mappedData = Data(data: currentMemberVO, id: 1);
          // await FlutterSession().set('currentMemberVO', httpRes.dataList);
          /*
        final dataList = new Map<String, dynamic>.from(httpRes.dataList);

        memberVO.userId = dataList["customer"]["customerId"];
        memberVO.mobileNo = dataList["customer"]["mobileNumber"];
        memberVO.anonymousString = dataList["otp"];
        memberVO.expireTime = dataList["expireTime"];
        */

          UavKeyboard.hideKeyboard(context);
          // Navigator.pushNamed(context, OtpView.routeName() );
          Navigator.push(
            context,
            MaterialPageRoute(
              // builder: (context) => OtpView(currentMemberVO),
              builder: (context) => OtpView(),
            ),
          );
        } else {
          addError(error: httpRes.message);
        }
      } on Exception catch (exception) {
        addError(error: exception.toString());
      } catch (error) {
        addError(error: error.toString());
      }
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // buildEmailFormField(),
          buildMobileFormField(),
          SizedBox(height: UavScreenSize.getScreenHeight(30)),
          // buildPasswordFormField(),
          // SizedBox(height: getProportionateScreenHeight(30)),
          /* 
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: UavPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          */

          FormError(errors: errors),
          /*
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FormError(errors: errors)),
          */
          SizedBox(height: UavScreenSize.getScreenHeight(20)),

          // UavLoader(),

          UavFlatButton(
            text: 'Continue',
            press: getMemberByMobileNo,
          ),
        ],
      ),
    );
  }

  TextFormField buildMobileFormField() {
    return TextFormField(
      maxLength: UavMobileNumberMaxLength,
      keyboardType: TextInputType.phone,
      // onSaved: (value) => memberVO.mobileNo = value,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: UavRequiredFieldError);
        } else if (uavMobileValidatorRegExp.hasMatch(value)) {
          removeError(error: UavInvalidMobileError);
        }
        if (value.length == UavMobileNumberMaxLength) {
          UavKeyboard.hideKeyboard(context);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: UavRequiredFieldError);
          return "";
        } else if (!uavMobileValidatorRegExp.hasMatch(value)) {
          addError(error: UavInvalidMobileError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mobile",
        hintText: "Enter your mobile no",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: UavSurffixIcon(svgIcon: "assets/icons/Mobile.svg"),
      ),
    );
  }

/*
  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: UavSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }


  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: UavSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
  */

}
