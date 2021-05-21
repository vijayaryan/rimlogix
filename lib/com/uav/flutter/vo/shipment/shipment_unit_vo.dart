import 'dart:convert';

import 'package:rimlogix/com/uav/flutter/vo/base_vo.dart';
// import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
// import 'package:rimlogix/com/uav/flutter/vo/shipment/measurement_unit_type_vo.dart';

class ShipmentUnitVO extends BaseVO {
  var unitId;
  var weight;
  var chargeableWt;
  var rate;
  var freight;
  var stCharges;
  var colCharges;
  var otherCharges;
  var grossAmount;
  var cgstAmount;
  var sgstAmount;
  var igstAmount;
  var netAmount;
  var advance;
  var balance;
  var docketNumber;
  var shipmentStatusName;
  var origin;
  var originName;
  var pickupPoint;
  var destination;
  var dropPoint;
  var deliveryAt;
  var destinationName;
  var consignor;
  var consignee;
  var carrier;
  var carrierOwner;
  var carrierDriver;
  var measurementUnitType;
  var bookingDate;
  var planForDate;
  var goodsName;
  var member;
  var referenceNumber;
  var shipmentStatus;
  var contentType;
  var containerType;
  var shipmentType;
  var bookingType;
  var documentType;
  var invoiceNumber;
  var boxes;
  var shipmentValue;
  var eWayBillno;
  var ewayBillExpiryDate;
  var hsnCode;
  var remarks;
  var gstPaidBy;
  var billingStation;
  var description;
  var billWeight;
  var transporterIds;
  var createdAt;
  var measurementUnitTypeName;
  var memberName;
  var memberMobileNo;

  ShipmentUnitVO({
    this.unitId,
    this.origin,
    this.originName,
    this.pickupPoint,
    this.destination,
    this.destinationName,
    this.dropPoint,
    this.deliveryAt,
    this.consignor,
    this.consignee,
    this.carrier,
    this.carrierOwner,
    this.carrierDriver,
    this.measurementUnitType,
    this.bookingDate,
    this.planForDate,
    this.weight,
    this.chargeableWt,
    this.rate,
    this.freight,
    this.stCharges,
    this.colCharges,
    this.otherCharges,
    this.grossAmount,
    this.cgstAmount,
    this.sgstAmount,
    this.igstAmount,
    this.netAmount,
    this.advance,
    this.balance,
    this.docketNumber,
    this.goodsName,
    this.shipmentStatusName,
    this.member,
    this.referenceNumber,
    this.shipmentStatus,
    this.contentType,
    this.containerType,
    this.shipmentType,
    this.bookingType,
    this.documentType,
    this.invoiceNumber,
    this.boxes,
    this.shipmentValue,
    this.eWayBillno,
    this.ewayBillExpiryDate,
    this.hsnCode,
    this.remarks,
    this.gstPaidBy,
    this.billingStation,
    this.description,
    this.billWeight,
    this.transporterIds,
    this.createdAt,
    this.measurementUnitTypeName,
    this.memberName,
    this.memberMobileNo,
  });

  fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    this.unitId = mapArr["unitId"];
    this.origin = mapArr["origin"];
    this.originName = mapArr["originName"];
    this.pickupPoint = mapArr["pickupPoint"];
    this.destination = mapArr["destination"];
    this.destinationName = mapArr["destinationName"];
    this.dropPoint = mapArr["dropPoint"];
    this.deliveryAt = mapArr["deliveryAt"];
    this.consignor = mapArr["consignor"];
    this.consignee = mapArr["consignee"];
    this.carrier = mapArr["carrier"];
    this.carrierOwner = mapArr["carrierOwner"];
    this.carrierDriver = mapArr["carrierDriver"];

    this.measurementUnitType = mapArr["measurementUnitType"];
    /*
    MeasurementUnitTypeVO measurementUnitTypeVO = MeasurementUnitTypeVO();
    this.measurementUnitType = measurementUnitTypeVO
        .fromJson(jsonEncode(mapArr["measurementUnitType"]));
    */

    this.bookingDate = mapArr["bookingDate"];
    this.planForDate = mapArr["planForDate"];
    this.weight = mapArr["weight"];
    this.chargeableWt = mapArr["chargeableWt"];

    this.rate = mapArr["rate"];
    this.freight = mapArr["freight"];
    this.stCharges = mapArr["stCharges"];
    this.colCharges = mapArr["colCharges"];
    this.otherCharges = mapArr["otherCharges"];
    this.grossAmount = mapArr["grossAmount"];
    this.cgstAmount = mapArr["cgstAmount"];
    this.sgstAmount = mapArr["sgstAmount"];
    this.igstAmount = mapArr["igstAmount"];
    this.netAmount = mapArr["netAmount"];
    this.advance = mapArr["advance"];
    this.balance = mapArr["balance"];

    this.docketNumber = mapArr["docketno"];
    this.goodsName = mapArr["goodsName"];
    this.shipmentStatusName = mapArr["shipmentStatusName"];

