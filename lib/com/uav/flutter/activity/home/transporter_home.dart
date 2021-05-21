import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_status_vo.dart';

class TransporterHome extends StatefulWidget {
  @override
  _TransporterHomeState createState() => _TransporterHomeState();
}

class _TransporterHomeState extends State<TransporterHome> {
  /*
  DateTime currBackPressTime;
  Future<bool> isExitFromApp() {
    UavDialog.showExitAppDialog();
    DateTime now = DateTime.now();
    if (currBackPressTime == null ||
        now.difference(currBackPressTime) > Duration(seconds: 5)) {
      currBackPressTime = now;
      UavDialog.showToast("press again to exit.");
      return Future.value(false);
    }
    print('dasf');
    SystemNavigator.pop();
    return Future.value(true);
  }
  */

  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);

    UavAppBar uavAppBar = new UavAppBar(
      title: "Transporter Home",
      automaticallyImplyLeading: false,
    );

    UavBody uavBody = new UavBody(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: List.generate(choices.length, (index) {
            return Center(
              child: SelectCard(choice: choices[index]),
            );
          })),
    ));

    /*
    WillPopScope willPopScope = new WillPopScope(
      child: uavBody,
      onWillPop: () {
        return UavDialog.showExitAppDialog(context);
      },
    );
    */

    UavScaffold uavScaffold = new UavScaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: uavAppBar),
        body: uavBody
        // body: willPopScope
        );

    return uavScaffold;
  }
}

class Choice {
  final String title;
  final IconData icon;
  final String path;
  final Map param;
  const Choice({this.title, this.icon, this.path, this.param});
}

const List<Choice> choices = const <Choice>[
  const Choice(
      title: 'Add New',
      icon: Icons.add,
      path: UavRoutes.TransporterBooking,
      param: {}),
  const Choice(
      title: 'Planned',
      icon: Icons.pending,
      path: UavRoutes.TransporterPlannedList,
      param: {"shipmentStatusId": ShipmentStatusVO.Planned}),
  const Choice(
      title: 'Booked',
      icon: Icons.save,
      path: UavRoutes.BookingList,
      param: {"shipmentStatusId": ShipmentStatusVO.Booked}),
  const Choice(
      title: 'Completed',
      icon: Icons.done,
      path: UavRoutes.BookingList,
      param: {"shipmentStatusId": ShipmentStatusVO.Delivered}),

  /*
  const Choice(
      title: 'Closed', icon: Icons.close_fullscreen, path: "/booking_list", param: "closed"),
  */
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          choice.path,
          arguments: choice.param,
        );
        /*
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ShipmentUnitList()));
            */
      },
      child: Card(
          key: this.key,
          color: UavPrimaryColor,
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child:
                          Icon(choice.icon, size: 30.0, color: Colors.white)),
                  Text(choice.title,
                      style: TextStyle(
                        fontSize: UavScreenSize.getScreenWidth(14),
                        color: Colors.white,
                      )),
                ]),
          )),
    );
  }
}
