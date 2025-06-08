class FetchTdsDeductionReportListPayload {
  int? menuId;
  String? branch;
  String? fromDate;
  String? toDate;
  String? vendor;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchTdsDeductionReportListPayload(
      {this.menuId,
      this.branch,
      this.fromDate,
      this.toDate,
      this.vendor,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchTdsDeductionReportListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    vendor = json['vendor'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['vendor'] = this.vendor;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}



class TdsDeductionReportListData {
  String? vendorName;
  double? tdsPercent;
  double? tdsAmount;
  String? poId;
  String? poDate;
  double? payableAmount;
  int? sNo;

  TdsDeductionReportListData(
      {this.vendorName,
      this.tdsPercent,
      this.tdsAmount,
      this.poId,
      this.poDate,
      this.payableAmount,
      this.sNo});

  TdsDeductionReportListData.fromJson(Map<String, dynamic> json) {
    vendorName = json['vendor_name'];
    tdsPercent = json['tds_percent'];
    tdsAmount = json['tds_amount'];
    poId = json['po_id'];
    poDate = json['po_date'];
    payableAmount = json['payable_amount'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_name'] = this.vendorName;
    data['tds_percent'] = this.tdsPercent;
    data['tds_amount'] = this.tdsAmount;
    data['po_id'] = this.poId;
    data['po_date'] = this.poDate;
    data['payable_amount'] = this.payableAmount;
    data['s_no'] = this.sNo;
    return data;
  }
}
