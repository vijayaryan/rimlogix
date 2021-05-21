import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/content_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';

class ContentTypeBO {
  Future<List> getContentTypeCache() async {
    List resDataList = [];
    Map<String, dynamic> data = {};
    HttpService httpService = new HttpService();
    var httpResponse =
        await httpService.getRequest(UavContentTypeCacheAction, data);
    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;
      for (var mapArr in dataList) {
        Map<String, dynamic> mapData = {};
        ContentTypeVO resContentTypeVO = new ContentTypeVO();
        String jsonStr = jsonEncode(mapArr);
        resContentTypeVO = resContentTypeVO.fromJson(jsonStr);

        List<int> allowList = [1, 2];
        if (allowList.contains(resContentTypeVO.typeId)) {
          mapData = {
            "display": resContentTypeVO.typeName,
            "value": resContentTypeVO.typeId
          };
          resDataList.add(mapData);
        }
      }
    }
    return resDataList;
  }

  /*
  Future<List> getContentTypeCache() async {
    List<ContentTypeVO> resContentTypeVOs = [];
    ContentTypeVO resContentTypeVO = new ContentTypeVO();
    Map<String, dynamic> data = {};
    HttpService httpService = new HttpService();

    var httpResponse =
        await httpService.getRequest(UavContentTypeCacheAction, data);

    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;
       
      for (var mapArr in dataList) {
        String jsonStr = jsonEncode(mapArr);
        resContentTypeVO = resContentTypeVO.fromJson(jsonStr);
        resContentTypeVOs.add(resContentTypeVO);
      }
       
    } else {
      resContentTypeVO.status = "fail";
      resContentTypeVO.message = httpResponse.message;
      resContentTypeVOs.add(resContentTypeVO);
    }

    return resContentTypeVOs;
  }
  */
}
