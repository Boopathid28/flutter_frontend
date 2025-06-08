class FetchVendorLedgerListPayload {
  int? menuId;
  String? vendor;
  String? search;
  int? page;
  int? itemsPerPage;
  bool? status;
  String? transactionType;
  String? branch;

  FetchVendorLedgerListPayload(
      {this.menuId,
      this.vendor,
      this.search,
      this.page,
      this.itemsPerPage,
      this.status,
      this.branch,
      this.transactionType});

  FetchVendorLedgerListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    vendor = json['vendor'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    status = json['status'];
    transactionType = json['transaction_type'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['vendor'] = this.vendor;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['status'] = this.status;
    data['transaction_type'] = this.transactionType;
    data['branch'] = this.branch;
    return data;
  }
}




class VendorLedgerListData {
  int? id;
  String? transactionDate;
  String? refferenceNumber;
  String? transactionType;
  double? transactionWeight;
  double? transactionAmount;
  bool? isCanceled;
  int? vendorDetails;
  String? branch;
  String? branchName;
  String? vendorDetailsName;
  int? sNo;

  VendorLedgerListData(
      {this.id,
      this.transactionDate,
      this.refferenceNumber,
      this.transactionType,
      this.transactionWeight,
      this.transactionAmount,
      this.isCanceled,
      this.vendorDetails,
      this.branch,
      this.branchName,
      this.vendorDetailsName,
      this.sNo});

  VendorLedgerListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionDate = json['transaction_date'];
    refferenceNumber = json['refference_number'];
    transactionType = json['transaction_type'];
    transactionWeight = json['transaction_weight'];
    transactionAmount = json['transaction_amount'];
    isCanceled = json['is_canceled'];
    vendorDetails = json['vendor_details'];
    vendorDetailsName = json['vendor_details_name'];
    sNo = json['s_no'];
    branch = json['branch'].toString();
    branchName = json['branch_name'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_date'] = this.transactionDate;
    data['refference_number'] = this.refferenceNumber;
    data['transaction_type'] = this.transactionType;
    data['transaction_weight'] = this.transactionWeight;
    data['transaction_amount'] = this.transactionAmount;
    data['is_canceled'] = this.isCanceled;
    data['vendor_details'] = this.vendorDetails;
    data['vendor_details_name'] = this.vendorDetailsName;
    data['s_no'] = this.sNo;
    data['branch'] = this.branch;
    data['branch_name'] = this.branchName;
    return data;
  }
}
