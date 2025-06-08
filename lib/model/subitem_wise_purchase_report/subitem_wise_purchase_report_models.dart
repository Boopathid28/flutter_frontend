class FetchSubItemWisePurchaseReportListPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? item;
  String? subItem;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchSubItemWisePurchaseReportListPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.item,
      this.subItem,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchSubItemWisePurchaseReportListPayload.fromJson(
      Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    item = json['item'];
    subItem = json['sub_item'];
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
    data['sub_item'] = this.subItem;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}




class SubItemWisePurchaseReportListData {
  int? id;
  String? subItemName;
  String? subItemCode;
  String? hsnCode;
  String? stockType;
  String? measurementType;
  String? calculationType;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? itemDetails;
  String? itemDetailsName;
  int? totalPieces;
  String? totalGrossWeight;
  String? totalNetWeight;
  String? totalAmount;
  int? sNo;

  SubItemWisePurchaseReportListData(
      {this.id,
      this.subItemName,
      this.subItemCode,
      this.hsnCode,
      this.stockType,
      this.measurementType,
      this.calculationType,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.itemDetails,
      this.itemDetailsName,
      this.totalPieces,
      this.totalGrossWeight,
      this.totalNetWeight,
      this.totalAmount,
      this.sNo});

  SubItemWisePurchaseReportListData.fromJson(
      Map<String, dynamic> json) {
    id = json['id'];
    subItemName = json['sub_item_name'];
    subItemCode = json['sub_item_code'];
    hsnCode = json['hsn_code'];
    stockType = json['stock_type'];
    measurementType = json['measurement_type'];
    calculationType = json['calculation_type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    itemDetails = json['item_details'];
    itemDetailsName = json['item_details_name'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'].toString();
    totalNetWeight = json['total_net_weight'].toString();
    totalAmount = json['total_amount'].toString();
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
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['item_details'] = this.itemDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['total_pieces'] = this.totalPieces;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['total_net_weight'] = this.totalNetWeight;
    data['total_amount'] = this.totalAmount;
    data['s_no'] = this.sNo;
    return data;
  }
}
