import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/bo/shipment/shipment_unit_bo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/service/auth_service/auth_service.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/cards.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_status_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_unit_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransporterPlannedList extends StatefulWidget {
  final Map param;
  TransporterPlannedList({this.param});
  @override
  _TransporterPlannedListState createState() => _TransporterPlannedListState();
}

class _TransporterPlannedListState extends State<TransporterPlannedList> {
  final uavScaffoldKey = new GlobalKey<ScaffoldState>();

  SharedPreferences prefs;
  AuthService authService = new AuthService();
  List<ShipmentUnitVO> shipmentUnitVOs = [];

  @override
  void initState() {
    super.initState();
    defaultSetting();
  }

  Future defaultSetting() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("currentActivity", UavRoutes.TransporterPlannedList);
    authService.checkAuthenticity(context);

    getTransporterPlannedList();
  }

  Future getTransporterPlannedList() async {
    ShipmentUnitBO shipmentUnitBO = new ShipmentUnitBO();
    ShipmentUnitVO reqShipmentUnitVO = new ShipmentUnitVO();
    ShipmentStatusVO shipmentStatusVO = new ShipmentStatusVO();
    MemberVO memberVO = new MemberVO();

    UavUtility.showLoader(uavScaffoldKey, "loading...");

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
    if (widget.param["shipmentStatusId"] != null) {
      shipmentStatusVO.shipmentStatusId = widget.param["shipmentStatusId"];
    }

    reqShipmentUnitVO.member = memberVO.toJson();
    reqShipmentUnitVO.shipmentStatus = shipmentStatusVO.toJson();
    List dataList = await shipmentUnitBO.getPlannedList(reqShipmentUnitVO);

    setState(() {
      shipmentUnitVOs = dataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);

    UavAppBar uavAppBar =
        new UavAppBar(title: "Planned List", automaticallyImplyLeading: false);

    UavBody uavBody = new UavBody(
      body: ListView.builder(
        itemCount: shipmentUnitVOs.length,
        itemBuilder: (context, index) {
          var shipmentUnitVO = shipmentUnitVOs[index];
          if (shipmentUnitVO.unitId != null) {
            return UavCards.getPlannedListCard(shipmentUnitVO);
          } else {
            return Text("Record not found.");
          }
        },
      ),
    );

    UavScaffold uavScaffold = new UavScaffold(
        uavKey: uavScaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: uavAppBar),
        body: uavBody);

    return uavScaffold;
  }
}