    this.member = mapArr["member"];

    /*
    MemberVO memberVO = new MemberVO();
    this.member = memberVO.fromJson(jsonEncode(mapArr["member"]));
    */

    this.referenceNumber = mapArr["referenceNumber"];
    this.shipmentStatus = mapArr["shipmentStatus"];
    this.contentType = mapArr["contentType"];
    this.containerType = mapArr["containerType"];
    this.shipmentType = mapArr["shipmentType"];
    this.bookingType = mapArr["bookingType"];
    this.documentType = mapArr["documentType"];
    this.invoiceNumber = mapArr["invoiceNumber"];
    this.boxes = mapArr["boxes"];
    this.shipmentValue = mapArr["shipmentValue"];
    this.eWayBillno = mapArr["eWayBillno"];
    this.ewayBillExpiryDate = mapArr["ewayBillExpiryDate"];
    this.hsnCode = mapArr["hsnCode"];
    this.remarks = mapArr["remarks"];
    this.gstPaidBy = mapArr["gstPaidBy"];
    this.billingStation = mapArr["billingStation"];
    this.description = mapArr["description"];
    this.billWeight = mapArr["billWeight"];
    this.transporterIds = mapArr["transporterIds"];
    this.createdAt = mapArr["createdAt"];
    this.measurementUnitTypeName = mapArr["measurementUnitTypeName"];
    this.memberName = mapArr["memberName"];
    this.memberMobileNo = mapArr["memberMobileNo"];

/*
    this.createdAt = mapArr["createdAt"] != null
        ? DateTime.parse(mapArr["createdAt"])
        : null;
*/
    return this;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = super.toJson();
    // final Map<String, dynamic> jsonObj = Map<String, dynamic>();

    jsonObj["unitId"] = this.unitId;
    jsonObj["origin"] = this.origin;
    jsonObj["pickupPoint"] = this.pickupPoint;
    jsonObj["destination"] = this.destination;
    jsonObj["dropPoint"] = this.dropPoint;
    jsonObj["deliveryAt"] = this.deliveryAt;
    jsonObj["consignor"] = this.consignor;
    jsonObj["consignee"] = this.consignee;
    jsonObj["carrier"] = this.carrier;
    jsonObj["carrierOwner"] = this.carrierOwner;
    jsonObj["carrierDriver"] = this.carrierDriver;
    jsonObj["measurementUnitType"] = this.measurementUnitType;
    jsonObj["bookingDate"] = this.bookingDate;
    jsonObj["planForDate"] = this.planForDate;
    jsonObj["chargeableWt"] = this.chargeableWt;
    jsonObj["rate"] = this.rate;
    jsonObj["freight"] = this.freight;
    jsonObj["stCharges"] = this.stCharges;
    jsonObj["colCharges"] = this.colCharges;
    jsonObj["otherCharges"] = this.otherCharges;
    jsonObj["grossAmount"] = this.grossAmount;
    jsonObj["cgstAmount"] = this.cgstAmount;
    jsonObj["sgstAmount"] = this.sgstAmount;
    jsonObj["igstAmount"] = this.igstAmount;
    jsonObj["netAmount"] = this.netAmount;
    jsonObj["advance"] = this.advance;
    jsonObj["balance"] = this.balance;

    jsonObj["goodsName"] = this.goodsName;
    jsonObj["member"] = this.member;
    jsonObj["referenceNumber"] = this.referenceNumber;
    jsonObj["shipmentStatus"] = this.shipmentStatus;
    jsonObj["contentType"] = this.contentType;
    jsonObj["containerType"] = this.containerType;
    jsonObj["shipmentType"] = this.shipmentType;
    jsonObj["bookingType"] = this.bookingType;
    jsonObj["documentType"] = this.documentType;
    jsonObj["invoiceNumber"] = this.invoiceNumber;
    jsonObj["boxes"] = this.boxes;
    jsonObj["shipmentValue"] = this.shipmentValue;
    jsonObj["eWayBillno"] = this.eWayBillno;
    jsonObj["ewayBillExpiryDate"] = this.ewayBillExpiryDate;
    jsonObj["hsnCode"] = this.hsnCode;
    jsonObj["remarks"] = this.remarks;
    jsonObj["gstPaidBy"] = this.gstPaidBy;
    jsonObj["billingStation"] = this.billingStation;
    jsonObj["description"] = this.description;
    jsonObj["billWeight"] = this.billWeight;
    jsonObj["transporterIds"] = this.transporterIds;
    jsonObj["createdAt"] = this.createdAt;
    jsonObj["measurementUnitTypeName"] = this.measurementUnitTypeName;
    jsonObj["memberName"] = this.memberName;
    jsonObj["memberMobileNo"] = this.memberMobileNo;

    jsonObj.removeWhere((key, value) => key == null || value == null);

    return jsonObj;
  }
}
