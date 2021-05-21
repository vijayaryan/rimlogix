import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/activity/otp/otp_view.dart';
import 'package:rimlogix/com/uav/flutter/bo/member/member_bo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/form_error.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/button.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/otp/otp_vo.dart';

class SignIn extends StatefulWidget {
  static String routeName = "/sign_in";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final signInFormKey = GlobalKey<FormState>();
  List<String> errors = [];
  MemberVO memberVO = new MemberVO();
  bool isShowLoader = false;
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
    if (signInFormKey.currentState.validate()) {
      signInFormKey.currentState.save();

      setState(() {
        errors = [];
        isShowLoader = true;
      });

      try {
        MemberBO memberBO = new MemberBO();
        OtpVO currentOtpVO = await memberBO.getMemberByMobileNo(memberVO);

        setState(() {
          isShowLoader = false;
        });

        if (currentOtpVO.status == "success") {
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
          addError(error: currentOtpVO.message);
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
    UavScreenSize().init(context);

    SizedBox spacer = new SizedBox(height: UavScreenSize.getScreenHeight(30));
    FormError formError = new FormError(errors: errors);

    Text heading = new Text("Sign in - Sign up", style: uavHeadingStyle);
    Text subHeading = new Text(
      "Sign in with your mobile number",
      style: uavSubHeadingStyle,
    );

    UavFlatButton submitBtn = new UavFlatButton(
      text: 'Continue',
      press: getMemberByMobileNo,
    );

    Column singleCol = new Column(
      children: [
        spacer,
        heading,
        subHeading,
        spacer,
        uavMobileFormField(),
        // UavLoader(isShowLoader),
        spacer,
        formError,
        spacer,
        submitBtn
      ],
    );

    Form signInForm = new Form(
      key: signInFormKey,
      child: singleCol,
    );

    // SafeArea body = new SafeArea(child: signInForm);

    UavAppBar uavAppBar = new UavAppBar(
      title: "Sign In",
      automaticallyImplyLeading: false,
    );

    UavBody uavBody = new UavBody(
      body: signInForm,
    );

    UavScaffold uavScaffold = new UavScaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: uavAppBar),
        body: uavBody);

    return uavScaffold;
  }

  TextFormField uavMobileFormField() {
    return TextFormField(
      autofocus: true,
      maxLength: UavMobileNumberMaxLength,
      keyboardType: TextInputType.phone,
      //onSaved: (value) => memberVO.mobileNo = value,
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
        labelText: "Mobile No",
        // hintText: "Enter your mobile no",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: UavSurffixIcon(svgIcon: "assets/icons/Mobile.svg"),
      ),
    );
  }
}
