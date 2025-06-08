class FetchItemClosingReportListDataPayload {
  int? menuId;
  String? fromDate;
  String? item;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchItemClosingReportListDataPayload(
      {this.menuId,
      this.fromDate,
      this.item,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchItemClosingReportListDataPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    item = json['item'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['item'] = this.item;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}


class ItemClosingReportListData {
  String? itemName;
  String? closePieces;
  String? closeWeight;
  int? sNo;

  ItemClosingReportListData(
      {this.itemName, this.closePieces, this.closeWeight, this.sNo});

  ItemClosingReportListData.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    closePieces = json['close_pieces'].toString();
    closeWeight = json['close_weight'].toString();
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_name'] = this.itemName;
    data['close_pieces'] = this.closePieces;
    data['close_weight'] = this.closeWeight;
    data['s_no'] = this.sNo;
    return data;
  }
}
