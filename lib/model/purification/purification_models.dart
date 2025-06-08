class FetchPurificationListPayload {
  int? menuId;
  String? vendorDetails;
  String? search;
  bool? receivedStatus;
  bool? cancelStatus;
  String? metalDetails;
  String? branch;
  int? page;
  int? itemsPerPage;

  FetchPurificationListPayload(
      {this.menuId,
      this.vendorDetails,
      this.search,
      this.receivedStatus,
      this.cancelStatus, 
      this.metalDetails, 
      this.branch, 
      this.page,
      this.itemsPerPage});

  FetchPurificationListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    vendorDetails = json['vendor_details'];
    search = json['search'];
    receivedStatus = json['received_status'];
    cancelStatus = json['cancel_status'];
    metalDetails = json['metal_details'];
    branch = json['branch'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['vendor_details'] = this.vendorDetails;
    data['search'] = this.search;
    data['received_status'] = this.receivedStatus;
    data['cancel_status'] = this.cancelStatus;
    data['metal_details'] = this.metalDetails;
    data['branch'] = this.branch;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}




class PurificationListData {
  int? id;
  String? purificationId;
  String? issueDate;
  double? issuedWeight;
  String? issuedBy;
  String? dueDate;
  bool? isReceived;
  String? receivedDate;
  double? recievedTouch;
  double? receivedWeight;
  String? receivedBy;
  double? purificationCharges;
  int? metalDetails;
  double? gstPercent;
  double? gstAmount;
  double? vendorCharges;
  String? remark;
  bool? isCancelled;
  String? branchName;
  int? vendorDetails;
  int? branch;
  String? vendorDetailsName;
  int? sNo;

  PurificationListData(
      {this.id,
      this.purificationId,
      this.issueDate,
      this.issuedWeight,
      this.issuedBy,
      this.dueDate,
      this.isReceived,
      this.receivedDate,
      this.recievedTouch,
      this.receivedWeight,
      this.receivedBy,
      this.purificationCharges,
      this.metalDetails,
      this.gstPercent,
      this.gstAmount,
      this.vendorCharges,
      this.remark,
      this.isCancelled,
      this.branchName,
      this.vendorDetails,
      this.branch,
      this.vendorDetailsName,
      this.sNo});

  PurificationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purificationId = json['purification_id'];
    issueDate = json['issue_date'];
    issuedWeight = json['issued_weight'];
    issuedBy = json['issued_by'];
    dueDate = json['due_date'];
    isReceived = json['is_received'];
    receivedDate = json['received_date'];
    recievedTouch = json['recieved_touch'];
    receivedWeight = json['received_weight'];
    receivedBy = json['received_by'];
    purificationCharges = json['purification_charges'];
    metalDetails = json['metal_details'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    vendorCharges = json['vendor_charges'];
    remark = json['remark'];
    isCancelled = json['is_cancelled'];
    branchName = json['branch_name'];
    vendorDetails = json['vendor_details'];
    branch = json['branch'];
    vendorDetailsName = json['vendor_details_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purification_id'] = this.purificationId;
    data['issue_date'] = this.issueDate;
    data['issued_weight'] = this.issuedWeight;
    data['issued_by'] = this.issuedBy;
    data['due_date'] = this.dueDate;
    data['is_received'] = this.isReceived;
    data['received_date'] = this.receivedDate;
    data['recieved_touch'] = this.recievedTouch;
    data['received_weight'] = this.receivedWeight;
    data['received_by'] = this.receivedBy;
    data['purification_charges'] = this.purificationCharges;
    data['metal_details'] = this.metalDetails;
    data['gst_percent'] = this.gstPercent;
    data['gst_amount'] = this.gstAmount;
    data['vendor_charges'] = this.vendorCharges;
    data['remark'] = this.remark;
    data['is_cancelled'] = this.isCancelled;
    data['branch_name'] = this.branchName;
    data['vendor_details'] = this.vendorDetails;
    data['branch'] = this.branch;
    data['vendor_details_name'] = this.vendorDetailsName;
    data['s_no'] = this.sNo;
    return data;
  }
}



class CreatePurificationPayload {
  int? menuId;
  String? vendorDetails;
  String? branch;
  String? meltingDetails;
  double? issuedWeight;
  String? remark;
  String? dueDate;
  String? metalDetails;

  CreatePurificationPayload(
      {this.menuId,
      this.vendorDetails,
      this.branch,
      this.meltingDetails,
      this.issuedWeight,
      this.remark,
      this.dueDate,
      this.metalDetails});

  CreatePurificationPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    vendorDetails = json['vendor_details'];
    meltingDetails = json['melting_details'];
    branch = json['branch'];
    issuedWeight = json['issued_weight'];
    remark = json['remark'];
    dueDate = json['due_date'];
    metalDetails = json['metal_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['vendor_details'] = this.vendorDetails;
    data['branch'] = this.branch;
    data['melting_details'] = this.meltingDetails;
    data['issued_weight'] = this.issuedWeight;
    data['remark'] = this.remark;
    data['due_date'] = this.dueDate;
    data['metal_details'] = this.metalDetails;
    return data;
  }
}



class UpdatePurificationPayload {
  int? menuId;
  int? id;
  double? recievedTouch;
  double? receivedWeight;
  double? purificationCharges;
  double? gstPercent;
  double? gstAmount;
  double? vendorCharges;

  UpdatePurificationPayload(
      {this.menuId,
      this.id,
      this.recievedTouch,
      this.receivedWeight,
      this.purificationCharges,
      this.gstPercent,
      this.gstAmount,
      this.vendorCharges});

  UpdatePurificationPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
    recievedTouch = json['recieved_touch'];
    receivedWeight = json['received_weight'];
    purificationCharges = json['purification_charges'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    vendorCharges = json['vendor_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    data['recieved_touch'] = this.recievedTouch;
    data['received_weight'] = this.receivedWeight;
    data['purification_charges'] = this.purificationCharges;
    data['gst_percent'] = this.gstPercent;
    data['gst_amount'] = this.gstAmount;
    data['vendor_charges'] = this.vendorCharges;
    return data;
  }
}
