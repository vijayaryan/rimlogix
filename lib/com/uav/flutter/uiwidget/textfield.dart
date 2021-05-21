import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rimlogix/com/uav/flutter/bo/carrier/carrier_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/carrier/driver_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/carrier/owner_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/city/city_bo.dart';
import 'package:rimlogix/com/uav/flutter/bo/customer/customer_bo.dart';
import 'package:rimlogix/com/uav/flutter/components/constants.dart';
import 'package:rimlogix/com/uav/flutter/vo/carrier/carrier_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/carrier/driver_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/carrier/owner_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/city/city_vo.dart';
import 'package:rimlogix/com/uav/flutter/vo/customer/customer_vo.dart';
// import 'package:rimlogix/com/uav/flutter/components/constants.dart';
// import 'package:rimlogix/com/uav/flutter/components/utility.dart';

class UavTextField extends StatelessWidget {
  final String uavLabelText;
  final TextEditingController uavTextEditingController;
  final TextInputType uavTextInputType;
  final IconData uavSuffixIcon;
  const UavTextField(
      {Key key,
      this.uavLabelText,
      this.uavTextEditingController,
      this.uavTextInputType,
      this.uavSuffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.uavTextEditingController,
      decoration: InputDecoration(
        labelText: this.uavLabelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Icon(this.uavSuffixIcon),
        // suffixIcon: this.uavSuffixIcon
      ),
      keyboardType: this.uavTextInputType,
    );
  }
}

class UavTextFormField extends StatelessWidget {
  final String uavLabelText;
  final TextEditingController uavTextEditingController;
  final TextInputType uavTextInputType;
  final FocusNode uavFocusNode;
  final FocusNode uavRequestFocusNode;
  // final IconData uavSuffixIcon;

  UavTextFormField(
      {Key key,
      this.uavLabelText,
      this.uavTextEditingController,
      this.uavTextInputType,
      this.uavFocusNode,
      this.uavRequestFocusNode
      // this.uavSuffixIcon
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.uavTextEditingController,
      decoration: InputDecoration(
        labelText: this.uavLabelText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: Icon(this.uavSuffixIcon),
        // suffixIcon: this.uavSuffixIcon
      ),
      keyboardType: this.uavTextInputType,
      focusNode: uavFocusNode,
      onEditingComplete: () {
        print("onEditingComplete");
        uavRequestFocusNode.requestFocus();
      },
      /*
      validator: (value) {
        String errorStr;
        if (value.isEmpty) {
          errorStr = UavRequiredFieldError;
        }
        return errorStr;
      },
      */
    );
  }
}

class UavHiddenFormField extends StatelessWidget {
  final TextEditingController uavTextEditingController;
  const UavHiddenFormField({
    Key key,
    this.uavTextEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: false,
      child: TextFormField(
        controller: this.uavTextEditingController,
      ),
    );
  }
}

class UavDropDownFormField extends StatelessWidget {
  final String uavLabelText;
  final TextEditingController uavTextEditingController;
  final TextInputType uavTextInputType;
  final List uavDataSource;
  // final IconData uavSuffixIcon;

  UavDropDownFormField(
      {Key key,
      this.uavLabelText,
      this.uavTextEditingController,
      this.uavTextInputType,
      this.uavDataSource
      // this.uavSuffixIcon
      });

  @override
  Widget build(BuildContext context) {
    return DropDownFormField(
      titleText: this.uavLabelText,
      value: this.uavTextEditingController.text,
      hintText: 'Select..',
      dataSource: this.uavDataSource,
      textField: 'display',
      valueField: 'value',
      onSaved: (value) {},
      onChanged: (value) {
        // this.uavTextEditingController.value = value;
        this.uavTextEditingController.text = value.toString();
      },
      /*
      validator: (value) {
        String errorStr;
        if (value.isEmpty) {
          errorStr = UavRequiredFieldError;
        }
        return errorStr;
      },
      */
    );
  }
}

