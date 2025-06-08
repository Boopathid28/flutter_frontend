class SuspensePendingReportPayload {
  int? menuId;
  String? branch;
  String? fromDate;
  String? toDate;
  String? customer;
  int? page;
  int? itemsPerPage;

  SuspensePendingReportPayload(
      {this.menuId,
      this.branch,
      this.fromDate,
      this.toDate,
      this.customer,
      this.page,
      this.itemsPerPage});

  SuspensePendingReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    customer = json['customer'];
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
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class SuspensePendingReportListData {
  int? id;
  String? suspenseId;
  bool? isRedeemed;
  String? billNumber;
  bool? isCancelled;
  String? dueDate;
  bool? isClosed;
  String? closedBy;
  String? closedDate;
  String? remark;
  String? createdAt;
  String? createdBy;
  int? customerDetails;
  String? customerDetailsName;
  double? totalSuspenseAmount;
  double? totalPayment;
  int? sNo;

  SuspensePendingReportListData(
      {this.id,
      this.suspenseId,
      this.isRedeemed,
      this.billNumber,
      this.isCancelled,
      this.dueDate,
      this.isClosed,
      this.closedBy,
      this.closedDate,
      this.remark,
      this.createdAt,
      this.createdBy,
      this.customerDetails,
      this.customerDetailsName,
      this.totalSuspenseAmount,
      this.totalPayment,
      this.sNo});

  SuspensePendingReportListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suspenseId = json['suspense_id'];
    isRedeemed = json['is_redeemed'];
    billNumber = json['bill_number'];
    isCancelled = json['is_cancelled'];
    dueDate = json['due_date'];
    isClosed = json['is_closed'];
    closedBy = json['closed_by'];
    closedDate = json['closed_date'];
    remark = json['remark'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    customerDetails = json['customer_details'];
    customerDetailsName = json['customer_details_name'];
    totalSuspenseAmount = json['total_suspense_amount'];
    totalPayment = json['total_payment'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['suspense_id'] = this.suspenseId;
    data['is_redeemed'] = this.isRedeemed;
    data['bill_number'] = this.billNumber;
    data['is_cancelled'] = this.isCancelled;
    data['due_date'] = this.dueDate;
    data['is_closed'] = this.isClosed;
    data['closed_by'] = this.closedBy;
    data['closed_date'] = this.closedDate;
    data['remark'] = this.remark;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['customer_details'] = this.customerDetails;
    data['customer_details_name'] = this.customerDetailsName;
    data['total_suspense_amount'] = this.totalSuspenseAmount;
    data['total_payment'] = this.totalPayment;
    data['s_no'] = this.sNo;
    return data;
  }
}
