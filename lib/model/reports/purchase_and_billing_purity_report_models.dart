class FetchPurchaseandbillingPurityReportPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? purity;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchPurchaseandbillingPurityReportPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.purity,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchPurchaseandbillingPurityReportPayload.fromJson(
      Map<String, dynamic> json) {
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




class PurchaseandbillingPurityReportResponse {
  int? id;
  String? purityName;
  String? purityCode;
  String? purityPercent;
  bool? isActive;
  bool? isVisible;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? metal;
  String? totalPurchasePieces;
  String? totalPurchaseGrossWeight;
  String? totalPurchaseAmount;
  String? totalSalePieces;
  String? totalSaleGrossWeight;
  String? totalSaleAmount;
  int? sNo;

  PurchaseandbillingPurityReportResponse(
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
      this.totalPurchasePieces,
      this.totalPurchaseGrossWeight,
      this.totalPurchaseAmount,
      this.totalSalePieces,
      this.totalSaleGrossWeight,
      this.totalSaleAmount,
      this.sNo});

  PurchaseandbillingPurityReportResponse.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    purityName = json['purity_name'];
    purityCode = json['purity_code'];
    purityPercent = json['purity_percent'].toString();
    isActive = json['is_active'];
    isVisible = json['is_visible'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    metal = json['metal'];
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
