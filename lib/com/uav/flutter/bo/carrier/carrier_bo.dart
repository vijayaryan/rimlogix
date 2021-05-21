import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/carrier/carrier_vo.dart';

class CarrierBO {
  Future<List> getCarrierByAutoSuggest(CarrierVO reqCarrierVO) async {
    List<CarrierVO> resCarrierVOs = [];
    CarrierVO resCarrierVO = new CarrierVO();

    HttpService httpService = new HttpService();

    var httpResponse = await httpService.postRequest(
        UavCarrierByAutoSuggestAction, reqCarrierVO.toJson());

    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;
      if (dataList.length > 0) {
        for (var mapArr in dataList) {
          CarrierVO carrierVO = new CarrierVO();
          String jsonStr = jsonEncode(mapArr);
          carrierVO = carrierVO.fromJson(jsonStr);
          carrierVO.status = httpResponse.status;
          carrierVO.message = httpResponse.message;
          resCarrierVOs.add(carrierVO);
        }
      } else {
        resCarrierVO.status = "fail";
        resCarrierVO.message = UavPatternNotMatchedError;
        resCarrierVOs.add(resCarrierVO);
      }
    } else {
      resCarrierVO.status = "fail";
      resCarrierVO.message = httpResponse.message;
      resCarrierVOs.add(resCarrierVO);
    }

    return resCarrierVOs;
  }
}
