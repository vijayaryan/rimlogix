import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rimlogix/com/uav/flutter/bo/city/city_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/shipment/measurement_unit_type_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/shipment/shipment_unit_bo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/button.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/textfield.dart';
import 'package:rimlogix/com/uav/flutter/vo/city/city_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/measurement_unit_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_unit_vo.dart';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class VendorBookingRequest extends StatefulWidget {
  static String routeName = "/vendor_booking_request";

  @override
  _VendorBookingRequest createState() => _VendorBookingRequest();
}

class _VendorBookingRequest extends State<VendorBookingRequest> {
  final vendorBookingFormKey = GlobalKey<FormState>();

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String todayDate = formatter.format(now);

  List<String> errors = [];

  bool isShowLoader = false;
  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  ShipmentUnitVO shipmentUnitVO = new ShipmentUnitVO();

  /* input field controller */
  TextEditingController originCityController = new TextEditingController();
  TextEditingController originCityHiddenController =
      new TextEditingController();
  TextEditingController destinationCityController = new TextEditingController();
  TextEditingController destinationCityHiddenController =
      new TextEditingController();

  TextEditingController chargeableWtController = new TextEditingController();
  TextEditingController measurementUnitTypeController =
      new TextEditingController();

  TextEditingController bookingDateController = new TextEditingController();
  TextEditingController goodsNameController = new TextEditingController();

  var measurementUnitTypeList;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    getCacheData();

    bookingDateController.text = todayDate;
  }

  void getCacheData() async {
    MeasurementUnitTypeBO measurementUnitTypeBO = new MeasurementUnitTypeBO();
    measurementUnitTypeList =
        await measurementUnitTypeBO.getMeasurementUnitTypeCache();
  }

  @override
  Widget build(BuildContext context) {
    UavScreenSize().init(context);

    TypeAheadFormField uavOriginCityTextField() {
      CityBO cityBO = new CityBO();
      return TypeAheadFormField(
        textFieldConfiguration: TextFieldConfiguration(
            // autofocus: true,
            decoration: InputDecoration(
              labelText: "Origin City",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: const Icon(Icons.location_city),
            ),
            controller: originCityController),
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
            // subtitle: Text('\$${suggestion['value']}'),
          );
        },
        onSuggestionSelected: (suggestion) {
          originCityHiddenController.text = suggestion.cityId.toString();
          originCityController.text = suggestion.cityName;
        },
        validator: (value) {
          return (value.isEmpty) ? UavRequiredFieldError : '';
        },
      );
    }

    TypeAheadField uavDestinationCityTextField() {
      String destinationCityError;
      CityBO cityBO = new CityBO();
      return TypeAheadField(
        textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              errorText: destinationCityError,
              labelText: "Destination City",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: const Icon(Icons.location_city),
            ),
            controller: destinationCityController),

        // hideOnEmpty: true,

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
            // subtitle: Text('\$${suggestion['value']}'),
          );
        },
        onSuggestionSelected: (suggestion) {
          destinationCityHiddenController.text = suggestion.cityId.toString();
          destinationCityController.text = suggestion.cityName;
        },
      );
    }

    TextFormField chargeableWtTextFormField = new TextFormField(
      controller: chargeableWtController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          labelText: "Weight",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: Icon(Icons.line_weight)),
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : '';
      },
    );

    TextFormField goodsNameTextFormField = new TextFormField(
      controller: goodsNameController,
      decoration: InputDecoration(
        labelText: "Goods Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.content_paste),
        // suffixIcon: this.uavSuffixIcon
      ),
      // keyboardType: this.uavTextInputType,
      // onChanged: (val) => setState(() => goodsNameController.text = val),
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : '';
      },
      onSaved: (val) => setState(() => goodsNameController.text = val),
    );

    DateTimePicker bookingDateTextField = new DateTimePicker(
      decoration: InputDecoration(
        labelText: "Booking Date",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(Icons.calendar_today),
      ),
      cursorColor: UavPrimaryColor,
      // type: DateTimePickerType.dateTime,
      type: DateTimePickerType.date,
      // dateMask: 'd MMMM, yyyy - hh:mm a',
      dateMask: 'yyyy-MM-dd',
      controller: bookingDateController,
      // initialValue: "2000-09-20 14:30",
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      //icon: Icon(Icons.event),
      // dateLabelText: 'Booking Date',
      use24HourFormat: false,
      locale: Locale('en', 'US'),
      onChanged: (value) => setState(() => bookingDateController.text = value),
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : '';
      },
      onSaved: (value) => setState(() => bookingDateController.text = value),
    );

    UavHiddenFormField originCityHiddenField = new UavHiddenFormField(
      uavTextEditingController: originCityHiddenController,
    );

    UavHiddenFormField destinationCityHiddenField = new UavHiddenFormField(
      uavTextEditingController: destinationCityHiddenController,
    );

    SizedBox spacer = new SizedBox(height: UavScreenSize.getScreenHeight(20));

    UavFlatButton submitBtn = new UavFlatButton(
      text: 'Continue',
      press: createBookingRequest,
    );

    Column singleCol = new Column(
      children: [
        spacer,
        uavOriginCityTextField(),
        spacer,
        uavDestinationCityTextField(),
        spacer,
        chargeableWtTextFormField,
        spacer,
        goodsNameTextFormField,
        spacer,
        bookingDateTextField,
        spacer,
        submitBtn,
        originCityHiddenField,
        destinationCityHiddenField,
      ],
    );

    SingleChildScrollView childScrollView = new SingleChildScrollView(
      child: singleCol,
    );

    Form signInForm = new Form(
      key: vendorBookingFormKey,
      child: childScrollView,
    );

    // SafeArea body = new SafeArea(child: signInForm);

    UavAppBar uavAppBar = new UavAppBar(
      title: "Vendor Booking",
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
    if (vendorBookingFormKey.currentState.validate()) {
      vendorBookingFormKey.currentState.save();

      CityVO originVO = new CityVO();
      originVO.cityId = int.parse(originCityHiddenController.text);
      originVO.cityName = originCityController.text;

      CityVO destinationVO = new CityVO();
      destinationVO.cityId = int.parse(destinationCityHiddenController.text);
      destinationVO.cityName = destinationCityController.text;

      MeasurementUnitTypeVO measurementUnitTypeVO = new MeasurementUnitTypeVO();
      measurementUnitTypeVO.typeId = 1;

      setState(() {
        shipmentUnitVO.origin = originVO.toJson();
        shipmentUnitVO.destination = destinationVO.toJson();
        shipmentUnitVO.chargeableWt = double.parse(chargeableWtController.text);
        shipmentUnitVO.measurementUnitType = measurementUnitTypeVO.toJson();
        shipmentUnitVO.bookingDate = bookingDateController.text;
        shipmentUnitVO.goodsName = goodsNameController.text;
        errors = [];
        isShowLoader = true;
      });

      ShipmentUnitBO shipmentUnitBO = new ShipmentUnitBO();
      ShipmentUnitVO currentShipmentUnitVO =
          await shipmentUnitBO.createBookingRequest(shipmentUnitVO);

      setState(() {
        isShowLoader = false;
      });

      if (currentShipmentUnitVO.status == "success") {
        UavKeyboard.hideKeyboard(context);

        UavDialog.showSuccessDialog(
            context: context,
            uavContent: currentShipmentUnitVO.message,
            navigationPath: UavRoutes.BookingList,
            param: {"shipmentStatusId": 1});
      } else {
        UavDialog.showErrorDialog(context, currentShipmentUnitVO.message);
      }
    }

    return;
  }
}
