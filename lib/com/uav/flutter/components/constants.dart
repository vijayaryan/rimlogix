import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/components/utility.dart';

const UavPrimaryColor = Colors.deepOrange; //Color(0xFFFF7643);
const UavSecondaryColor = Color(0xFF979797);
const UavTextColor = Color(0xFF757575);

const UavDefaultDuration = Duration(milliseconds: 250);
const UavAnimationDuration = Duration(milliseconds: 200);

const UavMobileNumberMaxLength = 10;
const UavAutoSuggestPatternLength = 3;

final uavHeadingStyle = TextStyle(
  fontSize: UavScreenSize.getScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: UavSecondaryColor,
  height: 1.5,
);

final uavSubHeadingStyle = TextStyle(
  fontSize: UavScreenSize.getScreenWidth(14),
  color: UavSecondaryColor,
);

final headingStyle = TextStyle(
  fontSize: UavScreenSize.getScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: UavSecondaryColor,
  height: 1.5,
);

// Form Error
final RegExp uavEmailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp uavPhoneValidatorRegExp = RegExp(r"^\+[1-9]{1}[0-9]{3,14}$");
final RegExp uavMobileValidatorRegExp = RegExp(r"^(?:[+0]9)?[0-9]{10}$");

const String UavInvalidEmailError = "Please Enter Valid Email";
const String UavShortPassError = "Password is too short";
const String UavMatchPassError = "Passwords don't match";
const String UavInvalidMobileError = "Please Enter Valid mobile number";
const String UavRequiredFieldError = "this field is required!";

const String UavPatternNotMatchedError = "pattern not matched!";

const String UavCityByAutoSuggestAction =
    "rest/stateless/getCityByAutoSuggestV1";
const String UavCarrierByAutoSuggestAction =
    "rest/stateless/getCarrierByAutoSuggestV1";
const String UavOwnerByAutoSuggestAction =
    "rest/stateless/getCarrierOwnerByAutoSuggestV1";
const String UavDriverByAutoSuggestAction =
    "rest/stateless/getCarrierDriverByAutoSuggestV1";
const String UavCustomerByAutoSuggestAction =
    "rest/stateless/getCustomerByAutoSuggestV1";

const String UavContentTypeCacheAction = "rest/stateless/getContentTypeCacheV1";
const String UavContainerTypeCacheAction =
    "rest/stateless/getContainerTypeCacheV1";
const String UavShipmentTypeCacheAction =
    "rest/stateless/getShipmentTypeCacheV1";
const String UavShipmentBookingTypeCacheAction =
    "rest/stateless/getShipmentBookingTypeCacheV1";
const String UavMeasurementUnitTypeCacheAction =
    "rest/stateless/getMeasurementUnitTypeCacheV1";

const String UavBookingListAction = "rest/stateless/getBookingListV1";
const String UavPlannedListAction = "rest/stateless/getPlannedListV1";

const String UavCreateBookingRequestAction =
    "rest/stateless/createBookingRequestV1";
const String UavSaveConsignmentAction = "rest/stateless/saveConsignmentV1";

const String UavLoginByEmailIdAndPasswordAction =
    "rest/stateless/loginByEmailIdAndPassword";
const String UavLoginByMobileNoAndPasswordAction =
    "rest/stateless/loginByMobileNoAndPassword";

const UavDoubleTypeTextFieldDefaultValue = '0.0';

const HouseHoldContentTypeId = 1;
const FullLoadContainerTypeId = 2;

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: UavScreenSize.getScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(UavScreenSize.getScreenWidth(15)),
    borderSide: BorderSide(color: UavTextColor),
  );
}
