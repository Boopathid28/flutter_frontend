class FetchVendorInwardReportListDataPayload {
  String? fromDate;
  int? page;
  int? itemsPerPage;
  String? item;
  String? vendor;
  int? menuId;

  FetchVendorInwardReportListDataPayload(
      {this.fromDate, this.page, this.itemsPerPage, this.menuId , this.item, this.vendor});

  FetchVendorInwardReportListDataPayload.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
    item = json['item'];
    vendor = json['designer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    data['item'] = this.item;
    data['designer'] = this.vendor;
    return data;
  }
}

class VendorInwardReportListData {
  String? vendorCode;
  String? vendorName;
  String? pieces;
  String? grossWeight;

  VendorInwardReportListData(
      {this.vendorCode, this.vendorName, this.pieces, this.grossWeight});

  VendorInwardReportListData.fromJson(Map<String, dynamic> json) {
    vendorCode = json['vendor_code'];
    vendorName = json['vendor_name'];
    pieces = json['pieces'].toString();
    grossWeight = json['gross_weight'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_code'] = this.vendorCode;
    data['vendor_name'] = this.vendorName;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    return data;
  }
}
