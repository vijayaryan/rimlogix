import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_unit_vo.dart';

class ShipmentUnitBO {
  Future<List> getShipmentUnitList(ShipmentUnitVO reqShipmentUnitVO) async {
    List<String> errors = [];
    List<ShipmentUnitVO> resShipmentUnitVOs = [];
    ShipmentUnitVO resShipmentUnitVO = new ShipmentUnitVO();
    try {
      HttpService httpService = new HttpService();

      var httpResponse = await httpService.postRequest(
          UavBookingListAction, reqShipmentUnitVO.toJson());

      if (httpResponse.status == "success") {
        List dataList = httpResponse.dataList;

        for (var mapArr in dataList) {
          String jsonStr = jsonEncode(mapArr);
          ShipmentUnitVO resShipmentUnitVO = new ShipmentUnitVO();
          resShipmentUnitVO = resShipmentUnitVO.fromJson(jsonStr);

          resShipmentUnitVOs.add(resShipmentUnitVO);
        }
      } else {
        errors.add(httpResponse.message);
      }
    } on Exception catch (exception) {
      errors.add(exception.toString());
    } catch (error) {
      errors.add(error.toString());
    }

    if (errors.length > 0) {
      resShipmentUnitVO.status = "fail";
      resShipmentUnitVO.message = errors[0];
      resShipmentUnitVOs.add(resShipmentUnitVO);
    }
    return resShipmentUnitVOs;
  }

  Future<List> getPlannedList(ShipmentUnitVO reqShipmentUnitVO) async {
    List<String> errors = [];
    List<ShipmentUnitVO> resShipmentUnitVOs = [];
    ShipmentUnitVO resShipmentUnitVO = new ShipmentUnitVO();
    try {
      HttpService httpService = new HttpService();

      var httpResponse = await httpService.postRequest(
          UavPlannedListAction, reqShipmentUnitVO.toJson());

      if (httpResponse.status == "success") {
        List dataList = httpResponse.dataList;

        for (var mapArr in dataList) {
          String jsonStr = jsonEncode(mapArr);
          ShipmentUnitVO resShipmentUnitVO = new ShipmentUnitVO();
          resShipmentUnitVO = resShipmentUnitVO.fromJson(jsonStr);

          resShipmentUnitVOs.add(resShipmentUnitVO);
        }
      } else {
        errors.add(httpResponse.message);
      }
    } on Exception catch (exception) {
      errors.add(exception.toString());
    } catch (error) {
      errors.add(error.toString());
    }

    if (errors.length > 0) {
      resShipmentUnitVO.status = "fail";
      resShipmentUnitVO.message = errors[0];
      resShipmentUnitVOs.add(resShipmentUnitVO);
    }
    return resShipmentUnitVOs;
  }

  Future<ShipmentUnitVO> createBookingRequest(
      ShipmentUnitVO reqShipmentUnitVO) async {
    ShipmentUnitVO resShipmentUnitVO = new ShipmentUnitVO();

    HttpService httpService = new HttpService();
    var httpResponse = await httpService.postRequest(
        UavCreateBookingRequestAction, reqShipmentUnitVO.toJson());

    if (httpResponse.status == "success") {
      resShipmentUnitVO.status = httpResponse.status;
      resShipmentUnitVO.message = httpResponse.message;
    } else {
      resShipmentUnitVO.status = httpResponse.status;
      resShipmentUnitVO.message = httpResponse.message;
    }

    return resShipmentUnitVO;
  }

  Future<ShipmentUnitVO> saveConsignment(
      ShipmentUnitVO reqShipmentUnitVO) async {
    ShipmentUnitVO resShipmentUnitVO = new ShipmentUnitVO();

    HttpService httpService = new HttpService();
    var httpResponse = await httpService.postRequest(
        UavSaveConsignmentAction, reqShipmentUnitVO.toJson());

    if (httpResponse.status == "success") {
      /*
        List dataList = httpResponse.dataList;

        for (var mapArr in dataList) {
          String jsonStr = jsonEncode(mapArr);
          resShipmentUnitVO = resShipmentUnitVO.fromJson(jsonStr);
        }
        */
      resShipmentUnitVO.status = httpResponse.status;
      resShipmentUnitVO.message = httpResponse.message;
    } else {
      resShipmentUnitVO.status = httpResponse.status;
      resShipmentUnitVO.message = httpResponse.message;
    }

    return resShipmentUnitVO;
  }
}
