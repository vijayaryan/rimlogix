import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rimlogix/com/uav/flutter/components/http_response.dart';

class Http {
  // var WEBAPP = window.location.pathname.split("/")[1];
  static const WEBAPP = "http://192.168.29.128:8080/rimlogix/";
  static const authKey = "G4s4cCMx2aM7lky1";
  static const versionCode = "1";

  /*
  Future<dynamic> postRequest(action, data, callBackFunc) async {
    var resObj = await post(Uri.parse(WEBAPP + action),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "authkey": authKey,
          "versioncode": versionCode,
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));
    return resObj.body;
  }
  */

  Future<HttpResponse> postRequest(action, data, callBackFunc) async {
    var httpRes = await post(Uri.parse(WEBAPP + action),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "authkey": authKey,
          "versioncode": versionCode,
        },
        body: json.encode(data),
        encoding: Encoding.getByName("utf-8"));

    if (httpRes.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return HttpResponse.fromJson(jsonDecode(httpRes.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load');
    }
  }
}
