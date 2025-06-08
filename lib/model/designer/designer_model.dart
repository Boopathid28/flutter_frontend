class FetchDesignerListPayload {
  int? menuId;
  String? search;
  bool? activeStatus;
  int? page;
  int? itemsPerPage;

  FetchDesignerListPayload(
      {this.menuId,
      this.search,
      this.activeStatus,
      this.page,
      this.itemsPerPage});

  FetchDesignerListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    search = json['search'];
    activeStatus = json['active_status'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['search'] = this.search;
    data['active_status'] = this.activeStatus;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class DesignerListData {
  int? id;
  String? designerName;
  String? designerCode;
  String? email;
  String? mobileNumber;
  String? website;
  String? landlineNumber;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? accountNumber;
  String? accountName;
  String? ifscCode;
  String? bankName;
  String? branchName;
  String? upiId;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? sNo;

  DesignerListData(
      {this.id,
      this.designerName,
      this.designerCode,
      this.email,
      this.mobileNumber,
      this.website,
      this.landlineNumber,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.accountNumber,
      this.accountName,
      this.ifscCode,
      this.bankName,
      this.branchName,
      this.upiId,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.sNo});

  DesignerListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designerName = json['designer_name'];
    designerCode = json['designer_code'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    website = json['website'];
    landlineNumber = json['landline_number'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    upiId = json['upi_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['designer_name'] = this.designerName;
    data['designer_code'] = this.designerCode;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['website'] = this.website;
    data['landline_number'] = this.landlineNumber;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['upi_id'] = this.upiId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['s_no'] = this.sNo;
    return data;
  }
}

class CreateDesignerPayload {
  int? menuId;
  String? designerName;
  String? designerCode;
  String? email;
  String? mobileNumber;
  String? remarks;
  String? website;
  String? landlineNumber;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? accountNumber;
  String? accountName;
  String? ifscCode;
  String? bankName;
  String? branchName;
  String? upiId;

  CreateDesignerPayload(
      {this.menuId,
      this.designerName,
      this.designerCode,
      this.email,
      this.mobileNumber,
      this.website,
      this.landlineNumber,
      this.address,
      this.remarks,
      this.gstNumber,
      this.panNumber,
      this.accountNumber,
      this.accountName,
      this.ifscCode,
      this.bankName,
      this.branchName,
      this.upiId});

  CreateDesignerPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    designerName = json['designer_name'];
    designerCode = json['designer_code'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    website = json['website'];
    landlineNumber = json['landline_number'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    remarks = json['remarks'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    upiId = json['upi_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['designer_name'] = this.designerName;
    data['designer_code'] = this.designerCode;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['website'] = this.website;
    data['landline_number'] = this.landlineNumber;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['remarks'] = this.remarks;
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['upi_id'] = this.upiId;
    return data;
  }
}

class UpdateDesignerPayload {
  int? menuId;
  int? id;
  String? designerName;
  String? designerCode;
  String? email;
  String? mobileNumber;
  String? website;
  String? landlineNumber;
  String? address;
  String? gstNumber;
  String? remarks;
  String? panNumber;
  String? accountNumber;
  String? accountName;
  String? ifscCode;
  String? bankName;
  String? branchName;
  String? upiId;

  UpdateDesignerPayload(
      {this.menuId,
      this.id,
      this.designerName,
      this.designerCode,
      this.email,
      this.mobileNumber,
      this.remarks,
      this.website,
      this.landlineNumber,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.accountNumber,
      this.accountName,
      this.ifscCode,
      this.bankName,
      this.branchName,
      this.upiId});

  UpdateDesignerPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
    designerName = json['designer_name'];
    designerCode = json['designer_code'];
    remarks = json['remarks'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    website = json['website'];
    landlineNumber = json['landline_number'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    upiId = json['upi_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    data['designer_name'] = this.designerName;
    data['designer_code'] = this.designerCode;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['website'] = this.website;
    data['landline_number'] = this.landlineNumber;
    data['address'] = this.address;
    data['remarks'] = this.remarks;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['upi_id'] = this.upiId;
    return data;
  }
}

class DesignerCreateResponse {
  int? id;
  String? designerName;
  String? designerCode;
  String? email;
  String? mobileNumber;
  String? website;
  String? landlineNumber;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? accountNumber;
  String? accountName;
  String? ifscCode;
  String? bankName;
  String? branchName;
  String? upiId;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  DesignerCreateResponse(
      {this.id,
      this.designerName,
      this.designerCode,
      this.email,
      this.mobileNumber,
      this.website,
      this.landlineNumber,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.accountNumber,
      this.accountName,
      this.ifscCode,
      this.bankName,
      this.branchName,
      this.upiId,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  DesignerCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designerName = json['designer_name'];
    designerCode = json['designer_code'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    website = json['website'];
    landlineNumber = json['landline_number'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    upiId = json['upi_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['designer_name'] = this.designerName;
    data['designer_code'] = this.designerCode;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['website'] = this.website;
    data['landline_number'] = this.landlineNumber;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['upi_id'] = this.upiId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}

class DesignerDetailsData {
  int? id;
  String? designerName;
  String? designerCode;
  String? email;
  String? mobileNumber;
  String? website;
  String? landlineNumber;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? remarks;
  String? accountNumber;
  String? accountName;
  String? ifscCode;
  String? bankName;
  String? branchName;
  String? upiId;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  DesignerDetailsData(
      {this.id,
      this.designerName,
      this.designerCode,
      this.email,
      this.mobileNumber,
      this.website,
      this.landlineNumber,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.accountNumber,
      this.accountName,
      this.ifscCode,
      this.bankName,
      this.branchName,
      this.remarks,
      this.upiId,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  DesignerDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designerName = json['designer_name'];
    designerCode = json['designer_code'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    website = json['website'];
    landlineNumber = json['landline_number'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    remarks = json['remarks'];
    branchName = json['branch_name'];
    upiId = json['upi_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['designer_name'] = this.designerName;
    data['designer_code'] = this.designerCode;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['website'] = this.website;
    data['landline_number'] = this.landlineNumber;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['account_number'] = this.accountNumber;
    data['remarks'] = this.remarks;
    data['account_name'] = this.accountName;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['upi_id'] = this.upiId;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}
