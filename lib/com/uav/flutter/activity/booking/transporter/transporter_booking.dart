import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rimlogix/com/uav/flutter/bo/carrier/carrier_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/carrier/driver_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/carrier/owner_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/customer/customer_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/shipment/container_type_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/shipment/content_type_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/shipment/measurement_unit_type_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/shipment/shipment_unit_bo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/components/routes.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';
import 'package:rimlogix/com/uav/flutter/service/auth_service/auth_service.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/scaffold.dart';
import 'package:rimlogix/com/uav/flutter/uiwidget/textfield.dart';
import 'package:rimlogix/com/uav/flutter/vo/carrier/carrier_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/carrier/driver_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/carrier/owner_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/city/city_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/customer/customer_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/member/member_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/container_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/content_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/document_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/measurement_unit_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_booking_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_status_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_type_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/shipment/shipment_unit_vo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransporterBooking extends StatefulWidget {
  @override
  _TransporterBookingState createState() => _TransporterBookingState();
}

class _TransporterBookingState extends State<TransporterBooking> {
  final transporterBookingFormKey = GlobalKey<FormState>();
  final uavScaffoldKey = new GlobalKey<ScaffoldState>();

  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String todayDate = formatter.format(now);

  SharedPreferences prefs;
  AuthService authService = new AuthService();

  List<String> errors = [];
  ShipmentUnitVO shipmentUnitVO = new ShipmentUnitVO();

  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 0.
  int upperBound = 6; // upperBound MUST BE total number of icons minus 1.

  /* fromAndToDetailStep input field controller */
  TextEditingController originCityNameCtrl = new TextEditingController();
  TextEditingController originCityIdCtrl = new TextEditingController();
  TextEditingController pickupPointCtrl = new TextEditingController();
  TextEditingController destinationCityNameCtrl = new TextEditingController();
  TextEditingController destinationCityIdCtrl = new TextEditingController();
  TextEditingController dropPointCtrl = new TextEditingController();
  TextEditingController deliveryAtCtrl = new TextEditingController();

  /* carrierDetailStep input field controller  */
  TextEditingController carrierNameCtrl = new TextEditingController();
  TextEditingController carrierCodeCtrl = new TextEditingController();
  TextEditingController carrierIdCtrl = new TextEditingController();
  TextEditingController ownerNameCtrl = new TextEditingController();
  TextEditingController ownerIdCtrl = new TextEditingController();
  TextEditingController ownerMobileNoCtrl = new TextEditingController();
  TextEditingController driverNameCtrl = new TextEditingController();
  TextEditingController driverIdCtrl = new TextEditingController();
  TextEditingController driverMobileNoCtrl = new TextEditingController();

  /* paymentDetailStep input field controller  */
  TextEditingController chargeableWtCtrl = new TextEditingController();
  TextEditingController rateCtrl = new TextEditingController();
  TextEditingController freightCtrl = new TextEditingController();
  TextEditingController stChargesCtrl = new TextEditingController();
  TextEditingController colChargesCtrl = new TextEditingController();
  TextEditingController otherChargesCtrl = new TextEditingController();
  TextEditingController grossAmountCtrl = new TextEditingController();
  TextEditingController cgstAmountCtrl = new TextEditingController();
  TextEditingController sgstAmountCtrl = new TextEditingController();
  TextEditingController igstAmountCtrl = new TextEditingController();
  TextEditingController netAmountCtrl = new TextEditingController();
  TextEditingController advanceCtrl = new TextEditingController();
  TextEditingController balanceCtrl = new TextEditingController();

  /* consignorDetailStep input field controller  */
  TextEditingController consignorNameCtrl = new TextEditingController();
  TextEditingController consignorIdCtrl = new TextEditingController();
  TextEditingController consignorGstNoCtrl = new TextEditingController();
  TextEditingController consignorMobileNoCtrl = new TextEditingController();
  TextEditingController consignorAadharNoCtrl = new TextEditingController();
  TextEditingController consignorAddressCtrl = new TextEditingController();

  /* consignorDetailStep input field controller  */
  TextEditingController consigneeNameCtrl = new TextEditingController();
  TextEditingController consigneeIdCtrl = new TextEditingController();
  TextEditingController consigneeGstNoCtrl = new TextEditingController();
  TextEditingController consigneeMobileNoCtrl = new TextEditingController();
  TextEditingController consigneeAadharNoCtrl = new TextEditingController();
  TextEditingController consigneeAddressCtrl = new TextEditingController();

  /* goodsDetailStep input field controller  */
  TextEditingController bookingDateCtrl = new TextEditingController();
  TextEditingController planForDateCtrl = new TextEditingController();
  TextEditingController goodsNameCtrl = new TextEditingController();
  TextEditingController measurementUnitTypeCtrl = new TextEditingController();
  TextEditingController contentTypeCtrl = new TextEditingController();
  TextEditingController containerTypeCtrl = new TextEditingController();

  TextEditingController unitIdCtrl = new TextEditingController();
  TextEditingController referenceNumberCtrl = new TextEditingController();
  TextEditingController invoiceNumberCtrl = new TextEditingController();
  TextEditingController boxesCtrl = new TextEditingController();
  TextEditingController shipmentValueCtrl = new TextEditingController();
  TextEditingController eWayBillnoCtrl = new TextEditingController();
  TextEditingController ewayBillExpiryDateCtrl = new TextEditingController();
  TextEditingController hsnCodeCtrl = new TextEditingController();
  TextEditingController remarksCtrl = new TextEditingController();
  TextEditingController gstPaidByCtrl = new TextEditingController();
  TextEditingController billingStationCtrl = new TextEditingController();
  TextEditingController descriptionCtrl = new TextEditingController();
  TextEditingController billWeightCtrl = new TextEditingController();

  Column goodsDetailStep;
  Column fromAndToDetailStep;
  Column consignorDetailStep;
  Column consigneeDetailStep;
  Column paymentDetailStep;
  Column otherDetailStep;
  Column carrierDetailStep;

  var boxesFocusNode = FocusNode();
  var goodsNameFocusNode = FocusNode();
  var planForDateFocusNode = FocusNode();

