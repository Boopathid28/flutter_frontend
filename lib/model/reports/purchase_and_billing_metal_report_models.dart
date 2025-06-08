class FetchPurchaseandbillingReportPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? metal;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchPurchaseandbillingReportPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.metal,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchPurchaseandbillingReportPayload.fromJson(Map<String, dynamic> json) {
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



class PurchaseandbillingReportResponse {
  int? id;
  String? metalName;
  String? metalCode;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? totalPurchasePieces;
  String? totalPurchaseGrossWeight;
  String? totalPurchaseAmount;
  String? totalSalePieces;
  String? totalSaleGrossWeight;
  String? totalSaleAmount;
  int? sNo;

  PurchaseandbillingReportResponse(
      {this.id,
      this.metalName,
      this.metalCode,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.totalPurchasePieces,
      this.totalPurchaseGrossWeight,
      this.totalPurchaseAmount,
      this.totalSalePieces,
      this.totalSaleGrossWeight,
      this.totalSaleAmount,
      this.sNo});

  PurchaseandbillingReportResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metalName = json['metal_name'];
    metalCode = json['metal_code'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    totalPurchasePieces = json['total_purchase_pieces'].toString();
    totalPurchaseGrossWeight = json['total_purchase_gross_weight'].toString();
    totalPurchaseAmount = json['total_purchase_amount'].toString();
    totalSalePieces = json['total_sale_pieces'].toString();
    totalSaleGrossWeight = json['total_sale_gross_weight'].toString();
    totalSaleAmount = json['total_sale_amount'].toString();
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
    data['total_purchase_pieces'] = this.totalPurchasePieces;
    data['total_purchase_gross_weight'] = this.totalPurchaseGrossWeight;
    data['total_purchase_amount'] = this.totalPurchaseAmount;
    data['total_sale_pieces'] = this.totalSalePieces;
    data['total_sale_gross_weight'] = this.totalSaleGrossWeight;
    data['total_sale_amount'] = this.totalSaleAmount;
    data['s_no'] = this.sNo;
    return data;
  }
}


