import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';

class TestingView extends StatelessWidget {
  static String routeName = "/testing";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    UavScreenSize().init(context);
    Text title = new Text('Testing');
    AppBar appBar = new AppBar(
      title: title,
    );
    Text name = new Text('vipin Shakya');
    Container mainDiv = new Container(
      child: name,
    );

    Scaffold scaffold = new Scaffold(
      appBar: appBar,
      body: mainDiv,
    );

    return scaffold;
  }
}