class UavAutoSuggestCityTextFormField extends StatelessWidget {
  final String uavCityLabelText;
  final TextEditingController uavCityNameCtrl;
  final TextEditingController uavCityIdCtrl;
  final FocusNode uavFocusNode;
  final FocusNode uavRequestFocusNode;
  const UavAutoSuggestCityTextFormField(
      {Key key,
      this.uavCityLabelText,
      this.uavCityNameCtrl,
      this.uavCityIdCtrl,
      this.uavFocusNode,
      this.uavRequestFocusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CityBO cityBO = new CityBO();
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: this.uavCityLabelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const Icon(Icons.location_city),
          ),
          focusNode: uavFocusNode,
          onEditingComplete: () {
            print("onEditingComplete");
            uavRequestFocusNode.requestFocus();
          },
          controller: uavCityNameCtrl),
      suggestionsCallback: (pattern) async {
        List<CityVO> cityList;
        CityVO reqCityVO = new CityVO();
        reqCityVO.cityName = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          cityList = await cityBO.getCityByAutoSuggest(reqCityVO);
        return cityList;
      },
      itemBuilder: (context, CityVO cityVO) {
        return ListTile(
          leading: Icon(Icons.search),
          title: (cityVO.status == "success")
              ? Text(cityVO.cityName)
              : Text(cityVO.message),
        );
      },
      onSuggestionSelected: (CityVO cityVO) {
        if (cityVO.status == "success") {
          this.uavCityIdCtrl.text = cityVO.cityId.toString();
          this.uavCityNameCtrl.text = cityVO.cityName;
        } else {
          this.uavCityIdCtrl.text = "";
          this.uavCityNameCtrl.text = "";
        }
      },
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : null;
      },
    );
  }
}

class UavAutoSuggestCarrierTextFormField extends StatelessWidget {
  final String uavCarrierLabelText;
  final TextEditingController uavCarrierNameCtrl;
  final TextEditingController uavCarrierIdCtrl;
  const UavAutoSuggestCarrierTextFormField(
      {Key key,
      this.uavCarrierLabelText,
      this.uavCarrierNameCtrl,
      this.uavCarrierIdCtrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CarrierBO carrierBO = new CarrierBO();
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: this.uavCarrierLabelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const Icon(Icons.local_shipping),
          ),
          controller: uavCarrierNameCtrl),
      suggestionsCallback: (pattern) async {
        List<CarrierVO> carrierList;
        CarrierVO reqCarrierVO = new CarrierVO();
        reqCarrierVO.carrierCode = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          carrierList = await carrierBO.getCarrierByAutoSuggest(reqCarrierVO);
        return carrierList;
      },
      itemBuilder: (context, CarrierVO carrierVO) {
        return ListTile(
          leading: Icon(Icons.local_shipping),
          title: (carrierVO.status == "success")
              ? Text(carrierVO.carrierName)
              : Text(carrierVO.message),
        );
      },
      onSuggestionSelected: (CarrierVO carrierVO) {
        if (carrierVO.status == "success") {
          this.uavCarrierIdCtrl.text = carrierVO.carrierId.toString();
          this.uavCarrierNameCtrl.text = carrierVO.carrierName;
        } else {
          this.uavCarrierIdCtrl.text = "";
          this.uavCarrierNameCtrl.text = "";
        }
      },
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : null;
      },
    );
  }
}

