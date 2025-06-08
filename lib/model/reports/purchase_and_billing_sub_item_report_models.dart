class FetchPurchaseandbillingSubItemReportPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? subitem;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchPurchaseandbillingSubItemReportPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.subitem,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchPurchaseandbillingSubItemReportPayload.fromJson(
      Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    subitem = json['subitem'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['subitem'] = this.subitem;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}






class PurchaseandbillingSubItemReportResponse {
  int? id;
  String? subItemName;
  String? subItemCode;
  String? hsnCode;
  String? stockType;
  String? measurementType;
  String? calculationType;
  String? coverWeight;
  String? tagWeight;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? itemDetails;
  int? catalogDetails;
  String? totalPurchasePieces;
  String? totalPurchaseGrossWeight;
  String? totalPurchaseAmount;
  String? totalSalePieces;
  String? totalSaleGrossWeight;
  String? totalSaleAmount;
  int? sNo;

  PurchaseandbillingSubItemReportResponse(
      {this.id,
      this.subItemName,
      this.subItemCode,
      this.hsnCode,
      this.stockType,
      this.measurementType,
      this.calculationType,
      this.coverWeight,
      this.tagWeight,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.itemDetails,
      this.catalogDetails,
      this.totalPurchasePieces,
      this.totalPurchaseGrossWeight,
      this.totalPurchaseAmount,
      this.totalSalePieces,
      this.totalSaleGrossWeight,
      this.totalSaleAmount,
      this.sNo});

  PurchaseandbillingSubItemReportResponse.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    subItemName = json['sub_item_name'];
    subItemCode = json['sub_item_code'];
    hsnCode = json['hsn_code'];
    stockType = json['stock_type'];
    measurementType = json['measurement_type'];
    calculationType = json['calculation_type'];
    coverWeight = json['cover_weight'].toString();
    tagWeight = json['tag_weight'].toString();
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    itemDetails = json['item_details'];
    catalogDetails = json['catalog_details'];
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
    data['sub_item_name'] = this.subItemName;
    data['sub_item_code'] = this.subItemCode;
    data['hsn_code'] = this.hsnCode;
    data['stock_type'] = this.stockType;
    data['measurement_type'] = this.measurementType;
    data['calculation_type'] = this.calculationType;
    data['cover_weight'] = this.coverWeight;
    data['tag_weight'] = this.tagWeight;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['item_details'] = this.itemDetails;
    data['catalog_details'] = this.catalogDetails;
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
