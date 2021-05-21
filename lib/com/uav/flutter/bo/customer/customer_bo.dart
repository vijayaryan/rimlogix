import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/customer/customer_vo.dart';

class CustomerBO {
  Future<List> getCustomerByAutoSuggest(CustomerVO reqCustomerVO) async {
    List<CustomerVO> resCustomerVOs = [];
    CustomerVO resCustomerVO = new CustomerVO();

    HttpService httpService = new HttpService();

    var httpResponse = await httpService.postRequest(
        UavCustomerByAutoSuggestAction, reqCustomerVO.toJson());

    if (httpResponse.status == "success") {
      List dataList = httpResponse.dataList;

      if (dataList.length > 0) {
        for (var mapArr in dataList) {
          String jsonStr = jsonEncode(mapArr);
          resCustomerVO = resCustomerVO.fromJson(jsonStr);
          resCustomerVO.status = httpResponse.status;
          resCustomerVO.message = httpResponse.message;
          resCustomerVOs.add(resCustomerVO);
        }
      } else {
        resCustomerVO.status = "fail";
        resCustomerVO.message = UavPatternNotMatchedError;
        resCustomerVOs.add(resCustomerVO);
      }
    } else {
      resCustomerVO.status = "fail";
      resCustomerVO.message = httpResponse.message;
      resCustomerVOs.add(resCustomerVO);
    }

    return resCustomerVOs;
  }
}
