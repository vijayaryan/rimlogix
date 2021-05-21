import 'package:flutter/material.dart';

class UAVDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: [
      UserAccountsDrawerHeader(
        accountName: Text("Vipin Shakya"),
        accountEmail: Text("vipin.2122@gmail.com"),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(
              "http://www.margshri.com/media/mgsr/common/images/user/01.png"),
        ),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text("Settings"),
        trailing: Icon(Icons.arrow_forward),
      )
    ]));
  }
}
