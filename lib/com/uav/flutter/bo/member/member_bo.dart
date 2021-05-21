import 'dart:convert';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/service/http_service/http_service.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/otp/otp_vo.dart';

class MemberBO {
  List<String> errors = [];
  OtpVO resOtpVO = new OtpVO();
  Future<Object> getMemberByMobileNo(MemberVO reqMemberVO) async {
    try {
      HttpService httpService = new HttpService();
      var action = "rest/stateless/getCustomerByMobileNumber";

      var httpResponse =
          await httpService.postRequest(action, reqMemberVO.toJson());

      if (httpResponse.status == "success") {
        resOtpVO = OtpVO.fromJson(httpResponse.dataList);
        resOtpVO.status = httpResponse.status;
        resOtpVO.message = httpResponse.message;
      } else {
        errors.add(httpResponse.message);
      }
    } on Exception catch (exception) {
      errors.add(exception.toString());
    } catch (error) {
      errors.add(error.toString());
    }

    if (errors.length > 0) {
      resOtpVO.status = "fail";
      resOtpVO.message = errors[0];
    }
    return resOtpVO;
  }

  Future<MemberVO> getMemberByEmailId(MemberVO reqMemberVO) async {
    List<String> errors = [];
    MemberVO resMemberVO = new MemberVO();
    try {
      HttpService httpService = new HttpService();

      var httpResponse = await httpService.postRequest(
          UavLoginByEmailIdAndPasswordAction, reqMemberVO.toJson());

      if (httpResponse.status == "success") {
        List dataList = httpResponse.dataList;

        for (var mapArr in dataList) {
          String jsonStr = jsonEncode(mapArr);
          // MemberVO resShipmentUnitVO = new MemberVO();
          resMemberVO = resMemberVO.fromJson(jsonStr);
          resMemberVO.status = httpResponse.status;
          resMemberVO.message = httpResponse.message;
          // resShipmentUnitVOs.add(resShipmentUnitVO);
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
      resMemberVO.status = "fail";
      resMemberVO.message = errors[0];
      // resShipmentUnitVOs.add(resShipmentUnitVO);
    }
    return resMemberVO;
  }

  Future<MemberVO> getMemberByMobileNoAndPassword(MemberVO reqMemberVO) async {
    List<String> errors = [];
    MemberVO resMemberVO = new MemberVO();
    try {
      HttpService httpService = new HttpService();

      var httpResponse = await httpService.postRequest(
          UavLoginByMobileNoAndPasswordAction, reqMemberVO.toJson());

      if (httpResponse.status == "success") {
        List dataList = httpResponse.dataList;

        for (var mapArr in dataList) {
          String jsonStr = jsonEncode(mapArr);
          // MemberVO resShipmentUnitVO = new MemberVO();
          resMemberVO = resMemberVO.fromJson(jsonStr);
          resMemberVO.status = httpResponse.status;
          resMemberVO.message = httpResponse.message;
          // resShipmentUnitVOs.add(resShipmentUnitVO);
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
      resMemberVO.status = "fail";
      resMemberVO.message = errors[0];
      // resShipmentUnitVOs.add(resShipmentUnitVO);
    }
    return resMemberVO;
  }
}
