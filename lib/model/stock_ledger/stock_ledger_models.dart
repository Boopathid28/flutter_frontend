class FetchStockLedgerListPayload {
  int? menuId;
  String? stockType;
  String? metal;
  String? purity;
  String? item;
  String? subItem;
  String? vendor;
  String? fromDate;
  String? toDate;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchStockLedgerListPayload(
      {this.menuId,
      this.stockType,
      this.metal,
      this.purity,
      this.item,
      this.subItem,
      this.vendor,
      this.fromDate,
      this.toDate,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchStockLedgerListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    stockType = json['stock_type'];
    metal = json['metal'];
    purity = json['purity'];
    item = json['item'];
    subItem = json['sub_item'];
    vendor = json['vendor'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['stock_type'] = this.stockType;
    data['metal'] = this.metal;
    data['purity'] = this.purity;
    data['item'] = this.item;
    data['sub_item'] = this.subItem;
    data['vendor'] = this.vendor;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class StockLedgerListData {
  int? id;
  String? stockType;
  String? entryDate;
  int? pieces;
  double? grossWeight;
  int? tagDetails;
  String? tagNumber;
  String? metal;
  String? purity;
  String? item;
  String? subItem;
  String? vendor;
  int? sNo;

  StockLedgerListData(
      {this.id,
      this.stockType,
      this.entryDate,
      this.pieces,
      this.grossWeight,
      this.tagDetails,
      this.tagNumber,
      this.metal,
      this.purity,
      this.item,
      this.subItem,
      this.vendor,
      this.sNo});

  StockLedgerListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stockType = json['stock_type'];
    entryDate = json['entry_date'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    tagDetails = json['tag_details'];
    tagNumber = json['tag_number'];
    metal = json['metal'];
    purity = json['purity'];
    item = json['item'];
    subItem = json['sub_item'];
    vendor = json['vendor'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stock_type'] = this.stockType;
    data['entry_date'] = this.entryDate;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['tag_details'] = this.tagDetails;
    data['tag_number'] = this.tagNumber;
    data['metal'] = this.metal;
    data['purity'] = this.purity;
    data['item'] = this.item;
    data['sub_item'] = this.subItem;
    data['vendor'] = this.vendor;
    data['s_no'] = this.sNo;
    return data;
  }
}
