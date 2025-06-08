class FetchBillingCRDRListPayload {
  String? fromDate;
  int? menuId;
  String? customer;
  String? issueStatus;
  int? itemsPerPage;
  int? page;

  FetchBillingCRDRListPayload(
      {this.fromDate,
      this.menuId,
      this.customer,
      this.issueStatus,
      this.itemsPerPage,
      this.page});

  FetchBillingCRDRListPayload.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    menuId = json['menu_id'];
    customer = json['customer'];
    issueStatus = json['issue_status'];
    itemsPerPage = json['items_per_page'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['menu_id'] = this.menuId;
    data['customer'] = this.customer;
    data['issue_status'] = this.issueStatus;
    data['items_per_page'] = this.itemsPerPage;
    data['page'] = this.page;
    return data;
  }
}



class BillingCRDRListData {
  int? id;
  String? billId;
  String? billDate;
  String? totalAmount;
  String? gstType;
  String? gstAmount;
  String? discountAmount;
  String? roundoffAmount;
  String? payableAmount;
  bool? isIssued;
  String? createdAt;
  String? createdBy;
  int? metal;
  int? customerDetails;
  String? customer;
  String? mobile;
  String? salesDate;
  String? dr;
  String? cr;

  BillingCRDRListData(
      {this.id,
      this.billId,
      this.billDate,
      this.totalAmount,
      this.gstType,
      this.gstAmount,
      this.discountAmount,
      this.roundoffAmount,
      this.payableAmount,
      this.isIssued,
      this.createdAt,
      this.createdBy,
      this.metal,
      this.customerDetails,
      this.customer,
      this.mobile,
      this.salesDate,
      this.dr,
      this.cr});

  BillingCRDRListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billId = json['bill_id'];
    billDate = json['bill_date'];
    totalAmount = json['total_amount'].toString();
    gstType = json['gst_type'];
    gstAmount = json['gst_amount'].toString();
    discountAmount = json['discount_amount'].toString();
    roundoffAmount = json['roundoff_amount'].toString();
    payableAmount = json['payable_amount'].toString();
    isIssued = json['is_issued'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    metal = json['metal'];
    customerDetails = json['customer_details'];
    customer = json['customer'];
    mobile = json['mobile'];
    salesDate = json['sales_date'];
    dr = json['dr'].toString();
    cr = json['cr'].toString();
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
    data['is_issued'] = this.isIssued;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['metal'] = this.metal;
    data['customer_details'] = this.customerDetails;
    data['customer'] = this.customer;
    data['mobile'] = this.mobile;
    data['sales_date'] = this.salesDate;
    data['dr'] = this.dr;
    data['cr'] = this.cr;
    return data;
  }
}
