class HttpResponse {
  final String status;
  final String message;
  final Object dataList;

  HttpResponse({this.status, this.message, this.dataList});

  factory HttpResponse.fromJson(Map<String, dynamic> jsonObj) {
    return HttpResponse(
      status: jsonObj['status'],
      message: jsonObj['message'],
      dataList: jsonObj['dataList'],
    );
  }
}
