import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';

class CustomerVO extends BaseVO {
  int customerId;
  String name;
  String mobileNo;
  String gstNo;
  String panNo;
  String aadharNo;
  String address;
  String value;
  CustomerVO(
      {this.customerId,
      this.name,
      this.mobileNo,
      this.gstNo,
      this.panNo,
      this.aadharNo,
      this.address,
      this.value});

  fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    this.customerId = mapArr["customerId"];
    this.name = mapArr["name"];
    this.mobileNo = mapArr["mobileNo"];
    this.gstNo = mapArr["gstNo"];
    this.panNo = mapArr["panNo"];
    this.aadharNo = mapArr["aadharNo"];
    this.address = mapArr["address"];
    this.value = mapArr["value"];
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = super.toJson();
    // final Map<String, dynamic> jsonObj = Map<String, dynamic>();

    jsonObj["customerId"] = this.customerId;
    jsonObj["name"] = this.name;
    jsonObj["mobileNo"] = this.mobileNo;
    jsonObj["gstNo"] = this.gstNo;
    jsonObj["panNo"] = this.panNo;
    jsonObj["aadharNo"] = this.aadharNo;
    jsonObj["address"] = this.address;

    jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
