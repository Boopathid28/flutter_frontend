class FetchPurityWiseRepairReportListPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? purity;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchPurityWiseRepairReportListPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.purity,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchPurityWiseRepairReportListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    purity = json['purity'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['purity'] = this.purity;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}


class PurityWiseRepairReportListData {
  int? id;
  String? purityName;
  String? purityCode;
  double? purityPercent;
  bool? isActive;
  bool? isVisible;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? metal;
  int? totalPieces;
  double? totalGrossWeight;
  int? sNo;

  PurityWiseRepairReportListData(
      {this.id,
      this.purityName,
      this.purityCode,
      this.purityPercent,
      this.isActive,
      this.isVisible,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.metal,
      this.totalPieces,
      this.totalGrossWeight,
      this.sNo});

  PurityWiseRepairReportListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purityName = json['purity_name'];
    purityCode = json['purity_code'];
    purityPercent = json['purity_percent'];
    isActive = json['is_active'];
    isVisible = json['is_visible'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    metal = json['metal'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = double.parse(json['total_gross_weight'].toString());
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purity_name'] = this.purityName;
    data['purity_code'] = this.purityCode;
    data['purity_percent'] = this.purityPercent;
    data['is_active'] = this.isActive;
    data['is_visible'] = this.isVisible;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['metal'] = this.metal;
    data['total_pieces'] = this.totalPieces;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['s_no'] = this.sNo;
    return data;
  }
}
