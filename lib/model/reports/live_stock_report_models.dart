class FetchLiveStockReportListDataPayload {
  int? menuId;
  String? metal;
  String? item;
  int? page;
  int? itemsPerPage;
  String? branch;
  String? stocktype;

  FetchLiveStockReportListDataPayload(
      {this.menuId,
      this.metal,
      this.item,
      this.page,
      this.itemsPerPage,
      this.stocktype,
      this.branch});

  FetchLiveStockReportListDataPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    metal = json['metal'];
    item = json['item'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
    stocktype = json['stock_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['metal'] = this.metal;
    data['item'] = this.item;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    data['stock_type'] = this.stocktype;
    return data;
  }
}


class LiveStockReportListData {
  String? itemCode;
  String? tagNumber;
  String? grossWeight;
  String? pieces;

  LiveStockReportListData(
      {this.itemCode, this.tagNumber, this.grossWeight, this.pieces});

  LiveStockReportListData.fromJson(Map<String, dynamic> json) {
    itemCode = json['item_code'];
    tagNumber = json['tag_number'];
    grossWeight = json['gross_weight'].toString();
    pieces = json['pieces'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['item_code'] = this.itemCode;
    data['tag_number'] = this.tagNumber;
    data['gross_weight'] = this.grossWeight;
    data['pieces'] = this.pieces;
    return data;
  }
}
