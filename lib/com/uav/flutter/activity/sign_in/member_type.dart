import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/service/auth_service/auth_service.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/button.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemberType extends StatefulWidget {
  @override
  _MemberTypeState createState() => _MemberTypeState();
}

class _MemberTypeState extends State<MemberType> {
  final memberTypeFormKey = GlobalKey<FormState>();
  final uavScaffoldKey = new GlobalKey<ScaffoldState>();

  MemberVO memberVO = new MemberVO();
  SharedPreferences prefs;
  AuthService authService = new AuthService();
  TextEditingController memberTypeCtrl = new TextEditingController();

  final List<Map<dynamic, dynamic>> memberTypeList =
      new List<Map<dynamic, dynamic>>();

  void initState() {
    super.initState();
    defaultSetting();
  }

  Future defaultSetting() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("currentActivity", UavRoutes.MemberType);
    authService.checkAuthenticity(context);

    Map memberTypeMap1 = {
      'memberTypeId': MemberTypeVO.Customer,
      'typeName': 'Customer',
      'isSelected': true
    };

    Map memberTypeMap2 = {
      'memberTypeId': MemberTypeVO.Transporter,
      'typeName': 'Transporter',
      'isSelected': false
    };

    setState(() {
      memberTypeCtrl.text = MemberTypeVO.Customer.toString();
      memberTypeList.add(memberTypeMap1);
      memberTypeList.add(memberTypeMap2);
    });
  }

  Future<void> submitMemberTypeForm() async {
    if (memberTypeCtrl.text == "" || memberTypeCtrl.text == null) {
      UavDialog.showErrorDialog(context, "Please Select One.");
      return false;
    }

    // UavUtility.showLoader(uavScaffoldKey, "loading...");
    prefs.setInt("memberId", null);
    prefs.setInt("memberTypeId", int.parse(memberTypeCtrl.text));
    prefs.setString("currentActivity", UavRoutes.MemberType);
    authService.checkAuthenticity(context);
    // UavUtility.hideLoader(uavScaffoldKey);
  }

  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);

    SizedBox spacer = new SizedBox(height: UavScreenSize.getScreenHeight(30));

    Text heading = new Text("..Choose..", style: uavHeadingStyle);
    Text subHeading = new Text(
      "how could we deal with you as",
      style: uavSubHeadingStyle,
    );

    UavFlatButton submitBtn = new UavFlatButton(
      text: 'Next',
      press: submitMemberTypeForm,
    );

    Column singleCol = new Column(
      children: [
        spacer,
        heading,
        subHeading,
        spacer,
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: memberTypeList.length,
          itemBuilder: (context, index) {
            return (memberTypeList.length == 0)
                ? CircularProgressIndicator()
                : Card(
                    /*
                    color: memberTypeList[index]['isSelected'] == true
                        ? UavPrimaryColor
                        : Colors.white,
                    */
                    child: ListTile(
                    onTap: () {
                      memberTypeCtrl.text = "";
                      // if this item isn't selected yet, "isSelected": false -> true
                      // If this item already is selected: "isSelected": true -> false
                      setState(() {
                        for (int i = 0; i < memberTypeList.length; i++) {
                          if (index == i) continue;
                          memberTypeList[i]["isSelected"] = false;
                        }

                        memberTypeList[index]['isSelected'] =
                            !memberTypeList[index]["isSelected"];

                        if (memberTypeList[index]['isSelected']) {
                          memberTypeCtrl.text =
                              memberTypeList[index]['memberTypeId'].toString();
                        }
                      });
                    },
                    trailing: (memberTypeList[index]['isSelected'] == true)
                        ? Icon(
                            Icons.check_circle,
                            color: UavPrimaryColor,
                          )
                        : Text(""),
                    title: Text(memberTypeList[index]['typeName']),
                  ));
          },
        ),
        spacer,
        submitBtn,
      ],
    );

    SingleChildScrollView childScrollView = new SingleChildScrollView(
      physics: ScrollPhysics(),
      child: singleCol,
    );

    Form memberTypeForm =
        new Form(key: memberTypeFormKey, child: childScrollView);

    UavAppBar uavAppBar = new UavAppBar(
      title: "Rimlogix",
      automaticallyImplyLeading: false,
    );

    UavBody uavBody = new UavBody(
      body: memberTypeForm,
    );

    WillPopScope willPopScope = new WillPopScope(
      child: uavBody,
      onWillPop: () {
        print("hello");
        return Future.value(false);
      },
    );

    UavScaffold uavScaffold = new UavScaffold(
      uavKey: uavScaffoldKey,
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(50.0), child: uavAppBar),
      //body: uavBody
      body: willPopScope,
    );

    return uavScaffold;
  }
}
