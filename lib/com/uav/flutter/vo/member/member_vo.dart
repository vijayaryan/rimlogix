import 'dart:convert';
import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';

class MemberVO extends BaseVO {
  var memberId;
  var mobileNo;
  var emailId;
  var password;
  var displayName;
  var memberType;
  MemberVO({
    this.memberId,
    this.mobileNo,
    this.emailId,
    this.password,
    this.displayName,
    this.memberType,
  });

  fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    this.memberId = mapArr["memberId"];
    this.mobileNo = mapArr["mobileNo"];
    this.emailId = mapArr["emailId"];
    this.password = mapArr["password"];
    this.displayName = mapArr["displayName"];
    this.memberType = mapArr["memberType"];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = super.toJson();
    // final Map<String, dynamic> jsonObj = Map<String, dynamic>();

    jsonObj["memberId"] = this.memberId;
    jsonObj["mobileNo"] = this.mobileNo;
    jsonObj["emailId"] = this.emailId;
    jsonObj["password"] = this.password;
    jsonObj["displayName"] = this.displayName;
    jsonObj["memberType"] = this.memberType;

    jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