class UavAutoSuggestOwnerTextFormField extends StatelessWidget {
  final String uavOwnerLabelText;
  final TextEditingController uavOwnerNameCtrl;
  final TextEditingController uavOwnerIdCtrl;
  const UavAutoSuggestOwnerTextFormField(
      {Key key,
      this.uavOwnerLabelText,
      this.uavOwnerNameCtrl,
      this.uavOwnerIdCtrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    OwnerBO ownerBO = new OwnerBO();
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: this.uavOwnerLabelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const Icon(Icons.person),
          ),
          controller: uavOwnerNameCtrl),
      suggestionsCallback: (pattern) async {
        List<OwnerVO> ownerList;
        OwnerVO reqOwnerVO = new OwnerVO();
        reqOwnerVO.ownerName = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          ownerList = await ownerBO.getOwnerByAutoSuggest(reqOwnerVO);
        return ownerList;
      },
      itemBuilder: (context, OwnerVO ownerVO) {
        return ListTile(
          leading: Icon(Icons.person),
          title: (ownerVO.status == "success")
              ? Text(ownerVO.ownerName)
              : Text(ownerVO.message),
        );
      },
      onSuggestionSelected: (OwnerVO ownerVO) {
        if (ownerVO.status == "success") {
          this.uavOwnerIdCtrl.text = ownerVO.ownerId.toString();
          this.uavOwnerNameCtrl.text = ownerVO.ownerName;
        } else {
          this.uavOwnerIdCtrl.text = "";
          this.uavOwnerNameCtrl.text = "";
        }
      },
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : null;
      },
    );
  }
}

class UavAutoSuggestDriverTextFormField extends StatelessWidget {
  final String uavDriverLabelText;
  final TextEditingController uavDriverNameCtrl;
  final TextEditingController uavDriverIdCtrl;
  const UavAutoSuggestDriverTextFormField(
      {Key key,
      this.uavDriverLabelText,
      this.uavDriverNameCtrl,
      this.uavDriverIdCtrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DriverBO driverBO = new DriverBO();
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: this.uavDriverLabelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const Icon(Icons.person),
          ),
          controller: uavDriverNameCtrl),
      suggestionsCallback: (pattern) async {
        List<DriverVO> driverList;
        DriverVO reqDriverVO = new DriverVO();
        reqDriverVO.driverName = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          driverList = await driverBO.getDriverByAutoSuggest(reqDriverVO);
        return driverList;
      },
      itemBuilder: (context, DriverVO driverVO) {
        return ListTile(
          leading: Icon(Icons.person),
          title: (driverVO.status == "success")
              ? Text(driverVO.driverName)
              : Text(driverVO.message),
        );
      },
      onSuggestionSelected: (DriverVO driverVO) {
        if (driverVO.status == "success") {
          this.uavDriverIdCtrl.text = driverVO.driverId.toString();
          this.uavDriverNameCtrl.text = driverVO.driverName;
        } else {
          this.uavDriverIdCtrl.text = "";
          this.uavDriverNameCtrl.text = "";
        }
      },
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : null;
      },
    );
  }
}

/*
class UavAutoSuggestCustomerTextFormField extends StatelessWidget {
  final String uavCustomerLabelText;
  final TextEditingController uavCustomerNameCtrl;
  final TextEditingController uavCustomerIdCtrl;
  const UavAutoSuggestCustomerTextFormField(
      {Key key,
      this.uavCustomerLabelText,
      this.uavCustomerNameCtrl,
      this.uavCustomerIdCtrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerBO customerBO = new CustomerBO();
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: this.uavCustomerLabelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const Icon(Icons.person),
          ),
          controller: uavCustomerNameCtrl),
      suggestionsCallback: (pattern) async {
        List<CustomerVO> customerList;
        CustomerVO reqCustomerVO = new CustomerVO();
        reqCustomerVO.name = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          customerList =
              await customerBO.getCustomerByAutoSuggest(reqCustomerVO);
        return customerList;
      },
      itemBuilder: (context, CustomerVO customerVO) {
        return ListTile(
          leading: Icon(Icons.person),
          title: (customerVO.status == "success")
              ? Text(customerVO.name)
              : Text(customerVO.message),
        );
      },
      onSuggestionSelected: (CustomerVO customerVO) {
        if (customerVO.status == "success") {
          this.uavCustomerIdCtrl.text = customerVO.customerId.toString();
          this.uavCustomerNameCtrl.text = customerVO.name;
        } else {
          this.uavCustomerIdCtrl.text = "";
          this.uavCustomerNameCtrl.text = "";
        }
      },
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : null;
      },
    );
  }
}
*/

