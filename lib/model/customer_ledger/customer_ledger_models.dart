class FetchCustomerLedgerListPayload {
  int? menuId;
  String? branch;
  String? customerDetails;
  String? fromDate;
  String? toDate;
  String? entryType;
  String? transactionType;
  bool? cancelStatus;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchCustomerLedgerListPayload(
      {this.menuId,
      this.branch,
      this.customerDetails,
      this.fromDate,
      this.toDate,
      this.entryType,
      this.transactionType,
      this.cancelStatus,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchCustomerLedgerListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    customerDetails = json['customer_details'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    entryType = json['entry_type'];
    transactionType = json['transaction_type'];
    cancelStatus = json['cancel_status'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['customer_details'] = this.customerDetails;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['entry_type'] = this.entryType;
    data['transaction_type'] = this.transactionType;
    data['cancel_status'] = this.cancelStatus;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}



class CustomerLedgerListData {
  int? id;
  String? entryDate;
  String? entryType;
  String? transactionType;
  String? invoiceNumber;
  String? reffrenceNumber;
  double? transactionAmount;
  double? transactionWeight;
  bool? isCancelled;
  String? branchName;
  int? customerDetails;
  int? branch;
  String? customerDetailsName;
  int? sNo;

  CustomerLedgerListData(
      {this.id,
      this.entryDate,
      this.entryType,
      this.transactionType,
      this.invoiceNumber,
      this.reffrenceNumber,
      this.transactionAmount,
      this.transactionWeight,
      this.isCancelled,
      this.branchName,
      this.customerDetails,
      this.branch,
      this.customerDetailsName,
      this.sNo});

  CustomerLedgerListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryDate = json['entry_date'];
    entryType = json['entry_type'];
    transactionType = json['transaction_type'];
    invoiceNumber = json['invoice_number'];
    reffrenceNumber = json['reffrence_number'];
    transactionAmount = json['transaction_amount'];
    transactionWeight = json['transaction_weight'];
    isCancelled = json['is_cancelled'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    customerDetailsName = json['customer_details_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entry_date'] = this.entryDate;
    data['entry_type'] = this.entryType;
    data['transaction_type'] = this.transactionType;
    data['invoice_number'] = this.invoiceNumber;
    data['reffrence_number'] = this.reffrenceNumber;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_weight'] = this.transactionWeight;
    data['is_cancelled'] = this.isCancelled;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    data['customer_details_name'] = this.customerDetailsName;
    data['s_no'] = this.sNo;
    return data;
  }
}
