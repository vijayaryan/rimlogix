import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/measurement_unit_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';

class MeasurementUnitTypeBO {
  Future<List> getMeasurementUnitTypeCache() async {
    List resDataList = [];
    Map<String, dynamic> data = {};
    HttpService httpService = new HttpService();
    var httpResponse =
        await httpService.getRequest(UavMeasurementUnitTypeCacheAction, data);
    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;
      for (var mapArr in dataList) {
        Map<String, dynamic> mapData = {};
        MeasurementUnitTypeVO resMeasurementUnitTypeVO =
            new MeasurementUnitTypeVO();
        String jsonStr = jsonEncode(mapArr);
        resMeasurementUnitTypeVO = resMeasurementUnitTypeVO.fromJson(jsonStr);
        List<int> allowList = [1, 3, 4];
        if (allowList.contains(resMeasurementUnitTypeVO.typeId)) {
          mapData = {
            "display": resMeasurementUnitTypeVO.typeName,
            "value": resMeasurementUnitTypeVO.typeId
          };
          resDataList.add(mapData);
        }
      }
    }
    return resDataList;
  }

  /*
  Future<List> getMeasurementUnitTypeCache() async {
    List<MeasurementUnitTypeVO> resMeasurementUnitTypeVOs = [];
    MeasurementUnitTypeVO resMeasurementUnitTypeVO =
        new MeasurementUnitTypeVO();
    Map<String, dynamic> data = {};
    HttpService httpService = new HttpService();

    var httpResponse =
        await httpService.getRequest(UavMeasurementUnitTypeCacheAction, data);

    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;

      for (var mapArr in dataList) {
        String jsonStr = jsonEncode(mapArr);
        resMeasurementUnitTypeVO = resMeasurementUnitTypeVO.fromJson(jsonStr);
        resMeasurementUnitTypeVOs.add(resMeasurementUnitTypeVO);
      }
    } else {
      resMeasurementUnitTypeVO.status = "fail";
      resMeasurementUnitTypeVO.message = httpResponse.message;
      resMeasurementUnitTypeVOs.add(resMeasurementUnitTypeVO);
    }

    return resMeasurementUnitTypeVOs;
  }
  */
}
