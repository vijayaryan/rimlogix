class BaseVO {
  String status;
  String message;
  int pageNumber;
  int pageSize;
  String sortOrderColumn;
  String orderDir;
  String filters;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> jsonObj = Map<String, dynamic>();

    jsonObj["pageNumber"] = this.pageNumber;
    jsonObj["pageSize"] = this.pageSize;
    jsonObj["sortOrderColumn"] = this.sortOrderColumn;
    jsonObj["orderDir"] = this.orderDir;
    jsonObj["filters"] = this.filters;

    jsonObj.removeWhere((key, value) => key == null || value == null);
    // jsonObj.forEach((key, value) {});

    return jsonObj;
  }
}
