class RequestDataVO {
  int pageNumber;
  int pageSize;
  String sortOrderColumn;
  String orderDir;
  String filters;

  RequestDataVO({
    this.pageNumber,
    this.pageSize,
    this.sortOrderColumn,
    this.orderDir,
    this.filters,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["pageNumber"] = this.pageNumber;
    data["pageSize"] = this.pageSize;
    data["sortOrderColumn"] = this.sortOrderColumn;
    data["orderDir"] = this.orderDir;
    data["filters"] = this.filters;

    return data;
  }
}
