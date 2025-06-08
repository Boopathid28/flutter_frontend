class DailyStockItemWiseReport {
  List<DailyStockItemWiseReportList>? list;
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
  num? totalIssuedWeight;
  num? totalIssuedPieces;
  num? totalDifferenceWeight;
 
  DailyStockItemWiseReport(
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
      this.currentItems,
      this.totalIssuedWeight,
      this.totalIssuedPieces,
      this.totalDifferenceWeight
      });
 
  DailyStockItemWiseReport.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <DailyStockItemWiseReportList>[];
      json['list'].forEach((v) {
        list!.add(DailyStockItemWiseReportList.fromJson(v));
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
      totalIssuedWeight = json['total_issued_weight'];
    totalIssuedPieces = json['total_issued_pieces'];
    totalDifferenceWeight = json['total_difference_weight'];
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
   data['total_issued_weight'] = totalIssuedWeight;
    data['total_issued_pieces'] = totalIssuedPieces;
    data['total_difference_weight'] = totalDifferenceWeight;
    return data;
  }
}
 
class DailyStockItemWiseReportList {
  num? id;
  String? itemName;
  String? itemCode;
  num? huidCharges;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  dynamic modifiedAt;
  dynamic modifiedBy;
  num? purity;
  String? inPieces;
  String? inWeight;
  String? outPieces;
  String? outWeight;
  String? openPieces;
  String? openWeight;
  String? closePieces;
  String? closeWeight;
  String? issuedPieces;
  String? issuedWeight;
  String? receivedPieces;
  String? receivedWeight;
  String? differenceWeight;
  num? sNo;
 
  DailyStockItemWiseReportList(
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
      this.differenceWeight,
      this.sNo});
 
  DailyStockItemWiseReportList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    itemCode = json['item_code'];
    huidCharges = json['huid_charges'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    purity = json['purity'];
    inPieces = json['in_pieces'].toString();
    inWeight = json['in_weight'].toString();
    outPieces = json['out_pieces'].toString();
    outWeight = json['out_weight'].toString();
    openPieces = json['open_pieces'].toString();
    openWeight = json['open_weight'].toString();
    closePieces = json['close_pieces'].toString();
    closeWeight = json['close_weight'].toString();
     issuedPieces = json['issued_pieces'].toString();
    issuedWeight = json['issued_weight'].toString();
    receivedPieces = json['received_pieces'].toString();
    receivedWeight = json['received_weight'].toString();
    differenceWeight = json['difference_weight'].toString();
    sNo = json['s_no'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_name'] = itemName;
    data['item_code'] = itemCode;
    data['huid_charges'] = huidCharges;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['modified_at'] = modifiedAt;
    data['modified_by'] = modifiedBy;
    data['purity'] = purity;
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
    data['difference_weight'] = differenceWeight;
    return data;
  }
}
 
 
 
 
 
class DailyStockItemWiseReportPayload {
  String? menuId;
  dynamic fromDate;
  String? item;
  num? page;
  num? itemsPerPage;
  String? branch;
 
  DailyStockItemWiseReportPayload(
      {this.menuId,
      this.fromDate,
      this.item,
      this.page,
      this.itemsPerPage,
      this.branch});
 
  DailyStockItemWiseReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    item = json['item'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['from_date'] = fromDate;
    data['item'] = item;
    data['page'] = page;
    data['items_per_page'] = itemsPerPage;
    data['branch'] = branch;
    return data;
  }
}