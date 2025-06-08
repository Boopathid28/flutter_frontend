class FetchCashPurchaseReportListPayload {
  String? fromDate;
  String? toDate;
  int? page;
  int? itemsPerPage;
  int? menuId;

  FetchCashPurchaseReportListPayload(
      {this.fromDate, this.toDate, this.page, this.itemsPerPage, this.menuId});

  FetchCashPurchaseReportListPayload.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    toDate = json['to_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    return data;
  }
}

class CashPurchaseReportListData {
  String? bill;
  String? customer;
  String? date;
  String? metal;
  String? item;
  double? metalRate;
  double? grossWeight;
  double? dustWeight;
  double? netWeight;
  double? amount;
  int? sNo;

  CashPurchaseReportListData(
      {this.bill,
      this.customer,
      this.date,
      this.metal,
      this.item,
      this.metalRate,
      this.grossWeight,
      this.dustWeight,
      this.netWeight,
      this.amount,
      this.sNo});

  CashPurchaseReportListData.fromJson(Map<String, dynamic> json) {
    bill = json['bill'];
    customer = json['customer'];
    date = json['date'];
    metal = json['metal'];
    item = json['item'];
    metalRate = json['metal_rate'];
    grossWeight = json['gross_weight'];
    dustWeight = json['dust_weight'];
    netWeight = json['net_weight'];
    amount = json['amount'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bill'] = this.bill;
    data['customer'] = this.customer;
    data['date'] = this.date;
    data['metal'] = this.metal;
    data['item'] = this.item;
    data['metal_rate'] = this.metalRate;
    data['gross_weight'] = this.grossWeight;
    data['dust_weight'] = this.dustWeight;
    data['net_weight'] = this.netWeight;
    data['amount'] = this.amount;
    data['s_no'] = this.sNo;
    return data;
  }
}

class CashPurchaseReportOverview {
  double? totalGrossWeight;
  double? totalDustWeight;
  double? totalNetWeight;
  double? totalAmount;

  CashPurchaseReportOverview(
      {this.totalGrossWeight,
      this.totalDustWeight,
      this.totalNetWeight,
      this.totalAmount});

  CashPurchaseReportOverview.fromJson(Map<String, dynamic> json) {
    totalGrossWeight = json['total_gross_weight'];
    totalDustWeight = json['total_dust_weight'];
    totalNetWeight = json['total_net_weight'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_gross_weight'] = this.totalGrossWeight;
    data['total_dust_weight'] = this.totalDustWeight;
    data['total_net_weight'] = this.totalNetWeight;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
