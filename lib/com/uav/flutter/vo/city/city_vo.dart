import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';

class CityVO extends BaseVO {
  var cityId;

  var cityName;

  CityVO({
    this.cityId,
    this.cityName,
  });

  fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    this.cityId = mapArr["cityId"];
    this.cityName = mapArr["cityName"];

    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = super.toJson();
    // final Map<String, dynamic> jsonObj = Map<String, dynamic>();

    jsonObj["cityId"] = this.cityId;
    jsonObj["cityName"] = this.cityName;

    jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
