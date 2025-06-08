class BillingGstReportListData {
  int? id;
  String? billId;
  String? billDate;
  double? totalAmount;
  String? gstType;
  double? gstAmount;
  double? discountAmount;
  double? roundoffAmount;
  double? payableAmount;
  String? createdAt;
  String? createdBy;
  int? customerDetails;
  String? customerDetailsName;
  int? sNo;

  BillingGstReportListData(
      {this.id,
      this.billId,
      this.billDate,
      this.totalAmount,
      this.gstType,
      this.gstAmount,
      this.discountAmount,
      this.roundoffAmount,
      this.payableAmount,
      this.createdAt,
      this.createdBy,
      this.customerDetails,
      this.customerDetailsName,
      this.sNo});

  BillingGstReportListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billId = json['bill_id'];
    billDate = json['bill_date'];
    totalAmount = json['total_amount'];
    gstType = json['gst_type'];
    gstAmount = json['gst_amount'];
    discountAmount = json['discount_amount'];
    roundoffAmount = json['roundoff_amount'];
    payableAmount = json['payable_amount'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    customerDetails = json['customer_details'];
    customerDetailsName = json['customer_details_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_id'] = this.billId;
    data['bill_date'] = this.billDate;
    data['total_amount'] = this.totalAmount;
    data['gst_type'] = this.gstType;
    data['gst_amount'] = this.gstAmount;
    data['discount_amount'] = this.discountAmount;
    data['roundoff_amount'] = this.roundoffAmount;
    data['payable_amount'] = this.payableAmount;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['customer_details'] = this.customerDetails;
    data['customer_details_name'] = this.customerDetailsName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class BillingGstReportPayload {
  int? menuId;
  String? branch;
  String? fromDate;
  String? toDate;
  String? gstType;
  String? customerDetails;
  String? search;
  int? page;
  int? itemsPerPage;

  BillingGstReportPayload(
      {this.menuId,
      this.branch,
      this.fromDate,
      this.toDate,
      this.gstType,
      this.customerDetails,
      this.search,
      this.page,
      this.itemsPerPage});

  BillingGstReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    gstType = json['gst_type'];
    customerDetails = json['customer_details'];
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
    data['gst_type'] = this.gstType;
    data['customer_details'] = this.customerDetails;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}
