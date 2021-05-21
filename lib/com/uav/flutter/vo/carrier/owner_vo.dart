import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';

class OwnerVO extends BaseVO {
  var ownerId;
  var mobileNo;
  var ownerName;
  var value;
  OwnerVO({
    this.ownerId,
    this.mobileNo,
    this.ownerName,
    this.value,
  });

  fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    this.ownerId = mapArr["ownerId"];
    this.mobileNo = mapArr["mobileNo"];
    this.ownerName = mapArr["ownerName"];
    this.value = mapArr["value"];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = super.toJson();
    // final Map<String, dynamic> jsonObj = Map<String, dynamic>();

    jsonObj["ownerId"] = this.ownerId;
    jsonObj["mobileNo"] = this.mobileNo;
    jsonObj["ownerName"] = this.ownerName;

    // jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
