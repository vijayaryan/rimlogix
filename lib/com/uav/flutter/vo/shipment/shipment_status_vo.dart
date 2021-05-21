import 'dart:convert';
import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';

class ShipmentStatusVO extends BaseVO {
  static const Planned = 1;
  static const Booked = 3;
  static const Delivered = 7;

  var shipmentStatusId;
  var statusName;

  ShipmentStatusVO({
    this.shipmentStatusId,
    this.statusName,
  });

  fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    this.shipmentStatusId = mapArr["shipmentStatusId"];
    this.statusName = mapArr["statusName"];

    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = super.toJson();

    jsonObj["shipmentStatusId"] = this.shipmentStatusId;
    jsonObj["statusName"] = this.statusName;

    jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
