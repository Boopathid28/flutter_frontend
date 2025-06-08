class FetchCustomerSummaryListPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  int? page;
  int? itemsPerPage;
  String? customer;

  FetchCustomerSummaryListPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.page,
      this.itemsPerPage,
      this.customer});

  FetchCustomerSummaryListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['customer'] = this.customer;
    return data;
  }
}



class CustomerSummaryListData {
  String? totalAmount;
  String? paidAmount;
  String? balanceAmount;
  String? referenceId;
  String? type;
  String? createdAt;
  String? customer;

  CustomerSummaryListData(
      {this.totalAmount,
      this.paidAmount,
      this.balanceAmount,
      this.referenceId,
      this.type,
      this.createdAt,
      this.customer});

  CustomerSummaryListData.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'].toString();
    paidAmount = json['paid_amount'].toString();
    balanceAmount = json['balance'].toString();
    referenceId = json['reference_id'].toString();
    type = json['type'];
    createdAt = json['created_at'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount'] = this.totalAmount;
    data['paid_amount'] = this.paidAmount;
    data['balance'] = this.balanceAmount;
    data['reference_id'] = this.referenceId;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['customer'] = this.customer;
    return data;
  }
}
