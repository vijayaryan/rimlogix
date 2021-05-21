import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_unit_vo.dart';

class UavCards {
  static Container getBookedListCard(ShipmentUnitVO shipmentUnitVO) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: UavSecondaryColor),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                  margin: EdgeInsets.only(right: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        "RRN : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (shipmentUnitVO.unitId != null)
                            ? shipmentUnitVO.unitId.toString()
                            : "",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  height: 20,
                  // width: 125,
                  margin: EdgeInsets.only(left: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        (shipmentUnitVO.originName != null)
                            ? shipmentUnitVO.originName
                                    .toString()
                                    .toUpperCase() +
                                " -> "
                            : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (shipmentUnitVO.destinationName != null)
                            ? shipmentUnitVO.destinationName
                                .toString()
                                .toUpperCase()
                            : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  height: 20,
                  // width: 125,
                  margin: EdgeInsets.only(left: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        "WEIGHT : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        (shipmentUnitVO.chargeableWt != null &&
                                shipmentUnitVO.measurementUnitTypeName != null)
                            ? shipmentUnitVO.chargeableWt.toString() +
                                " " +
                                shipmentUnitVO.measurementUnitTypeName
                                    .toString()
                            : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  height: 20,
                  margin: EdgeInsets.only(left: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        "Pickup Date : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        (shipmentUnitVO.planForDate != null)
                            ? shipmentUnitVO.planForDate.toString()
                            : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Spacer(),
              Container(
                  // height: 20,
                  // width: 125,
                  margin: EdgeInsets.only(right: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        "STATUS : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (shipmentUnitVO.shipmentStatusName != null)
                            ? shipmentUnitVO.shipmentStatusName
                                .toString()
                                .toUpperCase()
                            : "",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  height: 20,
                  margin: EdgeInsets.only(left: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        "Customer Mobile No : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Spacer(),
              Container(
                  // height: 20,
                  // width: 125,
                  margin: EdgeInsets.only(right: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        (shipmentUnitVO.memberMobileNo != null)
                            ? shipmentUnitVO.memberMobileNo.toString()
                            : "",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }

  static Container getPlannedListCard(ShipmentUnitVO shipmentUnitVO) {
    return Container(
      height: 120,
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: UavSecondaryColor),
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: <Widget>[
              Spacer(),
              Container(
                  margin: EdgeInsets.only(right: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        "RRN : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (shipmentUnitVO.unitId != null)
                            ? shipmentUnitVO.unitId.toString()
                            : "",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  height: 20,
                  // width: 125,
                  margin: EdgeInsets.only(left: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        (shipmentUnitVO.originName != null)
                            ? shipmentUnitVO.originName
                                    .toString()
                                    .toUpperCase() +
                                " -> "
                            : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (shipmentUnitVO.destinationName != null)
                            ? shipmentUnitVO.destinationName
                                .toString()
                                .toUpperCase()
                            : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  height: 20,
                  // width: 125,
                  margin: EdgeInsets.only(left: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        "WEIGHT : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        (shipmentUnitVO.chargeableWt != null &&
                                shipmentUnitVO.measurementUnitTypeName != null)
                            ? shipmentUnitVO.chargeableWt.toString() +
                                " " +
                                shipmentUnitVO.measurementUnitTypeName
                                    .toString()
                            : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  height: 20,
                  margin: EdgeInsets.only(left: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        "Pickup Date : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        (shipmentUnitVO.planForDate != null)
                            ? shipmentUnitVO.planForDate.toString()
                            : "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Spacer(),
              Container(
                  // height: 20,
                  // width: 125,
                  margin: EdgeInsets.only(right: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        "STATUS : ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (shipmentUnitVO.shipmentStatusName != null)
                            ? shipmentUnitVO.shipmentStatusName
                                .toString()
                                .toUpperCase()
                            : "",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
          Row(
            children: <Widget>[
              Container(
                  height: 20,
                  margin: EdgeInsets.only(left: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        "Customer Mobile No : ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
              Spacer(),
              Container(
                  // height: 20,
                  // width: 125,
                  margin: EdgeInsets.only(right: 8.0),
                  padding: EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Row(
                    children: [
                      Text(
                        (shipmentUnitVO.memberMobileNo != null)
                            ? shipmentUnitVO.memberMobileNo.toString()
                            : "",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
