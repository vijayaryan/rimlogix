import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/container_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';

class ContainerTypeBO {
  Future<List> getContainerTypeCache() async {
    List resDataList = [];

    Map<String, dynamic> data = {};
    HttpService httpService = new HttpService();

    var httpResponse =
        await httpService.getRequest(UavContainerTypeCacheAction, data);

    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;
      for (var mapArr in dataList) {
        Map<String, dynamic> mapData = {};
        ContainerTypeVO resContainerTypeVO = new ContainerTypeVO();
        String jsonStr = jsonEncode(mapArr);
        resContainerTypeVO = resContainerTypeVO.fromJson(jsonStr);
        mapData = {
          "display": resContainerTypeVO.typeName,
          "value": resContainerTypeVO.typeId
        };
        resDataList.add(mapData);
      }
    }

    return resDataList;
  }
}
