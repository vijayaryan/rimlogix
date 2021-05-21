import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';

class DriverVO extends BaseVO {
  var driverId;
  var mobileNo;
  var driverName;
  var value;
  DriverVO({this.driverId, this.mobileNo, this.driverName, this.value});

  fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    this.driverId = mapArr["driverId"];
    this.mobileNo = mapArr["mobileNo"];
    this.driverName = mapArr["driverName"];
    this.value = mapArr["value"];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = super.toJson();
    // final Map<String, dynamic> jsonObj = Map<String, dynamic>();

    jsonObj["driverId"] = this.driverId;
    jsonObj["mobileNo"] = this.mobileNo;
    jsonObj["driverName"] = this.driverName;

    // jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
