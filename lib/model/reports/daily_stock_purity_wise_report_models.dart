class DailyStockPurityWiseReport {
  List<DailyStockPurityWiseReportList>? list;
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

  DailyStockPurityWiseReport(
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

  DailyStockPurityWiseReport.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <DailyStockPurityWiseReportList>[];
      json['list'].forEach((v) {
        list!.add(new DailyStockPurityWiseReportList.fromJson(v));
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

class DailyStockPurityWiseReportList {
  num? id;
  String? purityName;
  String? purityCode;
  double? purityPercent;
  bool? isActive;
  bool? isVisible;
  String? createdAt;
  String? createdBy;
  dynamic modifiedAt;
  dynamic modifiedBy;
  num? metal;
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

  DailyStockPurityWiseReportList(
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

  DailyStockPurityWiseReportList.fromJson(Map<String, dynamic> json) {
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
    data['purity_name'] = purityName;
    data['purity_code'] = purityCode;
    data['purity_percent'] = purityPercent;
    data['is_active'] = isActive;
    data['is_visible'] = isVisible;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['modified_at'] = modifiedAt;
    data['modified_by'] = modifiedBy;
    data['metal'] = metal;
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




class DailyStockPurityWiseReportPayload {
  String? menuId;
  dynamic fromDate;
  String? purity;
  num? page;
  num? itemsPerPage;
  String? branch;

  DailyStockPurityWiseReportPayload(
      {this.menuId,
      this.fromDate,
      this.purity,
      this.page,
      this.itemsPerPage,
      this.branch});

  DailyStockPurityWiseReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    purity = json['purity'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['from_date'] = fromDate;
    data['purity'] = purity;
    data['page'] = page;
    data['items_per_page'] = itemsPerPage;
    data['branch'] = branch;
    return data;
  }
}
