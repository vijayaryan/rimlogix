import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';

class HttpService {
  static const WEBAPP = "http://192.168.29.128:8080/rimlogix/";
  // static const WEBAPP = "http://101.53.154.117:8081/rimlogix/";
  static const authKey = "G4s4cCMx2aM7lky1";
  static const versionCode = "1";
  static const posturl = "/?authkey=" + authKey;

  Future<HttpResponse> postRequest(action, data) async {
    String jsonStr = json.encode(data);
    try {
      final httpRes = await post(
        Uri.parse(WEBAPP + action + posturl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "authkey": authKey,
          "versioncode": versionCode,
        },
        body: jsonStr,
      );

      jsonStr = httpRes.body;
      print(jsonStr);
      return HttpResponse.fromJson(jsonStr);
    } on SocketException {
      return HttpResponse(
          status: 'fail', message: 'No Internet connection.', dataList: null);
      // throw Failure('No Internet connection.');
    } on HttpException {
      return HttpResponse(
          status: 'fail', message: 'Could not find the post.', dataList: null);
      // throw Failure("Couldn't find the post.");
    } on FormatException {
      return HttpResponse(
          status: 'fail', message: 'Bad response format.', dataList: null);
      // throw Failure("Bad response format.");
    } on Exception catch (exception) {
      return HttpResponse(
          status: 'fail', message: exception.toString(), dataList: null);
      // throw Failure(exception.toString());
    } catch (error) {
      return HttpResponse(
          status: 'fail', message: error.toString(), dataList: null);
      // throw Failure(error.toString());
    }
  }

  Future<HttpResponse> getRequest(action, data) async {
    String jsonStr = json.encode(data);
    try {
      final httpRes = await get(
        Uri.parse(WEBAPP + action),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "authkey": authKey,
          "versioncode": versionCode,
        },
      );

      jsonStr = httpRes.body;
      print(jsonStr);
      return HttpResponse.fromJson(jsonStr);
    } on SocketException {
      return HttpResponse(
          status: 'fail', message: 'No Internet connection.', dataList: null);
      // throw Failure('No Internet connection.');
    } on HttpException {
      return HttpResponse(
          status: 'fail', message: 'Could not find the post.', dataList: null);
      // throw Failure("Couldn't find the post.");
    } on FormatException {
      return HttpResponse(
          status: 'fail', message: 'Bad response format.', dataList: null);
      // throw Failure("Bad response format.");
    } on Exception catch (exception) {
      return HttpResponse(
          status: 'fail', message: exception.toString(), dataList: null);
      // throw Failure(exception.toString());
    } catch (error) {
      return HttpResponse(
          status: 'fail', message: error.toString(), dataList: null);
      // throw Failure(error.toString());
    }
  }
}

class HttpResponse {
  final String status;
  final String message;
  final List dataList;

  HttpResponse({this.status, this.message, this.dataList});

  factory HttpResponse.fromJson(String jsonStr) {
    Map<String, dynamic> mapArr = jsonDecode(jsonStr);

    return HttpResponse(
      status: mapArr['status'],
      message: (mapArr['message'] != null)
          ? mapArr['message']
          : mapArr['error'].toString(),
      dataList: mapArr['dataList'],
    );
  }
}
