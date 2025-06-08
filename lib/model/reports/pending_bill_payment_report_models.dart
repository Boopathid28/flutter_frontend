class PendingBillPaymentReportPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? search;
  String? customer;
  int? page;
  int? itemsPerPage;
  String? branch;

  PendingBillPaymentReportPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.search,
      this.customer,
      this.page,
      this.itemsPerPage,
      this.branch});

  PendingBillPaymentReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    search = json['search'];
    customer = json['customer'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['search'] = this.search;
    data['customer'] = this.customer;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}

class PendingBillPaymentReportListData {
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
  String? customerName;
  double? paidAmount;
  double? remainingAmount;
  int? sNo;

  PendingBillPaymentReportListData(
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
      this.customerName,
      this.paidAmount,
      this.remainingAmount,
      this.sNo});

  PendingBillPaymentReportListData.fromJson(Map<String, dynamic> json) {
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
    customerName = json['customer_name'];
    paidAmount = double.parse(json['paid_amount'].toString());
    remainingAmount = json['remaining_amount'];
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
    data['customer_name'] = this.customerName;
    data['paid_amount'] = this.paidAmount;
    data['remaining_amount'] = this.remainingAmount;
    data['s_no'] = this.sNo;
    return data;
  }
}
