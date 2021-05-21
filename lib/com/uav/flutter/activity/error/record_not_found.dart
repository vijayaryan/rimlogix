import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';

class RecordNotFound extends StatelessWidget {
  static String routeName = "/record_not_found";

  @override
  Widget build(BuildContext context) {
    UavAppBar uavAppBar = new UavAppBar(
      automaticallyImplyLeading: false,
      title: "Record Not Found",
    );

    UavBody uavBody = new UavBody(
        body: Container(
      child: Text("No Record Found"),
    ));

    UavScaffold uavScaffold = new UavScaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: uavAppBar),
        body: uavBody);

    return uavScaffold;
  }
}
