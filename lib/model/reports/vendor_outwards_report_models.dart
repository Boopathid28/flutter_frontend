class FetchVendorOutwardReportListDataPayload {
  String? fromDate;
  int? page;
  int? itemsPerPage;
  int? menuId;

  FetchVendorOutwardReportListDataPayload(
      {this.fromDate, this.page, this.itemsPerPage, this.menuId});

  FetchVendorOutwardReportListDataPayload.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    return data;
  }
}


class VendorOutwardReportListData {
  String? vendorCode;
  String? vendorName;
  String? pieces;
  String? grossWeight;
  String? sNo;

  VendorOutwardReportListData(
      {this.vendorCode,
      this.vendorName,
      this.pieces,
      this.grossWeight,
      this.sNo});

  VendorOutwardReportListData.fromJson(Map<String, dynamic> json) {
    vendorCode = json['vendor_code'];
    vendorName = json['vendor_name'];
    pieces = json['pieces'].toString();
    grossWeight = json['gross_weight'].toString();
    sNo = json['s_no'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_code'] = this.vendorCode;
    data['vendor_name'] = this.vendorName;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['s_no'] = this.sNo;
    return data;
  }
}
