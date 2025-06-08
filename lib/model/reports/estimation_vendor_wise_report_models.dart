class FetchEstimationVendorDesignerWiseReportListPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? designer;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchEstimationVendorDesignerWiseReportListPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.designer,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchEstimationVendorDesignerWiseReportListPayload.fromJson(
      Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    designer = json['designer'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['designer'] = this.designer;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}





class EstimationVendorWiseReportListData {
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
  int? totalPieces;
  String? totalGrossWeight;
  String? totalNetWeight;
  String? totalAmount;
  int? sNo;

  EstimationVendorWiseReportListData(
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
      this.modifiedBy,
      this.totalPieces,
      this.totalGrossWeight,
      this.totalNetWeight,
      this.totalAmount,
      this.sNo});

  EstimationVendorWiseReportListData.fromJson(Map<String, dynamic> json) {
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
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'].toString();
    totalNetWeight = json['total_net_weight'].toString();
    totalAmount = json['total_amount'].toString();
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
    data['total_pieces'] = this.totalPieces;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['total_net_weight'] = this.totalNetWeight;
    data['total_amount'] = this.totalAmount;
    data['s_no'] = this.sNo;
    return data;
  }
}

