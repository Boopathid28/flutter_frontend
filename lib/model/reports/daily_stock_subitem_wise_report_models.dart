class DailyStockSubitemItemWiseReport {
  List<DailyStockSubitemItemWiseReportList>? list;
  num? totalOutPieces;
  num? totalInPieces;
  num? totalOutWeight;
  num? totalInWeight;
  num? totalOpenPieces;
  num? totalClosePieces;
  num? totalOpenWeight;
  num? totalCloseWeight;
  num? totalPages;
  num? currentPage;
  num? totalItems;
  num? currentItems;

  DailyStockSubitemItemWiseReport(
      {this.list,
      this.totalOutPieces,
      this.totalInPieces,
      this.totalOutWeight,
      this.totalInWeight,
      this.totalOpenPieces,
      this.totalClosePieces,
      this.totalOpenWeight,
      this.totalCloseWeight,
      this.totalPages,
      this.currentPage,
      this.totalItems,
      this.currentItems});

  DailyStockSubitemItemWiseReport.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <DailyStockSubitemItemWiseReportList>[];
      json['list'].forEach((v) {
        list!.add(DailyStockSubitemItemWiseReportList.fromJson(v));
      });
    }
    totalOutPieces = json['total_out_pieces'];
    totalInPieces = json['total_in_pieces'];
    totalOutWeight = json['total_out_weight'];
    totalInWeight = json['total_in_weight'];
    totalOpenPieces = json['total_open_pieces'];
    totalClosePieces = json['total_close_pieces'];
    totalOpenWeight = json['total_open_weight'];
    totalCloseWeight = json['total_close_weight'];
    totalPages = json['total_pages'];
    currentPage = json['current_page'];
    totalItems = json['total_items'];
    currentItems = json['current_items'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    data['total_out_pieces'] = totalOutPieces;
    data['total_in_pieces'] = totalInPieces;
    data['total_out_weight'] = totalOutWeight;
    data['total_in_weight'] = totalInWeight;
    data['total_open_pieces'] = totalOpenPieces;
    data['total_close_pieces'] = totalClosePieces;
    data['total_open_weight'] = totalOpenWeight;
    data['total_close_weight'] = totalCloseWeight;
    data['total_pages'] = totalPages;
    data['current_page'] = currentPage;
    data['total_items'] = totalItems;
    data['current_items'] = currentItems;
    return data;
  }
}

class DailyStockSubitemItemWiseReportList {
  num? id;
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
  num? itemDetails;
  num? inPieces;
  num? inWeight;
  num? outPieces;
  num? outWeight;
  num? openPieces;
  num? openWeight;
  num? closePieces;
  num? closeWeight;
   num? issuedPieces;
  num? issuedWeight;
  num? receivedPieces;
  num? receivedWeight;
  num? sNo;

  DailyStockSubitemItemWiseReportList(
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
      this.inPieces,
      this.inWeight,
      this.outPieces,
      this.outWeight,
      this.openPieces,
      this.openWeight,
      this.closePieces,
      this.closeWeight,
       this.issuedPieces,
      this.issuedWeight,
       this.receivedPieces,
      this.receivedWeight,
      this.sNo});

  DailyStockSubitemItemWiseReportList.fromJson(Map<String, dynamic> json) {
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
    inPieces = json['in_pieces'];
    inWeight = json['in_weight'];
    outPieces = json['out_pieces'];
    outWeight = json['out_weight'];
    openPieces = json['open_pieces'];
    openWeight = json['open_weight'];
    closePieces = json['close_pieces'];
    closeWeight = json['close_weight'];
      issuedPieces = json['issued_pieces'];
    issuedWeight = json['issued_weight'];
    receivedPieces = json['received_pieces'];
    receivedWeight = json['received_weight'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sub_item_name'] = subItemName;
    data['sub_item_code'] = subItemCode;
    data['hsn_code'] = hsnCode;
    data['stock_type'] = stockType;
    data['measurement_type'] = measurementType;
    data['calculation_type'] = calculationType;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['modified_at'] = modifiedAt;
    data['modified_by'] = modifiedBy;
    data['item_details'] = itemDetails;
    data['in_pieces'] = inPieces;
    data['in_weight'] = inWeight;
    data['out_pieces'] = outPieces;
    data['out_weight'] = outWeight;
    data['open_pieces'] = openPieces;
    data['open_weight'] = openWeight;
    data['close_pieces'] = closePieces;
    data['close_weight'] = closeWeight;
      data['issued_pieces'] = issuedPieces;
    data['issued_weight'] = issuedWeight;
     data['received_pieces'] = receivedPieces;
    data['received_weight'] = receivedWeight;
    data['s_no'] = sNo;
    return data;
  }
}






class DailyStockSubitemItemWiseReportPayload {
  String? menuId;
  String? fromDate;
  String? item;
  String? subItem;
  num? page;
  num? itemsPerPage;
  String? branch;

  DailyStockSubitemItemWiseReportPayload(
      {this.menuId,
      this.fromDate,
      this.item,
      this.subItem,
      this.page,
      this.itemsPerPage,
      this.branch});

  DailyStockSubitemItemWiseReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    item = json['item'];
    subItem = json['sub_item'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['from_date'] = fromDate;
    data['item'] = item;
    data['sub_item'] = subItem;
    data['page'] = page;
    data['items_per_page'] = itemsPerPage;
    data['branch'] = branch;
    return data;
  }
}
