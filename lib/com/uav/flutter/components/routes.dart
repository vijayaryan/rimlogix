import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:rimlogix/com/uav/flutter/activity/booking/booking_list.dart';
import 'package:rimlogix/com/uav/flutter/activity/booking/customer/customer_booking_request.dart';
import 'package:rimlogix/com/uav/flutter/activity/booking/customer/customer_planned_list.dart';
import 'package:rimlogix/com/uav/flutter/activity/booking/transporter/transporter_booking.dart';
import 'package:rimlogix/com/uav/flutter/activity/booking/transporter/transporter_planned_list.dart';
import 'package:rimlogix/com/uav/flutter/activity/home/customer_home.dart';
import 'package:rimlogix/com/uav/flutter/activity/home/transporter_home.dart';
import 'package:rimlogix/com/uav/flutter/activity/home/vendor_home.dart';
import 'package:rimlogix/com/uav/flutter/activity/booking/vendor/vendor_booking_request.dart';
import 'package:rimlogix/com/uav/flutter/activity/sign_in/transporter_sign_in.dart';
import 'package:rimlogix/com/uav/flutter/activity/sign_in/customer_sign_in.dart';
import 'package:rimlogix/com/uav/flutter/activity/sign_in/sign_in.dart';
import 'package:rimlogix/com/uav/flutter/activity/sign_in/member_type.dart';

class UavRoutes {
  static const SignIn = "/sign_in";
  static const CustomerSignIn = "/customer_sign_in";
  static const TransporterSignIn = "/transporter_sign_in";
  static const MemberType = "/member_type";
  static const VendorHome = "/vendor_home";
  static const TransporterHome = "/transporter_home";
  static const CustomerHome = "/customer_home";
  static const VendorBookingRequest = "/vendor_booking_request";
  static const TransporterBooking = "/transporter_booking";
  static const CustomerBookingRequest = "/customer_booking_request";
  static const BookingList = "/booking_list";
  static const CustomerPlannedList = "/customer_planned_list";
  static const TransporterPlannedList = "/transporter_planned_list";
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case UavRoutes.SignIn:
        return MaterialPageRoute(builder: (_) => SignIn());
      case UavRoutes.CustomerSignIn:
        return MaterialPageRoute(builder: (_) => CustomerSignIn());
      case UavRoutes.TransporterSignIn:
        return MaterialPageRoute(builder: (_) => TransporterSignIn());
      case UavRoutes.MemberType:
        return MaterialPageRoute(builder: (_) => MemberType());
      case UavRoutes.VendorHome:
        return MaterialPageRoute(builder: (_) => VendorHome());
      case UavRoutes.TransporterHome:
        return MaterialPageRoute(builder: (_) => TransporterHome());
      case UavRoutes.CustomerHome:
        return MaterialPageRoute(builder: (_) => CustomerHome());
      case UavRoutes.VendorBookingRequest:
        return MaterialPageRoute(builder: (_) => VendorBookingRequest());
      case UavRoutes.TransporterBooking:
        return MaterialPageRoute(builder: (_) => TransporterBooking());
      case UavRoutes.CustomerBookingRequest:
        return MaterialPageRoute(builder: (_) => CustomerBookingRequest());
      case UavRoutes.BookingList:
        // Validation of correct data type
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => BookingList(
              param: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      case UavRoutes.CustomerPlannedList:
        // Validation of correct data type
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => CustomerPlannedList(
              param: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      case UavRoutes.TransporterPlannedList:
        // Validation of correct data type
        if (args is Map) {
          return MaterialPageRoute(
            builder: (_) => TransporterPlannedList(
              param: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