  var referenceNumberFocusNode = FocusNode();

  var chargeableWtFocusNode = FocusNode();
  var measurementUnitTypeFocusNode = FocusNode();
  var rateFocusNode = FocusNode();
  var freightFocusNode = FocusNode();
  var stChargesFocusNode = FocusNode();
  var colChargesFocusNode = FocusNode();
  var otherChargesFocusNode = FocusNode();
  var grossAmountFocusNode = FocusNode();
  var cgstAmountFocusNode = FocusNode();
  var sgstAmountFocusNode = FocusNode();
  var igstAmountFocusNode = FocusNode();
  var netAmountFocusNode = FocusNode();
  var advanceFocusNode = FocusNode();
  var balanceFocusNode = FocusNode();

  List<DropdownMenuItem> deliveryAtTypeList = [];
  List<DropdownMenuItem> measurementUnitTypeList = [];
  List<DropdownMenuItem> contentTypeList = [];
  List<DropdownMenuItem> containerTypeList = [];

  @override
  void initState() {
    super.initState();
    defaultSetting();
  }

  Future defaultSetting() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("currentActivity", UavRoutes.TransporterBooking);
    authService.checkAuthenticity(context);

    initializeDateFormatting();
    planForDateCtrl.text = todayDate;

    var deliveryAtType = [
      {"display": "godown", "value": 1},
      {"display": "door", "value": 2}
    ];

    MeasurementUnitTypeBO measurementUnitTypeBO = new MeasurementUnitTypeBO();
    var measurementUnitType =
        await measurementUnitTypeBO.getMeasurementUnitTypeCache();

    ContentTypeBO contentTypeBO = new ContentTypeBO();
    var contentType = await contentTypeBO.getContentTypeCache();

    ContainerTypeBO containerTypeBO = new ContainerTypeBO();
    var containerType = await containerTypeBO.getContainerTypeCache();

    setState(() {
      deliveryAtTypeList = getDropDownMenuList(deliveryAtType);
      measurementUnitTypeList = getDropDownMenuList(measurementUnitType);
      contentTypeList = getDropDownMenuList(contentType);
      containerTypeList = getDropDownMenuList(containerType);
    });

    chargeableWtCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    rateCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    freightCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    stChargesCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    colChargesCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    otherChargesCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    grossAmountCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    cgstAmountCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    sgstAmountCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    igstAmountCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    netAmountCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    advanceCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    balanceCtrl.text = UavDoubleTypeTextFieldDefaultValue;

    // contentTypeCtrl.text = '';

    chargeableWtFocusNode.addListener(() {
      if (chargeableWtCtrl.text == UavDoubleTypeTextFieldDefaultValue) {
        chargeableWtCtrl.text = "";
      } else if (chargeableWtCtrl.text == "") {
        chargeableWtCtrl.text = UavDoubleTypeTextFieldDefaultValue;
      }
    });

    rateFocusNode.addListener(() {
      if (rateCtrl.text == UavDoubleTypeTextFieldDefaultValue) {
        rateCtrl.text = "";
      } else if (rateCtrl.text == "") {
        rateCtrl.text = UavDoubleTypeTextFieldDefaultValue;
      } else {
        calculateFreight();
      }
    });

    freightFocusNode.addListener(() {
      if (freightCtrl.text == UavDoubleTypeTextFieldDefaultValue) {
        freightCtrl.text = "";
      } else if (rateCtrl.text == "") {
        freightCtrl.text = UavDoubleTypeTextFieldDefaultValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    UavAutoSuggestCityTextFormField originCityTff =
        UavAutoSuggestCityTextFormField(
      uavCityLabelText: "Origin City",
      uavCityNameCtrl: originCityNameCtrl,
      uavCityIdCtrl: originCityIdCtrl,
    );

    UavHiddenFormField originCityIdHff = new UavHiddenFormField(
      uavTextEditingController: originCityIdCtrl,
    );

    UavTextFormField pickupPointTff = UavTextFormField(
      uavLabelText: "Pickup Point",
      uavTextEditingController: pickupPointCtrl,
    );

    UavAutoSuggestCityTextFormField destinationCityTff =
        UavAutoSuggestCityTextFormField(
      uavCityLabelText: "Destination City",
      uavCityNameCtrl: destinationCityNameCtrl,
      uavCityIdCtrl: destinationCityIdCtrl,
    );

    UavHiddenFormField destinationCityIdHff = new UavHiddenFormField(
      uavTextEditingController: destinationCityIdCtrl,
    );

    UavTextFormField dropPointTff = UavTextFormField(
      uavLabelText: "Drop Point",
      uavTextEditingController: dropPointCtrl,
    );

    DropdownButtonFormField deliveryAtDdff = DropdownButtonFormField(
      decoration: UavDecoration.uavInputDecoration(
          uavLabelText: "Delivery At", uavHintText: "Please pick one"),
      items: deliveryAtTypeList,
      onChanged: (value) {
        deliveryAtCtrl.text = value.toString();
      },
      validator: (value) {
        return (value == null) ? UavRequiredFieldError : null;
      },
    );

    CarrierBO carrierBO = new CarrierBO();
    TypeAheadFormField carrierTff = TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: "Truck Number",
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const Icon(Icons.local_shipping),
          ),
          controller: carrierNameCtrl),
      suggestionsCallback: (pattern) async {
        List<CarrierVO> carrierList;
        CarrierVO reqCarrierVO = new CarrierVO();
        reqCarrierVO.carrierCode = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          carrierList = await carrierBO.getCarrierByAutoSuggest(reqCarrierVO);
        return carrierList;
      },
      itemBuilder: (context, carrierVO) {
        return ListTile(
          leading: Icon(Icons.search),
          title: (carrierVO.status == "success")
              ? Text(carrierVO.carrierCode)
              : Text(carrierVO.message),
        );
      },
      onSuggestionSelected: (carrierVO) {
        if (carrierVO.status == "success") {
          carrierIdCtrl.text = carrierVO.carrierId.toString();
          carrierNameCtrl.text = carrierVO.carrierName;
          carrierCodeCtrl.text = carrierVO.carrierCode;
        } else {
          carrierIdCtrl.text = "";
          carrierNameCtrl.text = "";
          carrierCodeCtrl.text = "";
        }
      },
      validator: (value) {
        return validateCarrier(value);
      },
    );

