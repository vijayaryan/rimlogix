import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/service/auth_service/auth_service.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_status_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerHome extends StatefulWidget {
  @override
  _CustomerHomeState createState() => _CustomerHomeState();
}

class _CustomerHomeState extends State<CustomerHome> {
  final uavScaffoldKey = new GlobalKey<ScaffoldState>();

  SharedPreferences prefs;
  AuthService authService = new AuthService();

  @override
  void initState() {
    super.initState();
    defaultSetting();
  }

  Future defaultSetting() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("currentActivity", UavRoutes.CustomerHome);
    authService.checkAuthenticity(context);
  }

  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);

    UavAppBar uavAppBar = new UavAppBar(
      title: "Customer Home",
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
              child: SelectCard(
                choice: choices[index],
                uavScaffoldKey: uavScaffoldKey,
              ),
            );
          })),
    ));

    UavScaffold uavScaffold = new UavScaffold(
        uavKey: uavScaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: uavAppBar),
        body: uavBody);

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
      path: UavRoutes.CustomerBookingRequest,
      param: {}),
  const Choice(
      title: 'Planned',
      icon: Icons.pending,
      path: UavRoutes.CustomerPlannedList,
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
  final Choice choice;
  final uavScaffoldKey;

  const SelectCard({Key key, this.choice, this.uavScaffoldKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // UavUtility.showLoader(uavScaffoldKey, "loading..");

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
