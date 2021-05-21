import 'dart:convert';
import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';

class MeasurementUnitTypeVO extends BaseVO {
  var typeId;
  var typeName;

  MeasurementUnitTypeVO({
    this.typeId,
    this.typeName,
  });

  fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    this.typeId = mapArr["typeId"];
    this.typeName = mapArr["typeName"];

    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = super.toJson();

    jsonObj["typeId"] = this.typeId;
    jsonObj["typeName"] = this.typeName;

    jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
