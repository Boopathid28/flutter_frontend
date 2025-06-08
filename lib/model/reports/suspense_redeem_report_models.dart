class FetchSuspenseRedeemReportListPayload {
  int? menuId;
  String? branch;
  String? fromDate;
  String? toDate;
  String? customer;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchSuspenseRedeemReportListPayload(
      {this.menuId,
      this.branch,
      this.fromDate,
      this.toDate,
      this.customer,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchSuspenseRedeemReportListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    customer = json['customer'];
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
    data['customer'] = this.customer;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}




class SuspenseRedeemReportListData {
  int? id;
  int? paymentDetails;
  int? suspenseDetails;
  String? customerDetailsName;
  String? transactionDate;
  String? suspenseId;
  String? billId;
  double? totalAmount;
  int? sNo;

  SuspenseRedeemReportListData(
      {this.id,
      this.paymentDetails,
      this.suspenseDetails,
      this.customerDetailsName,
      this.transactionDate,
      this.suspenseId,
      this.billId,
      this.totalAmount,
      this.sNo});

  SuspenseRedeemReportListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentDetails = json['payment_details'];
    suspenseDetails = json['suspense_details'];
    customerDetailsName = json['customer_details_name'];
    transactionDate = json['transaction_date'];
    suspenseId = json['suspense_id'];
    billId = json['bill_id'];
    totalAmount = json['total_amount'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_details'] = this.paymentDetails;
    data['suspense_details'] = this.suspenseDetails;
    data['customer_details_name'] = this.customerDetailsName;
    data['transaction_date'] = this.transactionDate;
    data['suspense_id'] = this.suspenseId;
    data['bill_id'] = this.billId;
    data['total_amount'] = this.totalAmount;
    data['s_no'] = this.sNo;
    return data;
  }
}
