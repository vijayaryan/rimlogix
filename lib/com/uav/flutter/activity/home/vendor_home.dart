import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';

class VendorHome extends StatefulWidget {
  static String routeName = "/vendor_home";
  @override
  _VendorHomeState createState() => _VendorHomeState();
}

class _VendorHomeState extends State<VendorHome> {
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
              child: SelectCard(choice: choices[index]),
            );
          })),
    ));

    UavScaffold uavScaffold = new UavScaffold(
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
  const Choice({this.title, this.icon, this.path});
}

const List<Choice> choices = const <Choice>[
  const Choice(
      title: 'Booking', icon: Icons.add, path: "/vendor_booking_request"),
  const Choice(title: 'Pending', icon: Icons.pending, path: "/booking_list"),
  const Choice(title: 'Completed', icon: Icons.done, path: "/booking_list"),
  const Choice(
      title: 'Closed', icon: Icons.close_fullscreen, path: "/booking_list"),
  /*
  const Choice(
      title: 'Transporter Home',
      icon: Icons.emoji_transportation,
      path: "/transporter_home"),
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
          arguments: 'Hello from the first page!',
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
