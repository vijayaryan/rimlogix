import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rimlogix/com/uav/flutter/bo/city/city_bo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/vo/city/city_vo.dart';

class UavUtility {
  static setNullIfEmpty(val) {
    if (val == null || val == "") {
      return null;
    } else {
      return val;
    }
  }

  static showLoader(uavScaffoldKey, uavContent) {
    uavScaffoldKey.currentState.showSnackBar(new SnackBar(
      duration: new Duration(seconds: 1),
      /*
      content: new Row(
        children: <Widget>[
          new CircularProgressIndicator(),
          new Text(uavContent)
        ],
      ),
      */
      content: Text(uavContent),
    ));
  }

  static hideLoader(uavScaffoldKey) {
    uavScaffoldKey.currentState.hideCurrentSnackBar();
  }
}

class UavScreenSize {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double defaultSize;
  static Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }

  // Get the proportionate height as per screen size
  static double getScreenHeight(double inputHeight) {
    double screenHeight = UavScreenSize.screenHeight;
    // 812 is the layout height that designer use
    return (inputHeight / 812.0) * screenHeight;
  }

  // Get the proportionate height as per screen size
  static double getScreenWidth(double inputWidth) {
    double screenWidth = UavScreenSize.screenWidth;
    // 375 is the layout width that designer use
    return (inputWidth / 375.0) * screenWidth;
  }
}

class UavKeyboard {
  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }
}

class UavSurffixIcon extends StatelessWidget {
  const UavSurffixIcon({
    Key key,
    @required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        UavScreenSize.getScreenWidth(20),
        UavScreenSize.getScreenWidth(20),
        UavScreenSize.getScreenWidth(20),
      ),
      child: SvgPicture.asset(
        svgIcon,
        height: UavScreenSize.getScreenHeight(18),
      ),
    );
  }
}

// ignore: must_be_immutable
class UavLoader extends StatelessWidget {
  bool status = false;
  UavLoader(this.status);
  @override
  Widget build(BuildContext context) {
    if (this.status) {
      return Opacity(
        opacity: 1,
        child: Container(
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: UavPrimaryColor,
            ),
          ),
        ),
      );
    } else {
      // return CircularProgressIndicator(value: 0.0);
      return Container();
    }
  }
}

class UavDialog {
  // var uavContent;

  static showErrorDialog(BuildContext context, uavContent) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Error"),
      content: Text(uavContent),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showSuccessDialog(
      {BuildContext context,
      String uavContent,
      String navigationPath,
      Map param}) {
    // Create button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
        if (navigationPath != null) {
          Navigator.of(context).pushNamed(
            navigationPath,
            arguments: param,
          );
        }
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text(uavContent),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static showExitAppDialog(BuildContext context) {
    // Create button
    Widget noButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
    );

    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.pop(context, true);
        SystemNavigator.pop();
        return Future.value(true);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert!"),
      content: Text("Wanna Exit?"),
      actions: [noButton, yesButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

class UavDecoration {
  static uavInputDecoration(
      {String uavLabelText, String uavHintText, IconData uavSuffixIcon}) {
    return InputDecoration(
      labelText: uavLabelText,
      hintText: (uavHintText != null) ? uavHintText : null,
      floatingLabelBehavior: FloatingLabelBehavior.always,
      suffixIcon: (uavSuffixIcon != null) ? Icon(uavSuffixIcon) : null,
    );
  }
}

class UavAutoSuggest extends TypeAheadFormField {
  TypeAheadFormField getUavCityTextFormField(
      String uavLabelText,
      TextEditingController uavCityNameCtrl,
      TextEditingController uavCityIdCtrl) {
    CityBO cityBO = new CityBO();
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: uavLabelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const Icon(Icons.location_city),
          ),
          controller: uavCityNameCtrl),
      suggestionsCallback: (pattern) async {
        List<CityVO> cityList;
        CityVO reqCityVO = new CityVO();
        reqCityVO.cityName = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          cityList = await cityBO.getCityByAutoSuggest(reqCityVO);
        return cityList;
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: Icon(Icons.location_city),
          title: (suggestion.cityName != null)
              ? Text(suggestion.cityName)
              : Text("not found."),
        );
      },
      onSuggestionSelected: (suggestion) {
        uavCityIdCtrl.text = suggestion.cityId.toString();
        uavCityNameCtrl.text = suggestion.cityName;
      },
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : '';
      },
    );
  }
}
