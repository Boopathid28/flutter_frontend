class FetchEstimationMetalWiseReportListPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? metal;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchEstimationMetalWiseReportListPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.metal,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchEstimationMetalWiseReportListPayload.fromJson(
      Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    metal = json['metal'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['metal'] = this.metal;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}




class EstimationMetalWiseReportListData {
  int? id;
  String? metalName;
  String? metalCode;
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

  EstimationMetalWiseReportListData(
      {this.id,
      this.metalName,
      this.metalCode,
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

  EstimationMetalWiseReportListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metalName = json['metal_name'];
    metalCode = json['metal_code'];
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
    data['metal_name'] = this.metalName;
    data['metal_code'] = this.metalCode;
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
