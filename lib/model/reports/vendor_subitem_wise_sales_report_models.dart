class VendorSubitemWiseSalesReport {
  String? subItemName;
  num? totalPieces;
  num? totalGrossWeight;
  num? totalAmount;
  num? sNo;

  VendorSubitemWiseSalesReport(
      {this.subItemName,
      this.totalPieces,
      this.totalGrossWeight,
      this.totalAmount,
      this.sNo});

  VendorSubitemWiseSalesReport.fromJson(Map<String, dynamic> json) {
    subItemName = json['sub_item_name'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'];
    totalAmount = json['total_amount'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sub_item_name'] = subItemName;
    data['total_pieces'] = totalPieces;
    data['total_gross_weight'] = totalGrossWeight;
    data['total_amount'] = totalAmount;
    data['s_no'] = sNo;
    return data;
  }
}




class VendorSubitemWiseSalesReportPayload {
  String? menuId;
  String? search;
  String? branch;
  String? vendor;
  dynamic fromDate;
  dynamic toDate;
  num? page;
  num? itemsPerPage;

  VendorSubitemWiseSalesReportPayload(
      {this.menuId,
      this.search,
      this.branch,
      this.vendor,
      this.fromDate,
      this.toDate,
      this.page,
      this.itemsPerPage});

  VendorSubitemWiseSalesReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    search = json['search'];
    branch = json['branch'];
    vendor = json['vendor'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['search'] = search;
    data['branch'] = branch;
    data['vendor'] = vendor;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['page'] = page;
    data['items_per_page'] = itemsPerPage;
    return data;
  }
}
