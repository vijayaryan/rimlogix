import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_booking_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';

class ShipmentBookingTypeBO {
  Future<List> getShipmentBookingTypeCache(
      ShipmentBookingTypeVO reqShipmentBookingTypeVO) async {
    List<ShipmentBookingTypeVO> resShipmentBookingTypeVOs = [];
    ShipmentBookingTypeVO resShipmentBookingTypeVO =
        new ShipmentBookingTypeVO();

    HttpService httpService = new HttpService();

    var httpResponse = await httpService.getRequest(
        UavShipmentBookingTypeCacheAction, reqShipmentBookingTypeVO.toJson());

    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;

      for (var mapArr in dataList) {
        String jsonStr = jsonEncode(mapArr);
        resShipmentBookingTypeVO = resShipmentBookingTypeVO.fromJson(jsonStr);
        resShipmentBookingTypeVOs.add(resShipmentBookingTypeVO);
      }
    } else {
      resShipmentBookingTypeVO.status = "fail";
      resShipmentBookingTypeVO.message = httpResponse.message;
      resShipmentBookingTypeVOs.add(resShipmentBookingTypeVO);
    }

    return resShipmentBookingTypeVOs;
  }
}
