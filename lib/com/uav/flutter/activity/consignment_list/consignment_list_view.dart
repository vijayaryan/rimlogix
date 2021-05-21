import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/activity/consignment_list/consignment_list_body.dart';

class ConsignmentListView extends StatelessWidget {
  // final String param;
  // final MemberVO memberVO;
  // ConsignmentListView();
  static String routeName = "/consignment_list";
  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Consignment List")),
        // remove back arrow button
        automaticallyImplyLeading: false,
      ),
      body: ConsignmentListBody(),
    );
  }
}
