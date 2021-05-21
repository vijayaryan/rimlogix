import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rimlogix/com/uav/flutter/bo/shipment/measurement_unit_type_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/shipment/shipment_unit_bo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/service/auth_service/auth_service.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/button.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/textfield.dart';
import 'package:rimlogix/com/uav/flutter/vo/city/city_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/measurement_unit_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_unit_vo.dart';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerBookingRequest extends StatefulWidget {
  @override
  _CustomerBookingRequest createState() => _CustomerBookingRequest();
}

class _CustomerBookingRequest extends State<CustomerBookingRequest> {
  final customerBookingFormKey = GlobalKey<FormState>();
  final uavScaffoldKey = new GlobalKey<ScaffoldState>();

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String todayDate = formatter.format(now);

  SharedPreferences prefs;
  AuthService authService = new AuthService();

  ShipmentUnitVO shipmentUnitVO = new ShipmentUnitVO();

  /* input field controller */
  TextEditingController originCityNameCtrl = new TextEditingController();
  TextEditingController originCityIdCtrl = new TextEditingController();
  TextEditingController destinationCityNameCtrl = new TextEditingController();
  TextEditingController destinationCityIdCtrl = new TextEditingController();
  TextEditingController chargeableWtCtrl = new TextEditingController();
  TextEditingController measurementUnitTypeCtrl = new TextEditingController();
  TextEditingController planForDateCtrl = new TextEditingController();
  TextEditingController goodsNameCtrl = new TextEditingController();
  TextEditingController boxesCtrl = new TextEditingController();

  var originCityNameFocusNode = FocusNode();
  var destinationCityNameFocusNode = FocusNode();
  var chargeableWtFocusNode = FocusNode();
  var measurementUnitTypeFocusNode = FocusNode();
  var planForDateFocusNode = FocusNode();
  var goodsNameFocusNode = FocusNode();
  var boxesFocusNode = FocusNode();

  List<DropdownMenuItem> measurementUnitTypeList = [];

  @override
  void initState() {
    super.initState();
    defaultSetting();
  }

  Future defaultSetting() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("currentActivity", UavRoutes.CustomerBookingRequest);
    authService.checkAuthenticity(context);

    initializeDateFormatting();
    planForDateCtrl.text = todayDate;

