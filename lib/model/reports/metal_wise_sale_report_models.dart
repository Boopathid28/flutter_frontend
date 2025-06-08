class MetalWiseSaleReport {
  String? metalName;
  num? totalPieces;
  num? totalGrossWeight;
  num? totalAmount;
  num? sNo;

  MetalWiseSaleReport(
      {this.metalName,
      this.totalPieces,
      this.totalGrossWeight,
      this.totalAmount,
      this.sNo});

  MetalWiseSaleReport.fromJson(Map<String, dynamic> json) {
    metalName = json['metal_name'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'];
    totalAmount = json['total_amount'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['metal_name'] = metalName;
    data['total_pieces'] = totalPieces;
    data['total_gross_weight'] = totalGrossWeight;
    data['total_amount'] = totalAmount;
    data['s_no'] = sNo;
    return data;
  }
}





class MetalWiseSaleReportPayload {
  String? menuId;
  String? branch;
  dynamic fromDate;
  dynamic toDate;
  String? search;
  num? page;
  num? itemsPerPage;

  MetalWiseSaleReportPayload(
      {this.menuId,
      this.branch,
      this.fromDate,
      this.toDate,
      this.search,
      this.page,
      this.itemsPerPage});

  MetalWiseSaleReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['branch'] = branch;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['search'] = search;
    data['page'] = page;
    data['items_per_page'] = itemsPerPage;
    return data;
  }
}
