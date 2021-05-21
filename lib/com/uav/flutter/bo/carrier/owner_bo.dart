import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/carrier/owner_vo.dart';

class OwnerBO {
  Future<List> getOwnerByAutoSuggest(OwnerVO reqOwnerVO) async {
    List<OwnerVO> resOwnerVOs = [];
    OwnerVO resOwnerVO = new OwnerVO();

    HttpService httpService = new HttpService();

    var httpResponse = await httpService.postRequest(
        UavOwnerByAutoSuggestAction, reqOwnerVO.toJson());

    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;
      if (dataList.length > 0) {
        for (var mapArr in dataList) {
          String jsonStr = jsonEncode(mapArr);
          resOwnerVO = resOwnerVO.fromJson(jsonStr);
          resOwnerVO.status = httpResponse.status;
          resOwnerVO.message = httpResponse.message;
          resOwnerVOs.add(resOwnerVO);
        }
      } else {
        resOwnerVO.status = "fail";
        resOwnerVO.message = UavPatternNotMatchedError;
        resOwnerVOs.add(resOwnerVO);
      }
    } else {
      resOwnerVO.status = "fail";
      resOwnerVO.message = httpResponse.message;
      resOwnerVOs.add(resOwnerVO);
    }

    return resOwnerVOs;
  }
}
