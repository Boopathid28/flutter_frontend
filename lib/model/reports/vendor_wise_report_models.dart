class VendorWiseReport {
  String? vendorName;
  num? totalPieces;
  num? totalGrossWeight;
  num? totalAmount;
  num? sNo;

  VendorWiseReport(
      {this.vendorName,
      this.totalPieces,
      this.totalGrossWeight,
      this.totalAmount,
      this.sNo});

  VendorWiseReport.fromJson(Map<String, dynamic> json) {
    vendorName = json['vendor_name'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'];
    totalAmount = json['total_amount'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vendor_name'] = vendorName;
    data['total_pieces'] = totalPieces;
    data['total_gross_weight'] = totalGrossWeight;
    data['total_amount'] = totalAmount;
    data['s_no'] = sNo;
    return data;
  }
}





class VendorWiseReportPayload {
  String? menuId;
  String? vendor;
  String? branch;
  dynamic fromDate;
  dynamic toDate;
  String? subItem;
  String? item;
  String? purity;
  String? metal;
  num? page;
  num? itemsPerPage;

  VendorWiseReportPayload(
      {this.menuId,
      this.vendor,
      this.branch,
      this.fromDate,
      this.toDate,
      this.subItem,
      this.item,
      this.purity,
      this.metal,
      this.page,
      this.itemsPerPage});

  VendorWiseReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    vendor = json['vendor'];
    branch = json['branch'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    subItem = json['sub_item'];
    item = json['item'];
    purity = json['purity'];
    metal = json['metal'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['vendor'] = vendor;
    data['branch'] = branch;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['sub_item'] = subItem;
    data['item'] = item;
    data['purity'] = purity;
    data['metal'] = metal;
    data['page'] = page;
    data['items_per_page'] = itemsPerPage;
    return data;
  }
}
