import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/carrier/driver_vo.dart';

class DriverBO {
  Future<List> getDriverByAutoSuggest(DriverVO reqDriverVO) async {
    List<DriverVO> resDriverVOs = [];
    DriverVO resDriverVO = new DriverVO();

    HttpService httpService = new HttpService();

    var httpResponse = await httpService.postRequest(
        UavDriverByAutoSuggestAction, reqDriverVO.toJson());

    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;
      if (dataList.length > 0) {
        for (var mapArr in dataList) {
          String jsonStr = jsonEncode(mapArr);
          resDriverVO = resDriverVO.fromJson(jsonStr);
          resDriverVO.status = httpResponse.status;
          resDriverVO.message = httpResponse.message;
          resDriverVOs.add(resDriverVO);
        }
      } else {
        resDriverVO.status = "fail";
        resDriverVO.message = UavPatternNotMatchedError;
        resDriverVOs.add(resDriverVO);
      }
    } else {
      resDriverVO.status = "fail";
      resDriverVO.message = httpResponse.message;
      resDriverVOs.add(resDriverVO);
    }

    return resDriverVOs;
  }
}
