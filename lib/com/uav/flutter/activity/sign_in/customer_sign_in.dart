import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rimlogix/com/uav/flutter/bo/member/member_bo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/service/auth_service/auth_service.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/button.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerSignIn extends StatefulWidget {
  @override
  _CustomerSignInState createState() => _CustomerSignInState();
}

class _CustomerSignInState extends State<CustomerSignIn> {
  final customerSignInFormKey = GlobalKey<FormState>();
  final uavScaffoldKey = new GlobalKey<ScaffoldState>();

  MemberVO memberVO = new MemberVO();
  bool isShowPass = true;
  SharedPreferences prefs;
  AuthService authService = new AuthService();
  TextEditingController mobileNoCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();

  @override
  void initState() {
    super.initState();
    defaultSetting();
  }

  Future defaultSetting() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("currentActivity", UavRoutes.CustomerSignIn);
    authService.checkAuthenticity(context);
  }

  // Toggles the password show status
  void togglePass() {
    setState(() {
      isShowPass = !isShowPass;
    });
  }

  Future<void> getMemberByMobileNo() async {
    if (customerSignInFormKey.currentState.validate()) {
      customerSignInFormKey.currentState.save();

      UavKeyboard.hideKeyboard(context);
      UavUtility.showLoader(uavScaffoldKey, "  Signing-In...");

      MemberTypeVO memberTypeVO = new MemberTypeVO();
      memberTypeVO.memberTypeId = prefs.getInt("memberTypeId");

      memberVO.mobileNo = mobileNoCtrl.text;
      memberVO.password = passwordCtrl.text;
      memberVO.memberType = memberTypeVO.toJson();
      MemberBO memberBO = new MemberBO();
      MemberVO currentMemberVO =
          await memberBO.getMemberByMobileNoAndPassword(memberVO);

      if (currentMemberVO.status == "success") {
        // set in shared preference
        if (currentMemberVO.memberId != null) {
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs.setString("memberData", currentMemberVO.toJson().toString());
          prefs.setInt("memberId", currentMemberVO.memberId);
          Navigator.of(context).pushNamed(
            UavRoutes.CustomerHome,
            arguments: {},
          );
        }
      } else {
        UavUtility.hideLoader(uavScaffoldKey);
        UavDialog.showErrorDialog(context, currentMemberVO.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);

    SizedBox spacer = new SizedBox(height: UavScreenSize.getScreenHeight(30));

    Text heading = new Text("Sign In-Sign Up", style: uavHeadingStyle);
    Text subHeading = new Text(
      "with your mobile number",
      style: uavSubHeadingStyle,
    );

    UavFlatButton submitBtn = new UavFlatButton(
      text: 'Submit',
      press: getMemberByMobileNo,
    );

    Column singleCol = new Column(
      children: [
        spacer,
        heading,
        subHeading,
        spacer,
        uavMobileFormField(),
        spacer,
        uavPasswordFormField(),
        spacer,
        submitBtn,
      ],
    );

    SingleChildScrollView childScrollView = new SingleChildScrollView(
      child: singleCol,
    );

    Form customerSignInForm = new Form(
      key: customerSignInFormKey,
      child: childScrollView,
    );

    UavAppBar uavAppBar = new UavAppBar(
      title: "Rimlogix",
      automaticallyImplyLeading: false,
    );

    UavBody uavBody = new UavBody(
      body: customerSignInForm,
    );

    UavScaffold uavScaffold = new UavScaffold(
        uavKey: uavScaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: uavAppBar),
        body: uavBody);

    return uavScaffold;
  }

  TextFormField uavMobileFormField() {
    return TextFormField(
      maxLength: UavMobileNumberMaxLength,
      keyboardType: TextInputType.phone,
      decoration: UavDecoration.uavInputDecoration(
        uavLabelText: "Mobile No",
        uavSuffixIcon: Icons.phone_android,
      ),
      controller: mobileNoCtrl,
      validator: (value) {
        if (value.isEmpty) {
          return UavRequiredFieldError;
        } else if (!uavMobileValidatorRegExp.hasMatch(value)) {
          return UavInvalidMobileError;
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