    MeasurementUnitTypeBO measurementUnitTypeBO = new MeasurementUnitTypeBO();
    var measurementUnitType =
        await measurementUnitTypeBO.getMeasurementUnitTypeCache();
    setState(() {
      measurementUnitTypeList = getDropDownMenuList(measurementUnitType);
    });
  }

  List<DropdownMenuItem> getDropDownMenuList(dataList) {
    List<DropdownMenuItem> resDataList = [];

    for (Map mapArr in dataList) {
      DropdownMenuItem dropdownMenuItem = new DropdownMenuItem(
        child: Text(mapArr["display"]),
        value: mapArr["value"],
      );
      resDataList.add(dropdownMenuItem);
    }
    return resDataList;
  }

  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);

    UavAutoSuggestCityTextFormField originCityTff =
        UavAutoSuggestCityTextFormField(
      uavCityLabelText: "Origin City",
      uavCityNameCtrl: originCityNameCtrl,
      uavCityIdCtrl: originCityIdCtrl,
      uavFocusNode: originCityNameFocusNode,
      uavRequestFocusNode: destinationCityNameFocusNode,
    );

    UavHiddenFormField originCityIdHff = new UavHiddenFormField(
      uavTextEditingController: originCityIdCtrl,
    );

    UavAutoSuggestCityTextFormField destinationCityTff =
        UavAutoSuggestCityTextFormField(
      uavCityLabelText: "Destination City",
      uavCityNameCtrl: destinationCityNameCtrl,
      uavCityIdCtrl: destinationCityIdCtrl,
      uavFocusNode: destinationCityNameFocusNode,
      uavRequestFocusNode: chargeableWtFocusNode,
    );

    UavHiddenFormField destinationCityIdHff = new UavHiddenFormField(
      uavTextEditingController: destinationCityIdCtrl,
    );

    TextFormField chargeableWtTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(
        uavLabelText: "Total Weight",
      ),
      keyboardType: TextInputType.number,
      controller: chargeableWtCtrl,
      focusNode: chargeableWtFocusNode,
      onEditingComplete: () {
        measurementUnitTypeFocusNode.requestFocus();
      },
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : null;
      },
    );

    DropdownButtonFormField measurementUnitTypeDdff = DropdownButtonFormField(
      decoration: UavDecoration.uavInputDecoration(
          uavLabelText: "Weight Unit", uavHintText: "pick one"),
      items: measurementUnitTypeList,
      onChanged: (value) {
        measurementUnitTypeCtrl.text = value.toString();
        boxesFocusNode.requestFocus();
      },
      focusNode: measurementUnitTypeFocusNode,
      validator: (value) {
        return (value == null) ? UavRequiredFieldError : null;
      },
    );

    Row weightRow = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new Flexible(
          child: chargeableWtTff,
        ),
        SizedBox(
          width: 5.0,
        ),
        new Flexible(
          child: measurementUnitTypeDdff,
        ),
      ],
    );

    UavTextFormField boxesTff = UavTextFormField(
      uavLabelText: "Box",
      uavTextInputType: TextInputType.number,
      uavTextEditingController: boxesCtrl,
      uavFocusNode: boxesFocusNode,
      uavRequestFocusNode: goodsNameFocusNode,
    );

    UavTextFormField goodsNameTff = UavTextFormField(
      uavLabelText: "Goods Name",
      uavTextEditingController: goodsNameCtrl,
      uavFocusNode: goodsNameFocusNode,
      uavRequestFocusNode: planForDateFocusNode,
    );

    DateTimePicker planForDateTff = new DateTimePicker(
      decoration: InputDecoration(
        labelText: "Plan Date",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.calendar_today),
      ),
      cursorColor: UavPrimaryColor,
      // type: DateTimePickerType.dateTime,
      type: DateTimePickerType.date,
      // dateMask: 'd MMMM, yyyy - hh:mm a',
      dateMask: 'yyyy-MM-dd',
      controller: planForDateCtrl,
      // initialValue: "2000-09-20 14:30",
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      //icon: Icon(Icons.event),
      // dateLabelText: 'Booking Date',
      use24HourFormat: false,
      locale: Locale('en', 'US'),
      onChanged: (value) => setState(() => planForDateCtrl.text = value),
      focusNode: planForDateFocusNode,
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : null;
      },
      onSaved: (value) => setState(() => planForDateCtrl.text = value),
    );

    SizedBox spacer = new SizedBox(height: UavScreenSize.getScreenHeight(20));

    UavFlatButton submitBtn = new UavFlatButton(
      text: 'Continue',
      press: createBookingRequest,
    );

    Column singleCol = new Column(
      children: [
        spacer,
        originCityTff,
        spacer,
        destinationCityTff,
        spacer,
        weightRow,
        spacer,
        boxesTff,
        spacer,
        goodsNameTff,
        spacer,
        planForDateTff,
        spacer,
        submitBtn,
        originCityIdHff,
        destinationCityIdHff,
      ],
    );

    SingleChildScrollView childScrollView = new SingleChildScrollView(
      child: singleCol,
    );

    Form signInForm = new Form(
      key: customerBookingFormKey,
      child: childScrollView,
    );

    // SafeArea body = new SafeArea(child: signInForm);

    UavAppBar uavAppBar = new UavAppBar(
      title: "Customer Booking",
      automaticallyImplyLeading: false,
    );

    UavBody uavBody = new UavBody(
      body: signInForm,
    );

    UavScaffold uavScaffold = new UavScaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: uavAppBar),
        body: uavBody);

    return uavScaffold;
  }

  Future<void> createBookingRequest() async {
    if (customerBookingFormKey.currentState.validate()) {
      customerBookingFormKey.currentState.save();

      MemberVO memberVO = new MemberVO();
      memberVO.memberId = prefs.getInt("memberId");

      CityVO originVO = new CityVO();
      originVO.cityId = UavUtility.setNullIfEmpty(originCityIdCtrl.text);
      originVO.cityName = originCityNameCtrl.text;

      CityVO destinationVO = new CityVO();
      destinationVO.cityId =
          UavUtility.setNullIfEmpty(destinationCityIdCtrl.text);
      destinationVO.cityName = destinationCityNameCtrl.text;

      MeasurementUnitTypeVO measurementUnitTypeVO = new MeasurementUnitTypeVO();
      measurementUnitTypeVO.typeId =
          UavUtility.setNullIfEmpty(measurementUnitTypeCtrl.text);

      shipmentUnitVO.member = memberVO.toJson();
      shipmentUnitVO.origin = originVO.toJson();
      shipmentUnitVO.destination = destinationVO.toJson();

      shipmentUnitVO.chargeableWt = chargeableWtCtrl.text;

      shipmentUnitVO.measurementUnitType = measurementUnitTypeVO.toJson();
      shipmentUnitVO.goodsName = goodsNameCtrl.text;
      shipmentUnitVO.planForDate = planForDateCtrl.text;
      shipmentUnitVO.bookingDate = todayDate;
      shipmentUnitVO.boxes = boxesCtrl.text;
      shipmentUnitVO.transporterIds = '[{"memberId":"19"}]';
      print(shipmentUnitVO.toJson());

      ShipmentUnitBO shipmentUnitBO = new ShipmentUnitBO();
      ShipmentUnitVO currentShipmentUnitVO = new ShipmentUnitVO();
      if (prefs.getString("uavFormKey") !=
          customerBookingFormKey.currentState.toString()) {
        currentShipmentUnitVO =
            await shipmentUnitBO.createBookingRequest(shipmentUnitVO);

        if (currentShipmentUnitVO.status == "success") {
          UavKeyboard.hideKeyboard(context);

          prefs.setString(
              "uavFormKey", customerBookingFormKey.currentState.toString());

          UavDialog.showSuccessDialog(
            context: context,
            uavContent: currentShipmentUnitVO.message,
            navigationPath: UavRoutes.CustomerPlannedList,
            param: {
              "shipmentStatusId": 1,
              "memberId": prefs.getInt("memberId")
            },
          );
        } else {
          UavDialog.showErrorDialog(context, currentShipmentUnitVO.message);
        }
      } else {
        UavDialog.showSuccessDialog(
          context: context,
          uavContent: "Already done, please generated new.",
          navigationPath: UavRoutes.CustomerPlannedList,
          param: {"shipmentStatusId": 1, "memberId": prefs.getInt("memberId")},
        );
      }
    }

    return;
  }
}
