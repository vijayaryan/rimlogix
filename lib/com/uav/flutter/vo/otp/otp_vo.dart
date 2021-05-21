import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';

class OtpVO extends BaseVO {
  int otpId;
  String otp;
  String mobileNo;
  String emailId;
  DateTime createdAt;
  DateTime expiredAt;
  int expireTime;
  MemberVO memberVO;

  OtpVO(
      {this.otpId,
      this.otp,
      this.mobileNo,
      this.emailId,
      this.createdAt,
      this.expiredAt,
      this.expireTime,
      this.memberVO});

  factory OtpVO.fromJson(dynamic jsonStr) {
    Map<String, dynamic> jsonObj = new Map<String, dynamic>.from(jsonStr);

    return OtpVO(
      otpId: jsonObj["otpId"],
      otp: jsonObj["otp"],
      mobileNo: jsonObj["mobileNo"],
      emailId: jsonObj["emailId"],
      /*
      createdAt: jsonObj["createdAt"],
      expiredAt: jsonObj["expireTime"],
      */
      createdAt: jsonObj["createdAt"] != null
          ? DateTime.parse(jsonObj["createdAt"])
          : null,
      expiredAt: jsonObj["expiredAt"] != null
          ? DateTime.parse(jsonObj["expiredAt"])
          : null,
      expireTime: jsonObj["expireTime"],
      //memberVO: MemberVO.fromJson(jsonObj["customer"]),
    );
    // return OtpVO(jsonObj['title'] as String, json['description'] as String, User.fromJson(json['author']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = Map<String, dynamic>();

    jsonObj["otpId"] = this.otpId;
    jsonObj["otp"] = this.otp;
    jsonObj["mobileNo"] = this.mobileNo;
    jsonObj["emailId"] = this.emailId;
    jsonObj["createdAt"] = this.createdAt;
    jsonObj["expiredAt"] = this.expiredAt;
    jsonObj["customer"] = this.memberVO;

    return jsonObj;
  }
}
