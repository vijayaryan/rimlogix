import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_type_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future checkAuthenticity(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var navigationUrl;
    var memberId = prefs.getInt("memberId");
    var memberTypeId = prefs.getInt("memberTypeId");
    var currentActivity = prefs.getString("currentActivity");
    if (memberId == null && memberTypeId == null) {
      navigationUrl = UavRoutes.MemberType;
    } else if (memberId == null && memberTypeId != null) {
      if (memberTypeId == MemberTypeVO.Customer) {
        navigationUrl = UavRoutes.CustomerSignIn;
      } else if (memberTypeId == MemberTypeVO.Transporter) {
        navigationUrl = UavRoutes.TransporterSignIn;
      }
    } else if (memberId != null && memberTypeId == null) {
      navigationUrl = UavRoutes.MemberType;
    } else {
      if (currentActivity == UavRoutes.MemberType) {
        if (memberTypeId == MemberTypeVO.Customer) {
          navigationUrl = UavRoutes.CustomerHome;
        } else if (memberTypeId == MemberTypeVO.Transporter) {
          navigationUrl = UavRoutes.TransporterHome;
        }
      }
    }

    if (navigationUrl != null && navigationUrl != currentActivity) {
      Navigator.of(context).pushNamed(
        navigationUrl,
        arguments: {},
      );
    }
  }
}
