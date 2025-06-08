class FetchManualEstimationBillingReportListDataPayload {
  String? fromDate;
  String? toDate;
  String? search;
  int? menuId;
  String? branch;
  int? itemsPerPage;
  int? page;

  FetchManualEstimationBillingReportListDataPayload(
      {this.fromDate,
      this.toDate,
      this.search,
      this.menuId,
      this.branch,
      this.itemsPerPage,
      this.page});

  FetchManualEstimationBillingReportListDataPayload.fromJson(
      Map<String, dynamic> json) {
    fromDate = json['from_date'];
    toDate = json['to_date'];
    search = json['search'];
    menuId = json['menu_id'];
    branch = json['branch'];
    itemsPerPage = json['items_per_page'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['search'] = this.search;
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['items_per_page'] = this.itemsPerPage;
    data['page'] = this.page;
    return data;
  }
}







class ManualEstimationBillingReportListData {
  int? id;
  String? manualEstimationId;
  String? manualEstimationDate;
  double? totalAmount;
  String? gstType;
  double? gstAmount;
  double? advanceAmount;
  double? discountAmount;
  double? exchangeAmount;
  double? chitAmount;
  double? saleReturnAmount;
  double? roundoffAmount;
  double? payableAmount;
  double? balanceAmount;
  bool? isBilled;
  String? billNumber;
  String? billAt;
  String? createdAt;
  String? createdBy;
  int? metal;
  int? customerDetails;
  String? customerDetailsName;
  String? metalName;
  double? grossWeight;
  int? pieces;
  double? oldPurchaseAmount;
  int? sNo;

  ManualEstimationBillingReportListData(
      {this.id,
      this.manualEstimationId,
      this.manualEstimationDate,
      this.totalAmount,
      this.gstType,
      this.gstAmount,
      this.advanceAmount,
      this.discountAmount,
      this.exchangeAmount,
      this.chitAmount,
      this.saleReturnAmount,
      this.roundoffAmount,
      this.payableAmount,
      this.balanceAmount,
      this.isBilled,
      this.billNumber,
      this.billAt,
      this.createdAt,
      this.createdBy,
      this.metal,
      this.customerDetails,
      this.customerDetailsName,
      this.metalName,
      this.grossWeight,
      this.pieces,
      this.oldPurchaseAmount,
      this.sNo});

  ManualEstimationBillingReportListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    manualEstimationId = json['manual_estimation_id'];
    manualEstimationDate = json['manual_estimation_date'];
    totalAmount = json['total_amount'];
    gstType = json['gst_type'];
    gstAmount = json['gst_amount'];
    advanceAmount = json['advance_amount'];
    discountAmount = json['discount_amount'];
    exchangeAmount = json['exchange_amount'];
    chitAmount = json['chit_amount'];
    saleReturnAmount = json['sale_return_amount'];
    roundoffAmount = json['roundoff_amount'];
    payableAmount = json['payable_amount'];
    balanceAmount = json['balance_amount'];
    isBilled = json['is_billed'];
    billNumber = json['bill_number'];
    billAt = json['bill_at'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    metal = json['metal'];
    customerDetails = json['customer_details'];
    customerDetailsName = json['customer_details_name'];
    metalName = json['metal_name'];
    grossWeight = json['gross_weight'];
    pieces = json['pieces'];
    oldPurchaseAmount = json['old_purchase_amount'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['manual_estimation_id'] = this.manualEstimationId;
    data['manual_estimation_date'] = this.manualEstimationDate;
    data['total_amount'] = this.totalAmount;
    data['gst_type'] = this.gstType;
    data['gst_amount'] = this.gstAmount;
    data['advance_amount'] = this.advanceAmount;
    data['discount_amount'] = this.discountAmount;
    data['exchange_amount'] = this.exchangeAmount;
    data['chit_amount'] = this.chitAmount;
    data['sale_return_amount'] = this.saleReturnAmount;
    data['roundoff_amount'] = this.roundoffAmount;
    data['payable_amount'] = this.payableAmount;
    data['balance_amount'] = this.balanceAmount;
    data['is_billed'] = this.isBilled;
    data['bill_number'] = this.billNumber;
    data['bill_at'] = this.billAt;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['metal'] = this.metal;
    data['customer_details'] = this.customerDetails;
    data['customer_details_name'] = this.customerDetailsName;
    data['metal_name'] = this.metalName;
    data['gross_weight'] = this.grossWeight;
    data['pieces'] = this.pieces;
    data['old_purchase_amount'] = this.oldPurchaseAmount;
    data['s_no'] = this.sNo;
    return data;
  }
}
