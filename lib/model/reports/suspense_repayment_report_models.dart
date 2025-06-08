class FetchSuspenseRepaymentReportListPaylaod {
  int? menuId;
  String? branch;
  String? fromDate;
  String? toDate;
  String? customer;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchSuspenseRepaymentReportListPaylaod(
      {this.menuId,
      this.branch,
      this.fromDate,
      this.toDate,
      this.customer,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchSuspenseRepaymentReportListPaylaod.fromJson(Map<String, dynamic> json) {
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




class SuspenseRepaymentReportListData {
  int? id;
  String? paymentId;
  String? paymentDate;
  String? createdBy;
  int? suspenseDetails;
  String? customerDetailsName;
  String? suspenseId;
  double? paidAmount;
  List<Denomination>? denomination;
  int? sNo;

  SuspenseRepaymentReportListData(
      {this.id,
      this.paymentId,
      this.paymentDate,
      this.createdBy,
      this.suspenseDetails,
      this.customerDetailsName,
      this.suspenseId,
      this.paidAmount,
      this.denomination,
      this.sNo});

  SuspenseRepaymentReportListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    paymentDate = json['payment_date'];
    createdBy = json['created_by'];
    suspenseDetails = json['suspense_details'];
    customerDetailsName = json['customer_details_name'];
    suspenseId = json['suspense_id'];
    paidAmount = json['paid_amount'];
    if (json['denomination'] != null) {
      denomination = <Denomination>[];
      json['denomination'].forEach((v) {
        denomination!.add(new Denomination.fromJson(v));
      });
    }
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['payment_date'] = this.paymentDate;
    data['created_by'] = this.createdBy;
    data['suspense_details'] = this.suspenseDetails;
    data['customer_details_name'] = this.customerDetailsName;
    data['suspense_id'] = this.suspenseId;
    data['paid_amount'] = this.paidAmount;
    if (this.denomination != null) {
      data['denomination'] = this.denomination!.map((v) => v.toJson()).toList();
    }
    data['s_no'] = this.sNo;
    return data;
  }
}

class Denomination {
  int? id;
  String? paymentMethod;
  String? paymentProvider;
  double? paidAmount;
  String? remark;
  int? paymentDetails;

  Denomination(
      {this.id,
      this.paymentMethod,
      this.paymentProvider,
      this.paidAmount,
      this.remark,
      this.paymentDetails});

  Denomination.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['payment_method'];
    paymentProvider = json['payment_provider'];
    paidAmount = json['paid_amount'];
    remark = json['remark'];
    paymentDetails = json['payment_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    data['payment_provider'] = this.paymentProvider;
    data['paid_amount'] = this.paidAmount;
    data['remark'] = this.remark;
    data['payment_details'] = this.paymentDetails;
    return data;
  }
}
