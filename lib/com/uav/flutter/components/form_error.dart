import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';

class FormError extends StatelessWidget {
  final List<String> errors;

  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  SingleChildScrollView formErrorText({String error}) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SvgPicture.asset(
            "assets/icons/Error.svg",
            height: UavScreenSize.getScreenHeight(14),
            width: UavScreenSize.getScreenWidth(14),
          ),
          SizedBox(
            width: UavScreenSize.getScreenWidth(10),
          ),
          Text(error)
          /*
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(error),
            ),
          ),
          
          FittedBox(fit: BoxFit.fitWidth, child: Text(error)),
           */
        ],
      ),
    );
  }
}
