import 'dart:convert';
import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';

class ShipmentBookingTypeVO extends BaseVO {
  int typeId;
  String typeName;

  ShipmentBookingTypeVO({
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

    jsonObj["typeID"] = this.typeId;
    jsonObj["typeName"] = this.typeName;

    jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
