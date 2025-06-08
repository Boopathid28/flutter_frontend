class FetchMeltingReceiptPayload {
  int? menuId;
  String? vendor;
  String? branch;
  String? search;
  bool? receivedStatus;
  bool? cancelStatus;
  int? page;
  int? itemsPerPage;

  FetchMeltingReceiptPayload(
      {this.menuId,
      this.vendor,
      this.branch,
      this.search,
      this.receivedStatus,
      this.cancelStatus,
      this.page,
      this.itemsPerPage});

  FetchMeltingReceiptPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    vendor = json['vendor'];
    branch = json['branch'];
    search = json['search'];
    receivedStatus = json['received_status'];
    cancelStatus = json['cancel_status'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['vendor'] = this.vendor;
    data['branch'] = this.branch;
    data['search'] = this.search;
    data['received_status'] = this.receivedStatus;
    data['cancel_status'] = this.cancelStatus;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}




class MeltingReceiptListData {
  int? id;
  String? meltingId;
  String? issueDate;
  double? issuedWeight;
  String? issuedBy;
  String? dueDate;
  bool? isReceived;
  String? receivedDate;
  double? receivedWeight;
  String? receivedBy;
  double? meltingCarges;
  double? gstPercent;
  double? gstAmount;
  double? vendorCharges;
  String? remark;
  bool? isIssued;
  bool? isCancelled;
  String? branchName;
  int? bagDetails;
  int? vendorDetails;
  int? branch;
  String? bagNumber;
  String? vendorDetailsName;
  int? sNo;

  MeltingReceiptListData(
      {this.id,
      this.meltingId,
      this.issueDate,
      this.issuedWeight,
      this.issuedBy,
      this.dueDate,
      this.isReceived,
      this.receivedDate,
      this.receivedWeight,
      this.receivedBy,
      this.meltingCarges,
      this.gstPercent,
      this.gstAmount,
      this.vendorCharges,
      this.remark,
      this.isIssued,
      this.isCancelled,
      this.branchName,
      this.bagDetails,
      this.vendorDetails,
      this.branch,
      this.bagNumber,
      this.vendorDetailsName,
      this.sNo});

  MeltingReceiptListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meltingId = json['melting_id'];
    issueDate = json['issue_date'];
    issuedWeight = json['issued_weight'];
    issuedBy = json['issued_by'];
    dueDate = json['due_date'];
    isReceived = json['is_received'];
    receivedDate = json['received_date'];
    receivedWeight = json['received_weight'];
    receivedBy = json['received_by'];
    meltingCarges = json['melting_carges'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    vendorCharges = json['vendor_charges'];
    remark = json['remark'];
    isIssued = json['is_issued'];
    isCancelled = json['is_cancelled'];
    branchName = json['branch_name'];
    bagDetails = json['bag_details'];
    vendorDetails = json['vendor_details'];
    branch = json['branch'];
    bagNumber = json['bag_number'];
    vendorDetailsName = json['vendor_details_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['melting_id'] = this.meltingId;
    data['issue_date'] = this.issueDate;
    data['issued_weight'] = this.issuedWeight;
    data['issued_by'] = this.issuedBy;
    data['due_date'] = this.dueDate;
    data['is_received'] = this.isReceived;
    data['received_date'] = this.receivedDate;
    data['received_weight'] = this.receivedWeight;
    data['received_by'] = this.receivedBy;
    data['melting_carges'] = this.meltingCarges;
    data['gst_percent'] = this.gstPercent;
    data['gst_amount'] = this.gstAmount;
    data['vendor_charges'] = this.vendorCharges;
    data['remark'] = this.remark;
    data['is_issued'] = this.isIssued;
    data['is_cancelled'] = this.isCancelled;
    data['branch_name'] = this.branchName;
    data['bag_details'] = this.bagDetails;
    data['vendor_details'] = this.vendorDetails;
    data['branch'] = this.branch;
    data['bag_number'] = this.bagNumber;
    data['vendor_details_name'] = this.vendorDetailsName;
    data['s_no'] = this.sNo;
    return data;
  }
}



class CreateMeltingReceiptPayload {
  int? menuId;
  String? bagDetails;
  String? vendorDetails;
  String? branch;

  CreateMeltingReceiptPayload(
      {this.menuId, this.bagDetails, this.vendorDetails, this.branch});

  CreateMeltingReceiptPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    bagDetails = json['bag_details'];
    vendorDetails = json['vendor_details'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['bag_details'] = this.bagDetails;
    data['vendor_details'] = this.vendorDetails;
    data['branch'] = this.branch;
    return data;
  }
}



class MeltingReceiptresponse {
  int? id;
  String? meltingId;
  String? issueDate;
  int? issuedWeight;
  String? issuedBy;
  String? dueDate;
  bool? isReceived;
  String? receivedDate;
  int? receivedWeight;
  String? receivedBy;
  int? meltingCarges;
  int? gstPercent;
  int? gstAmount;
  int? vendorCharges;
  String? remark;
  bool? isIssued;
  bool? isCancelled;
  String? branchName;
  int? bagDetails;
  int? vendorDetails;
  int? branch;

  MeltingReceiptresponse(
      {this.id,
      this.meltingId,
      this.issueDate,
      this.issuedWeight,
      this.issuedBy,
      this.dueDate,
      this.isReceived,
      this.receivedDate,
      this.receivedWeight,
      this.receivedBy,
      this.meltingCarges,
      this.gstPercent,
      this.gstAmount,
      this.vendorCharges,
      this.remark,
      this.isIssued,
      this.isCancelled,
      this.branchName,
      this.bagDetails,
      this.vendorDetails,
      this.branch});

  MeltingReceiptresponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meltingId = json['melting_id'];
    issueDate = json['issue_date'];
    issuedWeight = json['issued_weight'];
    issuedBy = json['issued_by'];
    dueDate = json['due_date'];
    isReceived = json['is_received'];
    receivedDate = json['received_date'];
    receivedWeight = json['received_weight'];
    receivedBy = json['received_by'];
    meltingCarges = json['melting_carges'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    vendorCharges = json['vendor_charges'];
    remark = json['remark'];
    isIssued = json['is_issued'];
    isCancelled = json['is_cancelled'];
    branchName = json['branch_name'];
    bagDetails = json['bag_details'];
    vendorDetails = json['vendor_details'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['melting_id'] = this.meltingId;
    data['issue_date'] = this.issueDate;
    data['issued_weight'] = this.issuedWeight;
    data['issued_by'] = this.issuedBy;
    data['due_date'] = this.dueDate;
    data['is_received'] = this.isReceived;
    data['received_date'] = this.receivedDate;
    data['received_weight'] = this.receivedWeight;
    data['received_by'] = this.receivedBy;
    data['melting_carges'] = this.meltingCarges;
    data['gst_percent'] = this.gstPercent;
    data['gst_amount'] = this.gstAmount;
    data['vendor_charges'] = this.vendorCharges;
    data['remark'] = this.remark;
    data['is_issued'] = this.isIssued;
    data['is_cancelled'] = this.isCancelled;
    data['branch_name'] = this.branchName;
    data['bag_details'] = this.bagDetails;
    data['vendor_details'] = this.vendorDetails;
    data['branch'] = this.branch;
    return data;
  }
}

class UpdateMeltingReceiptPaylaod {
  int? menuId;
  int? id;
  double? receivedWeight;
  double? meltingCarges;
  double? gstPercent;
  double? gstAmount;
  double? vendorCharges;

  UpdateMeltingReceiptPaylaod(
      {this.menuId,
      this.id,
      this.receivedWeight,
      this.meltingCarges,
      this.gstPercent,
      this.gstAmount,
      this.vendorCharges,
  });

  UpdateMeltingReceiptPaylaod.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
    receivedWeight = json['received_weight'];
    meltingCarges = json['melting_carges'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    vendorCharges = json['vendor_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    data['received_weight'] = this.receivedWeight;
    data['melting_carges'] = this.meltingCarges;
    data['gst_percent'] = this.gstPercent;
    data['gst_amount'] = this.gstAmount;
    data['vendor_charges'] = this.vendorCharges;
    return data;
  }
}



class UpdateMeltingReceiptresponse {
  int? id;
  String? meltingId;
  String? issueDate;
  int? issuedWeight;
  String? issuedBy;
  Null? dueDate;
  bool? isReceived;
  String? receivedDate;
  double? receivedWeight;
  String? receivedBy;
  double? meltingCarges;
  int? gstPercent;
  double? gstAmount;
  double? vendorCharges;
  String? remark;
  bool? isIssued;
  bool? isCancelled;
  String? branchName;
  int? bagDetails;
  int? vendorDetails;
  int? branch;

  UpdateMeltingReceiptresponse(
      {this.id,
      this.meltingId,
      this.issueDate,
      this.issuedWeight,
      this.issuedBy,
      this.dueDate,
      this.isReceived,
      this.receivedDate,
      this.receivedWeight,
      this.receivedBy,
      this.meltingCarges,
      this.gstPercent,
      this.gstAmount,
      this.vendorCharges,
      this.remark,
      this.isIssued,
      this.isCancelled,
      this.branchName,
      this.bagDetails,
      this.vendorDetails,
      this.branch});

  UpdateMeltingReceiptresponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meltingId = json['melting_id'];
    issueDate = json['issue_date'];
    issuedWeight = json['issued_weight'];
    issuedBy = json['issued_by'];
    dueDate = json['due_date'];
    isReceived = json['is_received'];
    receivedDate = json['received_date'];
    receivedWeight = json['received_weight'];
    receivedBy = json['received_by'];
    meltingCarges = json['melting_carges'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    vendorCharges = json['vendor_charges'];
    remark = json['remark'];
    isIssued = json['is_issued'];
    isCancelled = json['is_cancelled'];
    branchName = json['branch_name'];
    bagDetails = json['bag_details'];
    vendorDetails = json['vendor_details'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['melting_id'] = this.meltingId;
    data['issue_date'] = this.issueDate;
    data['issued_weight'] = this.issuedWeight;
    data['issued_by'] = this.issuedBy;
    data['due_date'] = this.dueDate;
    data['is_received'] = this.isReceived;
    data['received_date'] = this.receivedDate;
    data['received_weight'] = this.receivedWeight;
    data['received_by'] = this.receivedBy;
    data['melting_carges'] = this.meltingCarges;
    data['gst_percent'] = this.gstPercent;
    data['gst_amount'] = this.gstAmount;
    data['vendor_charges'] = this.vendorCharges;
    data['remark'] = this.remark;
    data['is_issued'] = this.isIssued;
    data['is_cancelled'] = this.isCancelled;
    data['branch_name'] = this.branchName;
    data['bag_details'] = this.bagDetails;
    data['vendor_details'] = this.vendorDetails;
    data['branch'] = this.branch;
    return data;
  }
}
