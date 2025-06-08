class VendorItemWiseSalesReport {
  String? itemName;
  num? totalPieces;
  num? totalGrossWeight;
  num? totalAmount;
  num? sNo;

  VendorItemWiseSalesReport(
      {this.itemName,
      this.totalPieces,
      this.totalGrossWeight,
      this.totalAmount,
      this.sNo});

  VendorItemWiseSalesReport.fromJson(Map<String, dynamic> json) {
    itemName = json['item_name'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'];
    totalAmount = json['total_amount'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_name'] = itemName;
    data['total_pieces'] = totalPieces;
    data['total_gross_weight'] = totalGrossWeight;
    data['total_amount'] = totalAmount;
    data['s_no'] = sNo;
    return data;
  }
}




class VendorItemWiseSalesReportPayload {
  String? menuId;
  String? search;
  String? branch;
  String? vendor;
  dynamic fromDate;
  dynamic toDate;
  num? page;
  num? itemsPerPage;

  VendorItemWiseSalesReportPayload(
      {this.menuId,
      this.search,
      this.branch,
      this.vendor,
      this.fromDate,
      this.toDate,
      this.page,
      this.itemsPerPage});

  VendorItemWiseSalesReportPayload.fromJson(Map<String, dynamic> json) {
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