    UavHiddenFormField carrierIdHff = new UavHiddenFormField(
      uavTextEditingController: carrierIdCtrl,
    );

    OwnerBO ownerBO = new OwnerBO();
    TypeAheadFormField ownerTff = TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: UavDecoration.uavInputDecoration(
              uavLabelText: "Owner Name", uavSuffixIcon: Icons.person),
          controller: ownerNameCtrl),
      suggestionsCallback: (pattern) async {
        List<OwnerVO> ownerList;
        OwnerVO reqOwnerVO = new OwnerVO();
        reqOwnerVO.ownerName = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          ownerList = await ownerBO.getOwnerByAutoSuggest(reqOwnerVO);
        return ownerList;
      },
      itemBuilder: (context, ownerVO) {
        return ListTile(
          leading: Icon(Icons.search),
          title: (ownerVO.status == "success")
              ? Text(ownerVO.value)
              : Text(ownerVO.message),
        );
      },
      onSuggestionSelected: (ownerVO) {
        if (ownerVO.status == "success") {
          ownerIdCtrl.text = ownerVO.ownerId.toString();
          ownerNameCtrl.text = ownerVO.ownerName;
          ownerMobileNoCtrl.text = ownerVO.mobileNo;
        } else {
          ownerIdCtrl.text = "";
          ownerNameCtrl.text = "";
        }
      },
      validator: (value) {
        return validateCarrier(value);
      },
    );

    TextFormField ownerMobileNoTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(
          uavLabelText: "Owner Mobile No", uavSuffixIcon: Icons.phone_android),
      controller: ownerMobileNoCtrl,
      keyboardType: TextInputType.phone,
      maxLength: UavMobileNumberMaxLength,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: UavRequiredFieldError);
        } else if (uavMobileValidatorRegExp.hasMatch(value)) {
          removeError(error: UavInvalidMobileError);
        }
        if (value.length == UavMobileNumberMaxLength) {
          UavKeyboard.hideKeyboard(context);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          return validateCarrier(value);
        } else if (!uavMobileValidatorRegExp.hasMatch(value)) {
          return UavInvalidMobileError;
        }
        return null;
      },
    );

    UavHiddenFormField ownerIdHff = new UavHiddenFormField(
      uavTextEditingController: ownerIdCtrl,
    );

    DriverBO driverBO = new DriverBO();
    TypeAheadFormField driverTff = TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: UavDecoration.uavInputDecoration(
              uavLabelText: "Driver Name", uavSuffixIcon: Icons.person),
          controller: driverNameCtrl),
      suggestionsCallback: (pattern) async {
        List<DriverVO> driverList;
        DriverVO reqDriverVO = new DriverVO();
        reqDriverVO.driverName = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          driverList = await driverBO.getDriverByAutoSuggest(reqDriverVO);
        return driverList;
      },
      itemBuilder: (context, driverVO) {
        return ListTile(
          leading: Icon(Icons.search),
          title: (driverVO.status == "success")
              ? Text(driverVO.value)
              : Text(driverVO.message),
        );
      },
      onSuggestionSelected: (driverVO) {
        if (driverVO.status == "success") {
          driverIdCtrl.text = driverVO.driverId.toString();
          driverNameCtrl.text = driverVO.driverName;
          driverMobileNoCtrl.text = driverVO.mobileNo;
        } else {
          driverIdCtrl.text = "";
          driverNameCtrl.text = "";
        }
      },
      validator: (value) {
        return validateCarrier(value);
      },
    );

    UavHiddenFormField driverIdHff = new UavHiddenFormField(
      uavTextEditingController: driverIdCtrl,
    );

    TextFormField driverMobileNoTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(
          uavLabelText: "Driver Mobile No", uavSuffixIcon: Icons.phone_android),
      controller: driverMobileNoCtrl,
      keyboardType: TextInputType.phone,
      maxLength: UavMobileNumberMaxLength,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: UavRequiredFieldError);
        } else if (uavMobileValidatorRegExp.hasMatch(value)) {
          removeError(error: UavInvalidMobileError);
        }
        if (value.length == UavMobileNumberMaxLength) {
          UavKeyboard.hideKeyboard(context);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          return validateCarrier(value);
        } else if (!uavMobileValidatorRegExp.hasMatch(value)) {
          return UavInvalidMobileError;
        }
        return null;
      },
    );

    TextFormField chargeableWtTff = TextFormField(
      decoration: InputDecoration(
        labelText: "Weight",
        floatingLabelBehavior: FloatingLabelBehavior.always,

        // suffixIcon: Icon(this.uavSuffixIcon),
        // suffixIcon: this.uavSuffixIcon
      ),
      keyboardType: TextInputType.number,
      controller: chargeableWtCtrl,
      focusNode: chargeableWtFocusNode,
      onEditingComplete: () {
        measurementUnitTypeFocusNode.requestFocus();
      },
      validator: (value) {
        String errorStr;
        if (value.isEmpty) {
          chargeableWtFocusNode.requestFocus();
          errorStr = UavRequiredFieldError;
        }
        return errorStr;
      },
    );

    DropdownButtonFormField measurementUnitTypeDdff = DropdownButtonFormField(
      decoration: UavDecoration.uavInputDecoration(
          uavLabelText: "Weight Unit", uavHintText: "pick one"),
      items: measurementUnitTypeList,
      onChanged: (value) {
        measurementUnitTypeCtrl.text = value.toString();
        rateFocusNode.requestFocus();
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

    TextFormField rateTff = TextFormField(
      decoration: InputDecoration(
        labelText: "Rate",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: Icon(this.uavSuffixIcon),
        // suffixIcon: this.uavSuffixIcon
      ),
      keyboardType: TextInputType.number,
      controller: rateCtrl,
      focusNode: rateFocusNode,
      onEditingComplete: () {
        calculateFreight();
        freightFocusNode.requestFocus();
      },
      validator: (value) {
        String errorStr;
        if (value.isEmpty) {
          errorStr = UavRequiredFieldError;
        }
        return errorStr;
      },
    );

    TextFormField freightTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(uavLabelText: "Freight"),
      keyboardType: TextInputType.number,
      controller: freightCtrl,
      focusNode: freightFocusNode,
      onEditingComplete: () {
        reCalculateFreight();
        stChargesFocusNode.requestFocus();
      },
    );

    TextFormField stChargesTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(uavLabelText: "St. Charges"),
      keyboardType: TextInputType.number,
      controller: stChargesCtrl,
      focusNode: stChargesFocusNode,
      onEditingComplete: () {
        calculateNetAmount();
        colChargesFocusNode.requestFocus();
      },
    );

    TextFormField colChargesTff = TextFormField(
      decoration:
          UavDecoration.uavInputDecoration(uavLabelText: "Col. Charges"),
      keyboardType: TextInputType.number,
      controller: colChargesCtrl,
      focusNode: colChargesFocusNode,
      onEditingComplete: () {
        calculateNetAmount();
        otherChargesFocusNode.requestFocus();
      },
    );

    TextFormField otherChargesTff = TextFormField(
      decoration:
          UavDecoration.uavInputDecoration(uavLabelText: "Other Charges"),
      keyboardType: TextInputType.number,
      controller: otherChargesCtrl,
      focusNode: otherChargesFocusNode,
      onEditingComplete: () {
        calculateNetAmount();
        cgstAmountFocusNode.requestFocus();
      },
    );

    TextFormField grossAmountTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(uavLabelText: "Amount"),
      keyboardType: TextInputType.number,
      controller: grossAmountCtrl,
      readOnly: true,
    );

    TextFormField cgstAmountTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(uavLabelText: "CGST Amount"),
      keyboardType: TextInputType.number,
      controller: cgstAmountCtrl,
      focusNode: cgstAmountFocusNode,
      onEditingComplete: () {
        calculateNetAmount();
        sgstAmountFocusNode.requestFocus();
      },
    );

    TextFormField sgstAmountTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(uavLabelText: "SGST Amount"),
      keyboardType: TextInputType.number,
      controller: sgstAmountCtrl,
      focusNode: sgstAmountFocusNode,
      onEditingComplete: () {
        calculateNetAmount();
        igstAmountFocusNode.requestFocus();
      },
    );

    TextFormField igstAmountTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(uavLabelText: "IGST Amount"),
      keyboardType: TextInputType.number,
      controller: igstAmountCtrl,
      focusNode: igstAmountFocusNode,
      onEditingComplete: () {
        calculateNetAmount();
        advanceFocusNode.requestFocus();
      },
    );

    TextFormField netAmountTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(uavLabelText: "Net Amount"),
      keyboardType: TextInputType.number,
      controller: netAmountCtrl,
      readOnly: true,
    );

    TextFormField advanceTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(uavLabelText: "Advance"),
      keyboardType: TextInputType.number,
      controller: advanceCtrl,
      focusNode: advanceFocusNode,
      onEditingComplete: () {
        calculateBalance();
        balanceFocusNode.requestFocus();
      },
    );

    TextFormField balanceTff = TextFormField(
      decoration: UavDecoration.uavInputDecoration(uavLabelText: "Balance"),
      keyboardType: TextInputType.number,
      controller: balanceCtrl,
      readOnly: true,
    );

    CustomerBO consignorBO = new CustomerBO();
    TypeAheadFormField consignorNameTff = TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: UavDecoration.uavInputDecoration(
              uavLabelText: "Consignor Name", uavSuffixIcon: Icons.person),
          controller: consignorNameCtrl),
      suggestionsCallback: (pattern) async {
        List<CustomerVO> consignorList;
        CustomerVO reqConsignorVO = new CustomerVO();
        reqConsignorVO.name = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          consignorList =
              await consignorBO.getCustomerByAutoSuggest(reqConsignorVO);
        return consignorList;
      },
      itemBuilder: (context, consignorVO) {
        return ListTile(
          leading: Icon(Icons.search),
          title: (consignorVO.status == "success")
              ? Text(consignorVO.value)
              : Text(consignorVO.message),
        );
      },
      onSuggestionSelected: (consignorVO) {
        if (consignorVO.status == "success") {
          consignorIdCtrl.text = consignorVO.customerId.toString();
          consignorNameCtrl.text = consignorVO.name;
          consignorGstNoCtrl.text = consignorVO.gstNo;
          consignorMobileNoCtrl.text = consignorVO.mobileNo;
          consignorAadharNoCtrl.text = consignorVO.aadharNo;
          consignorAddressCtrl.text = consignorVO.address;
        } else {
          consignorIdCtrl.text = "";
          consignorNameCtrl.text = "";
        }
      },
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : null;
      },
    );

    UavHiddenFormField consignorIdHff = new UavHiddenFormField(
      uavTextEditingController: consignorIdCtrl,
    );

    UavTextFormField consignorGstNoTff = UavTextFormField(
      uavLabelText: "Consignor Gstin No",
      uavTextEditingController: consignorGstNoCtrl,
    );

    UavTextFormField consignorMobileNoTff = UavTextFormField(
      uavLabelText: "Consignor Mobile No",
      uavTextEditingController: consignorMobileNoCtrl,
      uavTextInputType: TextInputType.phone,
    );

    UavTextFormField consignorAadharNoTff = UavTextFormField(
      uavLabelText: "Consignor Aadhar No",
      uavTextEditingController: consignorAadharNoCtrl,
      uavTextInputType: TextInputType.number,
    );

    UavTextFormField consignorAddressTff = UavTextFormField(
      uavLabelText: "Consignor Address",
      uavTextEditingController: consignorAddressCtrl,
      uavTextInputType: TextInputType.multiline,
    );

    CustomerBO consigneeBO = new CustomerBO();
    TypeAheadFormField consigneeNameTff = TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: UavDecoration.uavInputDecoration(
              uavLabelText: "Consignee Name", uavSuffixIcon: Icons.person),
          controller: consigneeNameCtrl),
      suggestionsCallback: (pattern) async {
        List<CustomerVO> consigneeList;
        CustomerVO reqConsigneeVO = new CustomerVO();
        reqConsigneeVO.name = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          consigneeList =
              await consigneeBO.getCustomerByAutoSuggest(reqConsigneeVO);
        return consigneeList;
      },
      itemBuilder: (context, consigneeVO) {
        return ListTile(
          leading: Icon(Icons.search),
          title: (consigneeVO.status == "success")
              ? Text(consigneeVO.value)
              : Text(consigneeVO.message),
        );
      },
      onSuggestionSelected: (consigneeVO) {
        if (consigneeVO.status == "success") {
          consigneeIdCtrl.text = consigneeVO.customerId.toString();
          consigneeNameCtrl.text = consigneeVO.name;
          consigneeGstNoCtrl.text = consigneeVO.gstNo;
          consigneeMobileNoCtrl.text = consigneeVO.mobileNo;
          consigneeAadharNoCtrl.text = consigneeVO.aadharNo;
          consigneeAddressCtrl.text = consigneeVO.address;
        } else {
          consigneeIdCtrl.text = "";
          consigneeNameCtrl.text = "";
        }
      },
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : null;
      },
    );
    UavHiddenFormField consigneeIdHff = new UavHiddenFormField(
      uavTextEditingController: consigneeIdCtrl,
    );

    UavTextFormField consigneeGstNoTff = UavTextFormField(
      uavLabelText: "Consignee Gstin No",
      uavTextEditingController: consigneeGstNoCtrl,
    );

    UavTextFormField consigneeMobileNoTff = UavTextFormField(
      uavLabelText: "Consignee Mobile No",
      uavTextEditingController: consigneeMobileNoCtrl,
      uavTextInputType: TextInputType.phone,
    );

    UavTextFormField consigneeAadharNoTff = UavTextFormField(
      uavLabelText: "Consignee Aadhar No",
      uavTextEditingController: consigneeAadharNoCtrl,
      uavTextInputType: TextInputType.number,
    );

    UavTextFormField consigneeAddressTff = UavTextFormField(
      uavLabelText: "Consignee Address",
      uavTextEditingController: consigneeAddressCtrl,
      uavTextInputType: TextInputType.multiline,
    );

    DropdownButtonFormField contentTypeDdff = DropdownButtonFormField(
      decoration: UavDecoration.uavInputDecoration(
          uavLabelText: "Content (Goods) Type", uavHintText: "Please pick one"),
      items: contentTypeList,
      onChanged: (value) {
        contentTypeCtrl.text = value.toString();
      },
      validator: (value) {
        return (value == null) ? UavRequiredFieldError : null;
      },
    );

    DropdownButtonFormField containerTypeDdff = DropdownButtonFormField(
      decoration: UavDecoration.uavInputDecoration(
          uavLabelText: "Truck Load Type", uavHintText: "Please pick one"),
      items: containerTypeList,
      onChanged: (value) {
        containerTypeCtrl.text = value.toString();
      },
      validator: (value) {
        return (value == null) ? UavRequiredFieldError : null;
      },
    );

    UavTextFormField boxesTff = UavTextFormField(
      uavLabelText: "Total Box/Bag/Unit(Nug)",
      uavTextInputType: TextInputType.number,
      uavTextEditingController: boxesCtrl,
      uavFocusNode: boxesFocusNode,
      uavRequestFocusNode: goodsNameFocusNode,
    );

    UavTextFormField goodsNameTff = UavTextFormField(
      uavLabelText: "Goods Name",
      uavTextEditingController: goodsNameCtrl,
    );

    DateTimePicker planForDateTff = new DateTimePicker(
      decoration: InputDecoration(
        labelText: "Pickup Date",
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

    UavTextFormField referenceNumberTff = UavTextFormField(
      uavLabelText: "Consignment No",
      uavTextEditingController: referenceNumberCtrl,
      uavFocusNode: referenceNumberFocusNode,
      uavTextInputType: TextInputType.number,
    );

    SizedBox spacer = new SizedBox(height: UavScreenSize.getScreenHeight(20));

    /*
    UavFlatButton submitBtn = new UavFlatButton(
      text: 'Continue',
      press: createBookingRequest,
    );
    */
    /*
    IconStepper uavIconStepper = new IconStepper(
      icons: [
        Icon(Icons.location_city),
        Icon(Icons.location_city),
        Icon(Icons.person),
        Icon(Icons.person),
        Icon(Icons.ac_unit),
        Icon(Icons.local_shipping),
        Icon(Icons.payment),
      ],

      // activeStep property set to activeStep variable defined above.
      activeStep: activeStep,

      // This ensures step-tapping updates the activeStep.
      onStepReached: (index) {
        setState(() {
          activeStep = index;
        });
      },
    );
    */

    /// Returns the header wrapping the header text.
    Container stepHeader = new Container(
      /*
      decoration: BoxDecoration(
        color: UavPrimaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      */
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              stepHeaderText(),
              style: TextStyle(
                color: UavSecondaryColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );

    /*
    Expanded steps = new Expanded(
      child: FittedBox(
        child: Center(
          child: stepContent(),
        ),
      ),
    );
    */

    Row buttons = new Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
          onPressed: () {
            // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
            if (activeStep > 0) {
              setState(() {
                activeStep--;
              });
            }
          },
          child: Text('Prev'),
        ),
        ElevatedButton(
          onPressed: () {
            // Increment activeStep, when the next button is tapped. However, check for upper bound.
            if (transporterBookingFormKey.currentState.validate()) {
              if (activeStep < upperBound) {
                setState(() {
                  activeStep++;
                });
              } else {
                saveConsignment();
              }
            }
          },
          child: (activeStep < upperBound) ? Text('Next') : Text('Book'),
        )
      ],
    );

    fromAndToDetailStep = new Column(
      children: [
        spacer,
        originCityTff,
        spacer,
        // pickupPointTff,
        // spacer,
        destinationCityTff,
        spacer,
        // dropPointTff,
        // spacer,
        deliveryAtDdff,
        originCityIdHff,
        destinationCityIdHff,
      ],
    );

    consignorDetailStep = new Column(
      children: [
        spacer,
        consignorNameTff,
        spacer,
        consignorGstNoTff,
        spacer,
        consignorMobileNoTff,
        spacer,
        consignorAadharNoTff,
        spacer,
        consignorAddressTff,
        consignorIdHff,
      ],
    );

    consigneeDetailStep = new Column(
      children: [
        spacer,
        consigneeNameTff,
        spacer,
        consigneeGstNoTff,
        spacer,
        consigneeMobileNoTff,
        spacer,
        consigneeAadharNoTff,
        spacer,
        consigneeAddressTff,
        consigneeIdHff,
      ],
    );

    goodsDetailStep = new Column(
      children: [
        spacer,
        contentTypeDdff,
        spacer,
        containerTypeDdff,
        spacer,
        boxesTff,
        spacer,
        goodsNameTff,
        spacer,
        planForDateTff
      ],
    );

    otherDetailStep = new Column(
      children: [
        spacer,
        referenceNumberTff,
      ],
    );

    carrierDetailStep = new Column(
      children: [
        spacer,
        carrierTff,
        spacer,
        ownerTff,
        spacer,
        ownerMobileNoTff,
        spacer,
        driverTff,
        spacer,
        driverMobileNoTff,
        carrierIdHff,
        ownerIdHff,
        driverIdHff,
      ],
    );

    paymentDetailStep = new Column(
      children: [
        spacer,
        weightRow,
        spacer,
        rateTff,
        spacer,
        freightTff,
        spacer,
        stChargesTff,
        spacer,
        colChargesTff,
        spacer,
        otherChargesTff,
        spacer,
        grossAmountTff,
        spacer,
        cgstAmountTff,
        spacer,
        sgstAmountTff,
        spacer,
        igstAmountTff,
        spacer,
        netAmountTff,
        spacer,
        advanceTff,
        spacer,
        balanceTff
      ],
    );

    Column singleCol = new Column(
      children: [
        spacer,
        // uavIconStepper,
        // spacer,
        stepHeader,
        spacer,
        stepContent(),
        spacer,
        buttons
      ],
    );

    SingleChildScrollView childScrollView = new SingleChildScrollView(
      child: singleCol,
      // child: uavIconStepper,
    );

    Form transporterBookingForm = new Form(
      key: transporterBookingFormKey,
      child: childScrollView,
    );

    // SafeArea body = new SafeArea(child: signInForm);

    UavAppBar uavAppBar = new UavAppBar(
      title: "Transporter Booking",
      automaticallyImplyLeading: false,
    );

    UavBody uavBody = new UavBody(
      body: transporterBookingForm,
    );

    UavScaffold uavScaffold = new UavScaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.0), child: uavAppBar),
        body: uavBody);

    return uavScaffold;
  }

  // Returns the header text based on the activeStep.
  String stepHeaderText() {
    switch (activeStep) {
      case 0:
        return 'Goods Detail';

      case 1:
        return 'Origin-Destination Detail';

      case 2:
        return 'Consignor Detail';

      case 3:
        return 'Consignee Detail';

      case 4:
        return 'Payment Detail';

      case 5:
        return 'Other Detail';

      case 6:
        return 'Carrier (Truck) Detail';

      default:
        return 'default';
    }
  }

  // Returns the header text based on the activeStep.
  Widget stepContent() {
    switch (activeStep) {
      case 0:
        return goodsDetailStep;

      case 1:
        return fromAndToDetailStep;

      case 2:
        return consignorDetailStep;

      case 3:
        return consigneeDetailStep;

      case 4:
        return paymentDetailStep;

      case 5:
        return otherDetailStep;

      case 6:
        return carrierDetailStep;

      default:
        return goodsDetailStep;
    }
  }

  void calculateFreight() {
    var weight = chargeableWtCtrl.text;
    var rate = rateCtrl.text;
    if (weight == null || weight == "") {
      weight = UavDoubleTypeTextFieldDefaultValue;
      chargeableWtCtrl.text = weight;
    }

    if (rate == null || rate == "") {
      rate = UavDoubleTypeTextFieldDefaultValue;
      rateCtrl.text = rate;
    }

    var freight = double.parse(weight) * double.parse(rate);

    freightCtrl.text = freight.toString();
    grossAmountCtrl.text = freight.toString();
    netAmountCtrl.text = freight.toString();
  }

  validateCarrier(value) {
    if (contentTypeCtrl.text.isNotEmpty) {
      if (int.parse(contentTypeCtrl.text) == HouseHoldContentTypeId &&
          value == null) {
        print(int.parse(contentTypeCtrl.text));
        return UavRequiredFieldError;
      }
    }

    if (containerTypeCtrl.text.isNotEmpty) {
      if (int.parse(containerTypeCtrl.text) == FullLoadContainerTypeId &&
          value == null) {
        print(int.parse(containerTypeCtrl.text));
        return UavRequiredFieldError;
      }
    }
    return null;
  }

  void reCalculateFreight() {
    var freight = freightCtrl.text;
    if (freight == null || freight == "") {
      freightCtrl.text = UavDoubleTypeTextFieldDefaultValue;
    }

    grossAmountCtrl.text = freight.toString();
    netAmountCtrl.text = freight.toString();
  }

  void calculateNetAmount() {
    var freight = freightCtrl.text;
    var stCharges = stChargesCtrl.text;
    var colCharges = colChargesCtrl.text;
    var otherCharges = otherChargesCtrl.text;
    var cgstAmount = cgstAmountCtrl.text;
    var sgstAmount = sgstAmountCtrl.text;
    var igstAmount = igstAmountCtrl.text;

    if (freight == null || freight == "")
      freight = UavDoubleTypeTextFieldDefaultValue;
    if (stCharges == null || stCharges == "")
      stCharges = UavDoubleTypeTextFieldDefaultValue;
    if (colCharges == null || colCharges == "")
      colCharges = UavDoubleTypeTextFieldDefaultValue;
    if (otherCharges == null || otherCharges == "")
      otherCharges = UavDoubleTypeTextFieldDefaultValue;
    if (cgstAmount == null || cgstAmount == "")
      cgstAmount = UavDoubleTypeTextFieldDefaultValue;
    if (sgstAmount == null || sgstAmount == "")
      sgstAmount = UavDoubleTypeTextFieldDefaultValue;
    if (igstAmount == null || igstAmount == "")
      igstAmount = UavDoubleTypeTextFieldDefaultValue;

    var grossAmount = double.parse(freight) +
        double.parse(stCharges) +
        double.parse(colCharges) +
        double.parse(otherCharges);

    var netAmount = double.parse(cgstAmount) +
        double.parse(sgstAmount) +
        double.parse(igstAmount);
    grossAmountCtrl.text = grossAmount.toString();
    netAmountCtrl.text = netAmount.toString();
  }

  void calculateBalance() {
    var netAmount = netAmountCtrl.text;
    var advance = advanceCtrl.text;
    if (netAmount == null || netAmount == "") {
      netAmount = UavDoubleTypeTextFieldDefaultValue;
      netAmountCtrl.text = netAmount;
    }

    if (advance == null || advance == "") {
      advance = UavDoubleTypeTextFieldDefaultValue;
      advanceCtrl.text = advance;
    }

    if (double.parse(advance) > double.parse(netAmount)) {
      /*
      errorMsg.toast({
        'toastclass': 'bgred errormsg',
        'msg': 'advance cannot be greater then amount.'
      });
      */
      print('advance cannot be greater then amount.');
      advanceFocusNode.hasFocus;
    }
    var balance = double.parse(netAmount) - double.parse(advance);
    balanceCtrl.text = balance.toString();
  }

  Future<void> saveConsignment() async {
    if (transporterBookingFormKey.currentState.validate()) {
      transporterBookingFormKey.currentState.save();

      CityVO originVO = new CityVO();
      originVO.cityId = (originCityIdCtrl.text.isNotEmpty)
          ? int.parse(originCityIdCtrl.text)
          : null;
      // originVO.cityId = int.parse(originCityIdCtrl.text);
      originVO.cityName = originCityNameCtrl.text;

      CityVO destinationVO = new CityVO();
      destinationVO.cityId = (destinationCityIdCtrl.text.isNotEmpty)
          ? int.parse(destinationCityIdCtrl.text)
          : null;
      // destinationVO.cityId = int.parse(destinationCityIdCtrl.text);
      destinationVO.cityName = destinationCityNameCtrl.text;

      CustomerVO consignorVO = new CustomerVO();
      consignorVO.customerId = (consignorIdCtrl.text.isNotEmpty)
          ? int.parse(consignorIdCtrl.text)
          : null;
      consignorVO.name =
          (consignorNameCtrl.text.isNotEmpty) ? consignorNameCtrl.text : null;
      consignorVO.mobileNo = (consignorMobileNoCtrl.text.isNotEmpty)
          ? consignorMobileNoCtrl.text
          : null;
      consignorVO.gstNo =
          (consignorGstNoCtrl.text.isNotEmpty) ? consignorGstNoCtrl.text : null;
      consignorVO.aadharNo = (consignorAadharNoCtrl.text.isNotEmpty)
          ? consignorAadharNoCtrl.text
          : null;
      consignorVO.address = (consignorAddressCtrl.text.isNotEmpty)
          ? consignorAddressCtrl.text
          : null;

      CustomerVO consigneeVO = new CustomerVO();
      consigneeVO.customerId = (consigneeIdCtrl.text.isNotEmpty)
          ? int.parse(consigneeIdCtrl.text)
          : null;
      consigneeVO.name =
          (consigneeNameCtrl.text.isNotEmpty) ? consigneeNameCtrl.text : null;
      consigneeVO.mobileNo = (consigneeMobileNoCtrl.text.isNotEmpty)
          ? consigneeMobileNoCtrl.text
          : null;
      consigneeVO.gstNo =
          (consigneeGstNoCtrl.text.isNotEmpty) ? consigneeGstNoCtrl.text : null;
      consigneeVO.aadharNo = (consigneeAadharNoCtrl.text.isNotEmpty)
          ? consigneeAadharNoCtrl.text
          : null;
      consigneeVO.address = (consigneeAddressCtrl.text.isNotEmpty)
          ? consigneeAddressCtrl.text
          : null;

      CarrierVO carrierVO = new CarrierVO();
      carrierVO.carrierId = (carrierIdCtrl.text.isNotEmpty)
          ? int.parse(carrierIdCtrl.text)
          : null;
      carrierVO.carrierName =
          (carrierNameCtrl.text.isNotEmpty) ? carrierNameCtrl.text : null;
      carrierVO.carrierCode =
          (carrierCodeCtrl.text.isNotEmpty) ? carrierCodeCtrl.text : null;

      OwnerVO ownerVO = new OwnerVO();
      ownerVO.ownerId =
          (ownerIdCtrl.text.isNotEmpty) ? int.parse(ownerIdCtrl.text) : null;
      ownerVO.ownerName =
          (ownerNameCtrl.text.isNotEmpty) ? ownerNameCtrl.text : null;
      ownerVO.mobileNo =
          (ownerMobileNoCtrl.text.isNotEmpty) ? ownerMobileNoCtrl.text : null;

      DriverVO driverVO = new DriverVO();
      driverVO.driverId =
          (driverIdCtrl.text.isNotEmpty) ? int.parse(driverIdCtrl.text) : null;
      driverVO.driverName =
          (driverNameCtrl.text.isNotEmpty) ? driverNameCtrl.text : null;
      driverVO.mobileNo =
          (driverMobileNoCtrl.text.isNotEmpty) ? driverMobileNoCtrl.text : null;

      MeasurementUnitTypeVO measurementUnitTypeVO = new MeasurementUnitTypeVO();
      measurementUnitTypeVO.typeId = 1;

      ContentTypeVO contentTypeVO = new ContentTypeVO();
      contentTypeVO.typeId = int.parse(contentTypeCtrl.text);

      ContainerTypeVO containerTypeVO = new ContainerTypeVO();
      containerTypeVO.typeId = int.parse(containerTypeCtrl.text);

      ShipmentTypeVO shipmentTypeVO = new ShipmentTypeVO();
      shipmentTypeVO.typeId = 1;

      DocumentTypeVO documentTypeVO = new DocumentTypeVO();
      documentTypeVO.typeId = 1;

      ShipmentBookingTypeVO shipmentBookingTypeVO = new ShipmentBookingTypeVO();
      shipmentBookingTypeVO.typeId = 1;

      MemberVO memberVO = new MemberVO();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var memberId = prefs.get("memberId");
      if (memberId != null && memberId != "") {
        memberVO.memberId = memberId;
      }

      setState(() {
        shipmentUnitVO.member = memberVO.toJson();

        shipmentUnitVO.unitId = UavUtility.setNullIfEmpty(unitIdCtrl.text);
        shipmentUnitVO.origin = originVO.toJson();
        shipmentUnitVO.pickupPoint = pickupPointCtrl.text;
        shipmentUnitVO.destination = destinationVO.toJson();
        shipmentUnitVO.dropPoint = dropPointCtrl.text;
        shipmentUnitVO.deliveryAt = deliveryAtCtrl.text;

        shipmentUnitVO.consignor = consignorVO.toJson();
        shipmentUnitVO.consignee = consigneeVO.toJson();

        shipmentUnitVO.carrier = carrierVO.toJson();
        shipmentUnitVO.carrierOwner = ownerVO.toJson();
        shipmentUnitVO.carrierDriver = driverVO.toJson();

        shipmentUnitVO.contentType = contentTypeVO.toJson();
        shipmentUnitVO.containerType = containerTypeVO.toJson();
        shipmentUnitVO.shipmentType = shipmentTypeVO.toJson();
        shipmentUnitVO.bookingType = shipmentBookingTypeVO.toJson();
        shipmentUnitVO.measurementUnitType = measurementUnitTypeVO.toJson();
        shipmentUnitVO.documentType = documentTypeVO.toJson();

        shipmentUnitVO.goodsName = goodsNameCtrl.text;

        shipmentUnitVO.bookingDate = todayDate;
        shipmentUnitVO.planForDate = planForDateCtrl.text;
        shipmentUnitVO.referenceNumber = referenceNumberCtrl.text;
        shipmentUnitVO.chargeableWt =
            UavUtility.setNullIfEmpty(chargeableWtCtrl.text);
        shipmentUnitVO.rate = UavUtility.setNullIfEmpty(rateCtrl.text);
        shipmentUnitVO.freight = UavUtility.setNullIfEmpty(freightCtrl.text);
        shipmentUnitVO.stCharges =
            UavUtility.setNullIfEmpty(stChargesCtrl.text);
        shipmentUnitVO.colCharges =
            UavUtility.setNullIfEmpty(colChargesCtrl.text);
        shipmentUnitVO.otherCharges =
            UavUtility.setNullIfEmpty(otherChargesCtrl.text);
        shipmentUnitVO.grossAmount =
            UavUtility.setNullIfEmpty(grossAmountCtrl.text);
        shipmentUnitVO.cgstAmount =
            UavUtility.setNullIfEmpty(cgstAmountCtrl.text);
        shipmentUnitVO.sgstAmount =
            UavUtility.setNullIfEmpty(sgstAmountCtrl.text);
        shipmentUnitVO.igstAmount =
            UavUtility.setNullIfEmpty(igstAmountCtrl.text);
        shipmentUnitVO.netAmount =
            UavUtility.setNullIfEmpty(netAmountCtrl.text);
        shipmentUnitVO.advance = UavUtility.setNullIfEmpty(advanceCtrl.text);
        shipmentUnitVO.balance = UavUtility.setNullIfEmpty(balanceCtrl.text);

        shipmentUnitVO.invoiceNumber = invoiceNumberCtrl.text;
        shipmentUnitVO.boxes = boxesCtrl.text;
        shipmentUnitVO.shipmentValue = (shipmentValueCtrl.text.isNotEmpty)
            ? int.parse(shipmentValueCtrl.text)
            : 0.00;
        shipmentUnitVO.eWayBillno = eWayBillnoCtrl.text;
        shipmentUnitVO.ewayBillExpiryDate = ewayBillExpiryDateCtrl.text;
        shipmentUnitVO.hsnCode = hsnCodeCtrl.text;
        shipmentUnitVO.remarks = remarksCtrl.text;
        shipmentUnitVO.gstPaidBy = gstPaidByCtrl.text;
        shipmentUnitVO.billingStation = billingStationCtrl.text;
        shipmentUnitVO.description = descriptionCtrl.text;
        shipmentUnitVO.billWeight = billWeightCtrl.text;

        print(shipmentUnitVO.toJson());
        errors = [];
      });

      ShipmentUnitBO shipmentUnitBO = new ShipmentUnitBO();
      ShipmentUnitVO currentShipmentUnitVO = new ShipmentUnitVO();

      if (prefs.getString("uavFormKey") !=
          transporterBookingFormKey.currentState.toString()) {
        currentShipmentUnitVO =
            await shipmentUnitBO.saveConsignment(shipmentUnitVO);

        if (currentShipmentUnitVO.status == "success") {
          UavKeyboard.hideKeyboard(context);

          prefs.setString(
              "uavFormKey", transporterBookingFormKey.currentState.toString());

          UavDialog.showSuccessDialog(
            context: context,
            uavContent: currentShipmentUnitVO.message,
            navigationPath: UavRoutes.BookingList,
            param: {
              "shipmentStatusId": ShipmentStatusVO.Booked,
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
          navigationPath: UavRoutes.BookingList,
          param: {
            "shipmentStatusId": ShipmentStatusVO.Booked,
            "memberId": prefs.getInt("memberId")
          },
        );
      }
    }

    return;
  }

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

  List<DropdownMenuItem> getDropDownMenuList(dataList) {
    List<DropdownMenuItem> resDataList = [];

    for (Map mapArr in dataList) {
      DropdownMenuItem dropdownMenuItem = new DropdownMenuItem(
        child: Text(mapArr["display"]),
        value: mapArr["value"],
      );
      resDataList.add(dropdownMenuItem);
    }
    // print(resDataList);
    return resDataList;
  }
}
