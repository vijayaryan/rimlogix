// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:rimlogix/com/uav/flutter/uiwidget/button.dart';
// import 'package:rimlogix/com/uav/flutter/components/form_error.dart';
import 'package:rimlogix/com/uav/flutter/components/http.dart';
// import 'package:rimlogix/com/uav/flutter/components/http_response.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/vo/request_data_vo.dart';
// import 'package:rimlogix/com/uav/flutter/vo/shipment_unit_vo.dart';

class ConsignmentListForm extends StatefulWidget {
  @override
  _ConsignmentListFormState createState() => _ConsignmentListFormState();
}

class _ConsignmentListFormState extends State<ConsignmentListForm> {
  // final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  var dataList;
  // final dataList = List<String>.generate(10000, (i) => "Item $i");
  bool isSeleced;
  // HttpResponse httpResponse = new HttpResponse();
  // ShipmentUnitVO shipmentUnitVO;

  @override
  void initState() {
    super.initState();

    getDefaultData();
    // shipmentUnitVO.fromJson(json.decode(httpRes.dataList));
    // print(shipmentUnitVO.docketNo);
    isSeleced = false;
  }

  Future<void> getDefaultData() async {
    var http = new Http();
    var action = "rest/stateless/getConsignmentListV1";
    var callBackFunc = "";

    RequestDataVO requestDataVO = new RequestDataVO();
    requestDataVO.pageNumber = 1;
    requestDataVO.pageSize = 50;
    requestDataVO.sortOrderColumn = "unitId";
    requestDataVO.orderDir = "desc";
    requestDataVO.filters = null;

    var httpRes =
        await http.postRequest(action, requestDataVO.toJson(), callBackFunc);

    // dataList = DataList.fromJson(httpRes.dataList);
    dataList = httpRes.dataList;
    // ShipmentUnitVO dataLists = ShipmentUnitVO.fromJson(dataList);

    print('hello');

    // print(dataLists.unitId);
    // print(dataList);

    return;
  }

  @override
  Widget build(BuildContext context) {
    /*
    return ListView.builder(
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        ListTile(
          title: Text("${dataList[index]}"),
        );
      },
    );
    */
    return Container();
  }
}

class AddTrailing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/Check mark rounde.svg",
      color: UavPrimaryColor,
      width: 22,
    );
  }
}

class RemoveTrailing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
    );
  }
}

class User {
  final String name;
  final String alias;
  User({this.name, this.alias});
  User.fromJson(Map<String, dynamic> data)
      : name = data['name'],
        alias = data['alias'];
}
