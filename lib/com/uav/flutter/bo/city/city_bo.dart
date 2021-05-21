import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/city/city_vo.dart';

class CityBO {
  Future<List> getCityByAutoSuggest(CityVO reqCityVO) async {
    List<CityVO> resCityVOs = [];
    CityVO resCityVO = new CityVO();

    HttpService httpService = new HttpService();

    var httpResponse = await httpService.postRequest(
        UavCityByAutoSuggestAction, reqCityVO.toJson());

    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;
      if (dataList.length > 0) {
        for (var mapArr in dataList) {
          String jsonStr = jsonEncode(mapArr);
          resCityVO = resCityVO.fromJson(jsonStr);
          resCityVO.status = httpResponse.status;
          resCityVO.message = httpResponse.message;
          resCityVOs.add(resCityVO);
        }
      } else {
        resCityVO.status = "fail";
        resCityVO.message = UavPatternNotMatchedError;
        resCityVOs.add(resCityVO);
      }
    } else {
      resCityVO.status = "fail";
      resCityVO.message = httpResponse.message;
      resCityVOs.add(resCityVO);
    }

    return resCityVOs;
  }
}
