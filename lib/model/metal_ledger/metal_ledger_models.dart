class FetchMetalLedgerListPayload {
  int? menuId;
  String? branch;
  String? vendor;
  String? oldLedgerEntryType;
  String? metal;
  String? touch;
  bool? cancelStatus;
  String? fromDate;
  String? toDate;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchMetalLedgerListPayload(
      {this.menuId,
      this.branch,
      this.vendor,
      this.oldLedgerEntryType,
      this.metal,
      this.touch,
      this.cancelStatus,
      this.fromDate,
      this.toDate,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchMetalLedgerListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    vendor = json['vendor'];
    oldLedgerEntryType = json['old_ledger_entry_type'];
    metal = json['metal'];
    touch = json['touch'];
    cancelStatus = json['cancel_status'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['vendor'] = this.vendor;
    data['old_ledger_entry_type'] = this.oldLedgerEntryType;
    data['metal'] = this.metal;
    data['touch'] = this.touch;
    data['cancel_status'] = this.cancelStatus;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}



class MetalLedgerListResponse {
  int? id;
  String? entryDate;
  String? oldLedgerEntryType;
  double? touch;
  double? weight;
  String? refferenceNumber;
  bool? isCancelled;
  String? createdBy;
  int? vendorDetails;
  int? metalDetails;
  String? metalDetailsName;
  String? vendorDetailsName;
  String? branchName;
  int? sNo;

  MetalLedgerListResponse(
      {this.id,
      this.entryDate,
      this.oldLedgerEntryType,
      this.touch,
      this.weight,
      this.refferenceNumber,
      this.isCancelled,
      this.createdBy,
      this.vendorDetails,
      this.metalDetails,
      this.metalDetailsName,
      this.vendorDetailsName,
      this.branchName,
      this.sNo});

  MetalLedgerListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryDate = json['entry_date'];
    oldLedgerEntryType = json['old_ledger_entry_type'];
    touch = json['touch'];
    weight = json['weight'];
    refferenceNumber = json['refference_number'];
    isCancelled = json['is_cancelled'];
    createdBy = json['created_by'];
    vendorDetails = json['vendor_details'];
    metalDetails = json['metal_details'];
    metalDetailsName = json['metal_details_name'];
    vendorDetailsName = json['vendor_details_name'];
    branchName = json['branch_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entry_date'] = this.entryDate;
    data['old_ledger_entry_type'] = this.oldLedgerEntryType;
    data['touch'] = this.touch;
    data['weight'] = this.weight;
    data['refference_number'] = this.refferenceNumber;
    data['is_cancelled'] = this.isCancelled;
    data['created_by'] = this.createdBy;
    data['vendor_details'] = this.vendorDetails;
    data['metal_details'] = this.metalDetails;
    data['metal_details_name'] = this.metalDetailsName;
    data['vendor_details_name'] = this.vendorDetailsName;
    data['branch_name'] = this.branchName;
    data['s_no'] = this.sNo;
    return data;
  }
}
