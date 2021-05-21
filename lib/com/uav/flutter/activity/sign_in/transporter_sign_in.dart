import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rimlogix/com/uav/flutter/bo/member/member_bo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/service/auth_service/auth_service.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/button.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransporterSignIn extends StatefulWidget {
  @override
  _TransporterSignInState createState() => _TransporterSignInState();
}

class _TransporterSignInState extends State<TransporterSignIn> {
  final transporterSignInFormKey = GlobalKey<FormState>();
  final uavScaffoldKey = new GlobalKey<ScaffoldState>();

  MemberVO memberVO = new MemberVO();
  bool isShowPass = true;
  SharedPreferences prefs;
  AuthService authService = new AuthService();
  TextEditingController emailIdCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();

  @override
  void initState() {
    super.initState();
    defaultSetting();
  }

  Future defaultSetting() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("currentActivity", UavRoutes.TransporterSignIn);
    authService.checkAuthenticity(context);
  }

  // Toggles the password show status
  void togglePass() {
    setState(() {
      isShowPass = !isShowPass;
    });
  }

  Future<void> getMemberByEmailId() async {
    if (transporterSignInFormKey.currentState.validate()) {
      transporterSignInFormKey.currentState.save();

      UavUtility.showLoader(uavScaffoldKey, "loading...");
      UavKeyboard.hideKeyboard(context);

      memberVO.emailId = emailIdCtrl.text;
      memberVO.password = passwordCtrl.text;
      MemberBO memberBO = new MemberBO();
      MemberVO currentMemberVO = await memberBO.getMemberByEmailId(memberVO);

      if (currentMemberVO.status == "success") {
        // set in shared preference
        if (currentMemberVO.memberId != null) {
          prefs.setInt("memberId", currentMemberVO.memberId);
          Navigator.of(context).pushNamed(
            UavRoutes.TransporterHome,
            arguments: {},
          );
        }
      } else {
        UavDialog.showErrorDialog(context, currentMemberVO.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);

    SizedBox spacer = new SizedBox(height: UavScreenSize.getScreenHeight(30));

    Text heading = new Text("Login", style: uavHeadingStyle);
    Text subHeading = new Text(
      "Login with your email address",
      style: uavSubHeadingStyle,
    );

    UavFlatButton submitBtn = new UavFlatButton(
      text: 'Log In',
      press: getMemberByEmailId,
    );

    Column singleCol = new Column(
      children: [
        spacer,
        heading,
        subHeading,
        spacer,
        uavEmailFormField(),
        spacer,
        uavPasswordFormField(),
        spacer,
        submitBtn,
      ],
    );

    SingleChildScrollView childScrollView = new SingleChildScrollView(
      child: singleCol,
    );

    Form transporterSignInForm = new Form(
      key: transporterSignInFormKey,
      child: childScrollView,
    );

    UavAppBar uavAppBar = new UavAppBar(
      title: "Rimlogix",
      automaticallyImplyLeading: false,
    );

    UavBody uavBody = new UavBody(
      body: transporterSignInForm,
    );

    UavScaffold uavScaffold = new UavScaffold(
        uavKey: uavScaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: uavAppBar),
        body: uavBody);

    return uavScaffold;
  }

  TextFormField uavEmailFormField() {
    return TextFormField(
      decoration: UavDecoration.uavInputDecoration(
        uavLabelText: "Email",
        uavSuffixIcon: Icons.email,
      ),
      controller: emailIdCtrl,
      validator: (value) {
        if (value.isEmpty) {
          return UavRequiredFieldError;
        } else if (!uavEmailValidatorRegExp.hasMatch(value)) {
          return UavInvalidEmailError;
        }
        return null;
      },
    );
  }

  TextFormField uavPasswordFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: GestureDetector(
            onTap: () {
              togglePass();
            },
            child: Icon(
              Icons.lock,
            )),
      ),
      controller: passwordCtrl,
      obscureText: isShowPass,
      validator: (value) {
        if (value.isEmpty) {
          return UavRequiredFieldError;
        }
        return null;
      },
    );
  }
}
