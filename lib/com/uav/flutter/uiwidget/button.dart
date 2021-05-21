import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';

class UavFlatButton extends StatelessWidget {
  const UavFlatButton({
    Key key,
    this.text,
    this.press,
  }) : super(key: key);
  final String text;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: UavScreenSize.getScreenHeight(56),
      child: FlatButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: UavPrimaryColor,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: UavScreenSize.getScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

/*
class UavFloatingActionButton extends StatefulWidget {
  @override
  _UavFloatingActionButtonState createState() =>
      _UavFloatingActionButtonState();
}


class _UavFloatingActionButtonState extends State<UavFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Otp()),
        );
      },
      child: Icon(Icons.arrow_forward),
    );
   
  }
}

 */
