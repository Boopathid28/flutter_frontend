class VendorDiscountListData {
  int? id;
  String? discountId;
  String? discountDate;
  double? discountWeight;
  double? discountAmount;
  String? remark;
  bool? isCanceled;
  int? vendorDetails;
  String? vendorDetailsName;
  String? branch;
  String? branchName;
  int? sNo;

  VendorDiscountListData(
      {this.id,
      this.discountId,
      this.discountDate,
      this.discountWeight,
      this.discountAmount,
      this.remark,
      this.isCanceled,
      this.vendorDetails,
      this.vendorDetailsName,
      this.branch,
      this.branchName,
      this.sNo});

  VendorDiscountListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    discountId = json['discount_id'];
    discountDate = json['discount_date'];
    discountWeight = json['discount_weight'];
    discountAmount = json['discount_amount'];
    remark = json['remark'];
    isCanceled = json['is_canceled'];
    vendorDetails = json['vendor_details'];
    vendorDetailsName = json['vendor_details_name'];
    branch = json['branch'].toString();
    branchName = json['branch_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['discount_id'] = this.discountId;
    data['discount_date'] = this.discountDate;
    data['discount_weight'] = this.discountWeight;
    data['discount_amount'] = this.discountAmount;
    data['remark'] = this.remark;
    data['branch'] = this.branch;
    data['branch_name'] = this.branchName;
    data['is_canceled'] = this.isCanceled;
    data['vendor_details'] = this.vendorDetails;
    data['vendor_details_name'] = this.vendorDetailsName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class FetchVendorDiscountListPayload {
  int? menuId;
  String? vendor;
  String? fromDate;
  String? toDate;
  String? search;
  int? page;
  int? itemsPerPage;
  bool? status;
  String? branch;

  FetchVendorDiscountListPayload(
      {this.menuId,
      this.vendor,
      this.fromDate,
      this.toDate,
      this.search,
      this.page,
      this.itemsPerPage,
      this.status,
      this.branch});

  FetchVendorDiscountListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    vendor = json['vendor'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    status = json['status'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['vendor'] = this.vendor;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['status'] = this.status;
    data['branch'] = this.branch;
    return data;
  }
}

class CreateVendorDiscountPayload {
  int? menuId;
  String? vendorDetails;
  double? discountWeight;
  double? discountAmount;
  String? remark;
  String? branch;

  CreateVendorDiscountPayload(
      {this.menuId,
      this.vendorDetails,
      this.discountWeight,
      this.discountAmount,
      this.remark,
      this.branch});

  CreateVendorDiscountPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    vendorDetails = json['vendor_details'];
    discountWeight = json['discount_weight'];
    discountAmount = json['discount_amount'];
    remark = json['remark'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['vendor_details'] = this.vendorDetails;
    data['discount_weight'] = this.discountWeight;
    data['discount_amount'] = this.discountAmount;
    data['remark'] = this.remark;
    data['branch'] = this.branch;
    return data;
  }
}
