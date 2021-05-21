import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';

class CarrierVO extends BaseVO {
  var carrierId;
  var carrierCode;
  var carrierName;

  CarrierVO({
    this.carrierId,
    this.carrierCode,
    this.carrierName,
  });

  fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    this.carrierId = mapArr["carrierId"];
    this.carrierCode = mapArr["carrierCode"];
    this.carrierName = mapArr["carrierName"];

    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = super.toJson();
    // final Map<String, dynamic> jsonObj = Map<String, dynamic>();

    jsonObj["carrierId"] = this.carrierId;
    jsonObj["carrierCode"] = this.carrierCode;
    jsonObj["carrierName"] = this.carrierName;

    // jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
