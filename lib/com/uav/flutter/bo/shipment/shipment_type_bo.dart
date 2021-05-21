import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';

class ShipmentTypeBO {
  Future<List> getShipmentTypeCache(ShipmentTypeVO reqShipmentTypeVO) async {
    List<ShipmentTypeVO> resShipmentTypeVOs = [];
    ShipmentTypeVO resShipmentTypeVO = new ShipmentTypeVO();

    HttpService httpService = new HttpService();

    var httpResponse = await httpService.getRequest(
        UavShipmentTypeCacheAction, reqShipmentTypeVO.toJson());

    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;

      for (var mapArr in dataList) {
        String jsonStr = jsonEncode(mapArr);
        resShipmentTypeVO = resShipmentTypeVO.fromJson(jsonStr);
        resShipmentTypeVOs.add(resShipmentTypeVO);
      }
    } else {
      resShipmentTypeVO.status = "fail";
      resShipmentTypeVO.message = httpResponse.message;
      resShipmentTypeVOs.add(resShipmentTypeVO);
    }

    return resShipmentTypeVOs;
  }
}
