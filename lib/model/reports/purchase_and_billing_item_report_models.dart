class FetchPurchaseandbillingItemReportPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? item;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchPurchaseandbillingItemReportPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.item,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchPurchaseandbillingItemReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    item = json['item'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['item'] = this.item;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}




class PurchaseandbillingItemReportResponse {
  int? id;
  String? itemName;
  String? itemCode;
  String? huidCharges;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? purity;
  String? totalPurchasePieces;
  String? totalPurchaseGrossWeight;
  String? totalPurchaseAmount;
  String? totalSalePieces;
  String? totalSaleGrossWeight;
  String? totalSaleAmount;
  int? sNo;

  PurchaseandbillingItemReportResponse(
      {this.id,
      this.itemName,
      this.itemCode,
      this.huidCharges,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.purity,
      this.totalPurchasePieces,
      this.totalPurchaseGrossWeight,
      this.totalPurchaseAmount,
      this.totalSalePieces,
      this.totalSaleGrossWeight,
      this.totalSaleAmount,
      this.sNo});

  PurchaseandbillingItemReportResponse.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    itemCode = json['item_code'];
    huidCharges = json['huid_charges'].toString();
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    purity = json['purity'].toString();
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
    data['item_name'] = this.itemName;
    data['item_code'] = this.itemCode;
    data['huid_charges'] = this.huidCharges;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['purity'] = this.purity;
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