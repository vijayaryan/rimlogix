import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';

class UavScaffold extends StatelessWidget {
  final Key uavKey;
  final Widget appBar;
  final Widget body;

  UavScaffold({this.uavKey, this.appBar, this.body});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: uavKey,
      appBar: this.appBar,
      body: this.body,
    );
  }
}

class UavAppBar extends StatelessWidget {
  final String title;
  final bool automaticallyImplyLeading;
  UavAppBar({this.title, this.automaticallyImplyLeading});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(child: Text(this.title)),
      automaticallyImplyLeading: this.automaticallyImplyLeading,
    );
  }
}

class UavBody extends StatelessWidget {
  final Widget body;
  UavBody({
    this.body,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: UavScreenSize.getScreenWidth(20)),
      child: SafeArea(
        child: this.body,
      ),
    );
  }
}
