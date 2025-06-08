class FetchOverallDailyReportPayload {
  int? menuId;
  String? fromDate;
  int? page;
  int? itemsPerPage;
  String? metal;
  String? paymentProvider;
  String? paymentMethod;

  FetchOverallDailyReportPayload(
      {this.menuId,
      this.fromDate,
      this.page,
      this.itemsPerPage,
      this.metal,
      this.paymentProvider,
      this.paymentMethod});

  FetchOverallDailyReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    metal = json['metal'];
    paymentProvider = json['payment_provider'];
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['metal'] = this.metal;
    data['payment_provider'] = this.paymentProvider;
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}


class OverallDailyReportResponse {
  int? pieces;
  String? grossWeight;
  String? totalAmount;
  String? paidAmount;
  String? balance;
  String? referenceId;
  String? type;
  String? totalInPayment;
  String? totalOutPayment;

  OverallDailyReportResponse(
      {this.pieces,
      this.grossWeight,
      this.totalAmount,
      this.paidAmount,
      this.balance,
      this.referenceId,
      this.type,
      this.totalInPayment,
      this.totalOutPayment});

  OverallDailyReportResponse.fromJson(Map<String, dynamic> json) {
    pieces = json['pieces'];
    grossWeight = json['gross_weight'].toString();
    totalAmount = json['total_amount'].toString();
    paidAmount = json['paid_amount'].toString();
    balance = json['balance'].toString();
    referenceId = json['reference_id'];
    type = json['type'];
    totalInPayment = json['total_in_payment'].toString();
    totalOutPayment = json['total_out_payment'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['total_amount'] = this.totalAmount;
    data['paid_amount'] = this.paidAmount;
    data['balance'] = this.balance;
    data['reference_id'] = this.referenceId;
    data['type'] = this.type;
    data['total_in_payment'] = this.totalInPayment;
    data['total_out_payment'] = this.totalOutPayment;
    return data;
  }
}
