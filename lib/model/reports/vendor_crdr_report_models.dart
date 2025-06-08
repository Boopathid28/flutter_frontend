class FetchVendorCRDRReportListPayload {
  String? fromDate;
  int? page;
  int? itemsPerPage;
  int? menuId;

  FetchVendorCRDRReportListPayload(
      {this.fromDate, this.page, this.itemsPerPage, this.menuId});

  FetchVendorCRDRReportListPayload.fromJson(Map<String, dynamic> json) {
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

class VendorCRDRReportListData {
  String? code;
  String? name;
  String? amountCr;
  String? amountDr;
  String? weightCr;
  String? weightDr;
  int? sNo;

  VendorCRDRReportListData(
      {this.code,
      this.name,
      this.amountCr,
      this.amountDr,
      this.weightCr,
      this.weightDr,
      this.sNo});

  VendorCRDRReportListData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
    amountCr = json['amount_cr'].toString();
    amountDr = json['amount_dr'].toString();
    weightCr = json['weight_cr'].toString();
    weightDr = json['weight_dr'].toString();
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    data['amount_cr'] = this.amountCr;
    data['amount_dr'] = this.amountDr;
    data['weight_cr'] = this.weightCr;
    data['weight_dr'] = this.weightDr;
    data['s_no'] = this.sNo;
    return data;
  }
}

class VendorCRDRReportOverview {
  double? totalAmountCr;
  double? totalAmountDr;
  double? totalWeightCr;
  double? totalWeightDr;

  VendorCRDRReportOverview(
      {this.totalAmountCr,
      this.totalAmountDr,
      this.totalWeightCr,
      this.totalWeightDr});

  VendorCRDRReportOverview.fromJson(Map<String, dynamic> json) {
    totalAmountCr = json['total_amount_cr'];
    totalAmountDr = json['total_amount_dr'];
    totalWeightCr = json['total_weight_cr'];
    totalWeightDr = json['total_weight_dr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount_cr'] = this.totalAmountCr;
    data['total_amount_dr'] = this.totalAmountDr;
    data['total_weight_cr'] = this.totalWeightCr;
    data['total_weight_dr'] = this.totalWeightDr;
    return data;
  }
}
