class DailyStockDesignerWiseReport {
  List<DailyStockDesignerWiseReportList>? list;
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

  DailyStockDesignerWiseReport(
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

  DailyStockDesignerWiseReport.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <DailyStockDesignerWiseReportList>[];
      json['list'].forEach((v) {
        list!.add( DailyStockDesignerWiseReportList.fromJson(v));
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

class DailyStockDesignerWiseReportList {
  num? id;
  String? designerName;
  String? designerCode;
  String? email;
  String? mobileNumber;
  String? website;
  String? landlineNumber;
  String? address;
  String? gstNumber;
  String? panNumber;
  String? accountNumber;
  String? accountName;
  String? ifscCode;
  String? bankName;
  String? branchName;
  String? upiId;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  dynamic modifiedAt;
  dynamic modifiedBy;
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

  DailyStockDesignerWiseReportList(
      {this.id,
      this.designerName,
      this.designerCode,
      this.email,
      this.mobileNumber,
      this.website,
      this.landlineNumber,
      this.address,
      this.gstNumber,
      this.panNumber,
      this.accountNumber,
      this.accountName,
      this.ifscCode,
      this.bankName,
      this.branchName,
      this.upiId,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
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

  DailyStockDesignerWiseReportList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designerName = json['designer_name'];
    designerCode = json['designer_code'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    website = json['website'];
    landlineNumber = json['landline_number'];
    address = json['address'];
    gstNumber = json['gst_number'];
    panNumber = json['pan_number'];
    accountNumber = json['account_number'];
    accountName = json['account_name'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    branchName = json['branch_name'];
    upiId = json['upi_id'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
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
    data['designer_name'] = designerName;
    data['designer_code'] = designerCode;
    data['email'] = email;
    data['mobile_number'] = mobileNumber;
    data['website'] = website;
    data['landline_number'] = landlineNumber;
    data['address'] = address;
    data['gst_number'] = gstNumber;
    data['pan_number'] = panNumber;
    data['account_number'] = accountNumber;
    data['account_name'] = accountName;
    data['ifsc_code'] = ifscCode;
    data['bank_name'] = bankName;
    data['branch_name'] = branchName;
    data['upi_id'] = upiId;
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['modified_at'] = modifiedAt;
    data['modified_by'] = modifiedBy;
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



class DailyStockDesignerWiseReportPayload {
  String? menuId;
  dynamic fromDate;
  String? designer;
  num? page;
  num? itemsPerPage;
  String? branch;

  DailyStockDesignerWiseReportPayload(
      {this.menuId,
      this.fromDate,
      this.designer,
      this.page,
      this.itemsPerPage,
      this.branch});

  DailyStockDesignerWiseReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    designer = json['designer'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['from_date'] = fromDate;
    data['designer'] = designer;
    data['page'] = page;
    data['items_per_page'] = itemsPerPage;
    data['branch'] = branch;
    return data;
  }
}
