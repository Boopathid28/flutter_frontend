class FetchStockOutwardListDataPayload {
  String? fromDate;
  String? toDate;
  String? item;
  String? metal;
  String? designer;
  int? page;
  int? itemsPerPage;
  int? menuId;
  String? branch;

  FetchStockOutwardListDataPayload(
      {this.fromDate,
      this.toDate,
      this.item,
      this.metal,
      this.designer,
      this.page,
      this.itemsPerPage,
      this.menuId,
      this.branch});

  FetchStockOutwardListDataPayload.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    toDate = json['to_date'];
    item = json['item'];
    metal = json['metal'];
    designer = json['designer'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['item'] = this.item;
    data['metal'] = this.metal;
    data['designer'] = this.designer;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    return data;
  }
}



class StockOutwardListData {
  String? tag;
  String? item;
  int? pieces;
  double? grossWeight;
  String? sNo;

  StockOutwardListData(
      {this.tag, this.item, this.pieces, this.grossWeight, this.sNo});

  StockOutwardListData.fromJson(Map<String, dynamic> json) {
    tag = json['tag'];
    item = json['item'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    sNo = json['s_no'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag'] = this.tag;
    data['item'] = this.item;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['s_no'] = this.sNo;
    return data;
  }
}
