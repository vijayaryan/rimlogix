import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/activity/consignment_list/consignment_list_form.dart';
// import 'package:rimlogix/com/uav/flutter/components/utility.dart';

class ConsignmentListBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: UavScreenSize.getScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: UavScreenSize.screenHeight * 0.05),
              ConsignmentListForm(),
              SizedBox(height: UavScreenSize.screenHeight * 0.1),
            ],
          ),
        ),
      ),
    );
    */
    return ConsignmentListForm();
  }
}
