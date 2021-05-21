import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/bo/shipment/shipment_unit_bo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/cards.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_status_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_unit_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingList extends StatefulWidget {
  static String routeName = "/shipment_unit_list";
  final Map param;
  BookingList({this.param});
  @override
  _BookingListState createState() => _BookingListState();
}

class _BookingListState extends State<BookingList> {
  List<ShipmentUnitVO> shipmentUnitVOs = [];

  @override
  void initState() {
    super.initState();
    getShipmentUnitList();
  }

  Future getShipmentUnitList() async {
    ShipmentUnitBO shipmentUnitBO = new ShipmentUnitBO();
    ShipmentUnitVO reqShipmentUnitVO = new ShipmentUnitVO();
    ShipmentStatusVO shipmentStatusVO = new ShipmentStatusVO();
    MemberVO memberVO = new MemberVO();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var memberId = prefs.get("memberId");
    if (memberId != null) {
      memberVO.memberId = memberId;
    }

    shipmentUnitVOs = [];
    reqShipmentUnitVO.pageNumber = 1;
    reqShipmentUnitVO.pageSize = 50;
    reqShipmentUnitVO.sortOrderColumn = "unitId";
    reqShipmentUnitVO.orderDir = "desc";
    reqShipmentUnitVO.filters = null;

    shipmentStatusVO.shipmentStatusId = 0;
    print(widget.param["shipmentStatusId"]);
    if (widget.param["shipmentStatusId"] != null) {
      shipmentStatusVO.shipmentStatusId = widget.param["shipmentStatusId"];
    }

    reqShipmentUnitVO.member = memberVO.toJson();
    reqShipmentUnitVO.shipmentStatus = shipmentStatusVO.toJson();

    List dataList = await shipmentUnitBO.getShipmentUnitList(reqShipmentUnitVO);

    setState(() {
      shipmentUnitVOs = dataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);

    UavAppBar uavAppBar =
        new UavAppBar(title: "Shipment List", automaticallyImplyLeading: false);

    UavBody uavBody = new UavBody(
      body: ListView.builder(
        itemCount: shipmentUnitVOs.length,
        itemBuilder: (context, index) {
          var shipmentUnitVO = shipmentUnitVOs[index];
          if (shipmentUnitVO.unitId != null) {
            return UavCards.getBookedListCard(shipmentUnitVO);
          } else {
            return Text("Record not found.");
          }
        },
      ),
    );

    UavScaffold uavScaffold = new UavScaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: uavAppBar),
        body: uavBody);

    return uavScaffold;
  }
}