class UavAutoSuggestCustomerTextFormField extends StatelessWidget {
  final String uavCustomerLabelText;
  final TextEditingController uavCustomerNameCtrl;
  final TextEditingController uavCustomerIdCtrl;

  const UavAutoSuggestCustomerTextFormField({
    Key key,
    this.uavCustomerLabelText,
    this.uavCustomerNameCtrl,
    this.uavCustomerIdCtrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CustomerBO customerBO = new CustomerBO();
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
          decoration: InputDecoration(
            labelText: this.uavCustomerLabelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: const Icon(Icons.person),
          ),
          controller: uavCustomerNameCtrl),
      suggestionsCallback: (pattern) async {
        List<CustomerVO> customerList;
        CustomerVO reqCustomerVO = new CustomerVO();
        reqCustomerVO.name = pattern;
        if (pattern.length >= UavAutoSuggestPatternLength)
          customerList =
              await customerBO.getCustomerByAutoSuggest(reqCustomerVO);
        return customerList;
      },
      itemBuilder: (context, CustomerVO customerVO) {
        return ListTile(
          leading: Icon(Icons.person),
          title: (customerVO.status == "success")
              ? Text(customerVO.name)
              : Text(customerVO.message),
        );
      },
      onSuggestionSelected: (CustomerVO customerVO) {
        if (customerVO.status == "success") {
          this.uavCustomerIdCtrl.text = customerVO.customerId.toString();
          this.uavCustomerNameCtrl.text = customerVO.name;
        } else {
          this.uavCustomerIdCtrl.text = "";
          this.uavCustomerNameCtrl.text = "";
        }
      },
      validator: (value) {
        return (value.isEmpty) ? UavRequiredFieldError : null;
      },
    );
  }
}

class UavDropdownButtonFormField extends StatefulWidget {
  final String uavLabelText;
  final TextEditingController uavTextEditingCtrl;
  final List uavDataList;
  UavDropdownButtonFormField(
      {Key key, this.uavLabelText, this.uavTextEditingCtrl, this.uavDataList})
      : super(key: key);

  @override
  _UavDropdownButtonFormFieldState createState() =>
      _UavDropdownButtonFormFieldState();
}

class _UavDropdownButtonFormFieldState
    extends State<UavDropdownButtonFormField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
        decoration: InputDecoration(labelText: widget.uavLabelText),
        value: widget.uavTextEditingCtrl.text,
        items: [
          DropdownMenuItem(
            child: Text("First Item"),
            value: 1,
          ),
          DropdownMenuItem(
            child: Text("Second Item"),
            value: 2,
          ),
          DropdownMenuItem(child: Text("Third Item"), value: 3),
          DropdownMenuItem(child: Text("Fourth Item"), value: 4)
        ],
        onChanged: (value) {
          setState(() {
            // _value = value;
          });
        });
  }

  List<DropdownMenuItem> getDropDownMenuList(dataList) {
    print(dataList);
    List<DropdownMenuItem> resDataList = [];
    /*
    for (Map mapArr in dataList) {
      DropdownMenuItem dropdownMenuItem = new DropdownMenuItem(
        child: Text(mapArr["display"]),
        value: int.parse(mapArr["value"].toString()),
      );
      resDataList.add(dropdownMenuItem);
    }
    */

    resDataList.add(
      DropdownMenuItem(
        child: Text("display"),
        value: 0,
      ),
    );

    resDataList.add(
      DropdownMenuItem(
        child: Text("display"),
        value: 1,
      ),
    );

    resDataList.add(
      DropdownMenuItem(
        child: Text("display"),
        value: 2,
      ),
    );
    return resDataList;
  }
}
