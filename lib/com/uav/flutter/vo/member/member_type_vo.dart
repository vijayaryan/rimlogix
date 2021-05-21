import 'dart:convert';
import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';

class MemberTypeVO extends BaseVO {
  var memberTypeId;
  var typeName;

  static const Customer = 3;
  static const Transporter = 8;

  MemberTypeVO({
    this.memberTypeId,
    this.typeName,
  });

  fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    this.memberTypeId = mapArr["memberTypeId"];
    this.typeName = mapArr["typeName"];

    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = super.toJson();

    jsonObj["memberTypeId"] = this.memberTypeId;
    jsonObj["typeName"] = this.typeName;

    jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
