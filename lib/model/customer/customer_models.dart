class FetchCustomerListPayload {
  int? menuId;
  String? search;
  bool? activeStatus;
  int? customerGroup;
  int? page;
  int? itemsPerPage;

  FetchCustomerListPayload(
      {this.menuId,
      this.search,
      this.activeStatus,
      this.customerGroup,
      this.page,
      this.itemsPerPage});

  FetchCustomerListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    search = json['search'];
    activeStatus = json['active_status'];
    customerGroup = json['customer_group'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['search'] = this.search;
    data['active_status'] = this.activeStatus;
    data['customer_group'] = this.customerGroup;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class CustomerListData {
  int? id;
  String? customerName;
  String? email;
  String? mobileNumber;
  String? dob;
  String? maritalStatus;
  String? upiId;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? aadharNumber;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? customerGroup;
  String? customerGroupName;
  int? sNo;

  CustomerListData(
      {this.id,
      this.customerName,
      this.email,
      this.mobileNumber,
      this.dob,
      this.maritalStatus,
      this.upiId,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.aadharNumber,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.customerGroup,
      this.customerGroupName,
      this.sNo});

  CustomerListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    dob = json['dob'];
    maritalStatus = json['marital_status'];
    upiId = json['upi_id'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    customerGroup = json['customer_group'];
    customerGroupName = json['customer_group_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['dob'] = this.dob;
    data['marital_status'] = this.maritalStatus;
    data['upi_id'] = this.upiId;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['aadhar_number'] = this.aadharNumber;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['customer_group'] = this.customerGroup;
    data['customer_group_name'] = this.customerGroupName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class CreateCustomerPayload {
  int? menuId;
  String? customerName;
  int? customerGroup;
  String? email;
  int? mobileNumber;
  String? dob;
  String? maritalStatus;
  String? upiId;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? aadharNumber;

  CreateCustomerPayload(
      {this.menuId,
      this.customerName,
      this.customerGroup,
      this.email,
      this.mobileNumber,
      this.dob,
      this.maritalStatus,
      this.upiId,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.aadharNumber});

  CreateCustomerPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    customerName = json['customer_name'];
    customerGroup = json['customer_group'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    dob = json['dob'];
    maritalStatus = json['marital_status'];
    upiId = json['upi_id'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['customer_name'] = this.customerName;
    data['customer_group'] = this.customerGroup;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['dob'] = this.dob;
    data['marital_status'] = this.maritalStatus;
    data['upi_id'] = this.upiId;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['aadhar_number'] = this.aadharNumber;
    return data;
  }
}

class CustomerCreateResponse {
  int? id;
  String? customerName;
  String? email;
  String? mobileNumber;
  String? dob;
  String? maritalStatus;
  String? upiId;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? aadharNumber;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? customerGroup;

  CustomerCreateResponse(
      {this.id,
      this.customerName,
      this.email,
      this.mobileNumber,
      this.dob,
      this.maritalStatus,
      this.upiId,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.aadharNumber,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.customerGroup});

  CustomerCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    dob = json['dob'];
    maritalStatus = json['marital_status'];
    upiId = json['upi_id'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    customerGroup = json['customer_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['dob'] = this.dob;
    data['marital_status'] = this.maritalStatus;
    data['upi_id'] = this.upiId;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['aadhar_number'] = this.aadharNumber;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['customer_group'] = this.customerGroup;
    return data;
  }
}


class UpdateCustomerPayload {
  int? id;
  int? menuId;
  String? customerName;
  int? customerGroup;
  String? email;
  int? mobileNumber;
  String? dob;
  String? maritalStatus;
  String? upiId;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? aadharNumber;

  UpdateCustomerPayload(
      {this.id,
      this.menuId,
      this.customerName,
      this.customerGroup,
      this.email,
      this.mobileNumber,
      this.dob,
      this.maritalStatus,
      this.upiId,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.aadharNumber});

  UpdateCustomerPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    customerName = json['customer_name'];
    customerGroup = json['customer_group'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    dob = json['dob'];
    maritalStatus = json['marital_status'];
    upiId = json['upi_id'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['customer_name'] = this.customerName;
    data['customer_group'] = this.customerGroup;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['dob'] = this.dob;
    data['marital_status'] = this.maritalStatus;
    data['upi_id'] = this.upiId;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['aadhar_number'] = this.aadharNumber;
    return data;
  }
}

class CustomerVerificationResponse {
  int? id;
  String? customerName;
  String? email;
  String? mobileNumber;
  String? dob;
  String? maritalStatus;
  String? upiId;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? aadharNumber;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? customerGroup;

  CustomerVerificationResponse(
      {this.id,
      this.customerName,
      this.email,
      this.mobileNumber,
      this.dob,
      this.maritalStatus,
      this.upiId,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.aadharNumber,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.customerGroup});

  CustomerVerificationResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    dob = json['dob'];
    maritalStatus = json['marital_status'];
    upiId = json['upi_id'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    aadharNumber = json['aadhar_number'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    customerGroup = json['customer_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['dob'] = this.dob;
    data['marital_status'] = this.maritalStatus;
    data['upi_id'] = this.upiId;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['aadhar_number'] = this.aadharNumber;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['customer_group'] = this.customerGroup;
    return data;
  }
}
