class FetchDirectIssueReportListPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? search;
  int? page;
  int? itemsPerPage;
  int? branch;

  FetchDirectIssueReportListPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.search,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchDirectIssueReportListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}

class DirectIssueReportListData {
  String? tagNo;
  String? itemName;
  int? pieces;
  double? weight;
  int? sNo;

  DirectIssueReportListData(
      {this.tagNo, this.itemName, this.pieces, this.weight, this.sNo});

  DirectIssueReportListData.fromJson(Map<String, dynamic> json) {
    tagNo = json['tag_no'];
    itemName = json['item_name'];
    pieces = json['pieces'];
    weight = json['weight'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_no'] = this.tagNo;
    data['item_name'] = this.itemName;
    data['pieces'] = this.pieces;
    data['weight'] = this.weight;
    data['s_no'] = this.sNo;
    return data;
  }
}
