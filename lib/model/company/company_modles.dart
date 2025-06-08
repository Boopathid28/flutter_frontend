class CreateCompanyResponse {
  int? id;
  String? companyName;
  String? email;
  String? mobileNumber;
  String? website;
  String? landlineNumber;
  String? companyLogo;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? accountNumber;
  String? accountName;
  String? ifscCode;
  String? bankName;
  String? branchName;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  CreateCompanyResponse(
      {this.id,
      this.companyName,
      this.email,
      this.mobileNumber,
      this.website,
      this.landlineNumber,
      this.companyLogo,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.accountNumber,
      this.accountName,
      this.ifscCode,
      this.bankName,
      this.branchName,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  CreateCompanyResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    website = json['website'];
    landlineNumber = json['landline_number'];
    companyLogo = json['company_logo'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['website'] = this.website;
    data['landline_number'] = this.landlineNumber;
    data['company_logo'] = this.companyLogo;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}


class CompanyDetailsData {
  int? id;
  String? companyName;
  String? email;
  String? mobileNumber;
  String? website;
  String? landlineNumber;
  String? companyLogo;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? accountNumber;
  String? accountName;
  String? ifscCode;
  String? bankName;
  String? branchName;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  CompanyDetailsData(
      {this.id,
      this.companyName,
      this.email,
      this.mobileNumber,
      this.website,
      this.landlineNumber,
      this.companyLogo,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.accountNumber,
      this.accountName,
      this.ifscCode,
      this.bankName,
      this.branchName,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  CompanyDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    website = json['website'];
    landlineNumber = json['landline_number'];
    companyLogo = json['company_logo'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_name'] = this.companyName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['website'] = this.website;
    data['landline_number'] = this.landlineNumber;
    data['company_logo'] = this.companyLogo;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['pan_number'] = this.panNumber;
    data['account_number'] = this.accountNumber;
    data['account_name'] = this.accountName;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['branch_name'] = this.branchName;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}
