import 'dart:developer';

class FetchLotListPayload {
  String? entryDateFromRange;
  String? entryDateToRange;
  String? entryType;
  String? designer;
  String? lotStatus;
  String? search;
  int? page;
  int? itemsPerPage;
  int? menuId;
  String? branch;

  FetchLotListPayload(
      {this.entryDateFromRange,
      this.entryDateToRange,
      this.entryType,
      this.designer,
      this.lotStatus,
      this.search,
      this.page,
      this.itemsPerPage,
      this.menuId,
      this.branch});

  FetchLotListPayload.fromJson(Map<String, dynamic> json) {
    entryDateFromRange = json['entry_date_from_range'];
    entryDateToRange = json['entry_date_to_range'];
    entryType = json['entry_type'];
    designer = json['designer'];
    lotStatus = json['lot_status'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entry_date_from_range'] = this.entryDateFromRange;
    data['entry_date_to_range'] = this.entryDateToRange;
    data['entry_type'] = this.entryType;
    data['designer'] = this.designer;
    data['lot_status'] = this.lotStatus;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    return data;
  }
}

class LotListData {
  int? id;
  String? entryDate;
  String? entryType;
  String? refInvoiceNumber;
  String? hallmarkCertificateNumber;
  String? hallmarkCenter;
  int? totalTagCount;
  int? totalPieces;
  double? totalGrossWeight;
  int? taggedTagCount;
  int? taggedPieces;
  double? taggedGrossWeight;
  String? lotStatus;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? designerDetails;
  int? branch;
  int? lotNumber;
  String? designerName;
  int? sNo;

  LotListData(
      {this.id,
      this.entryDate,
      this.entryType,
      this.refInvoiceNumber,
      this.hallmarkCertificateNumber,
      this.hallmarkCenter,
      this.totalTagCount,
      this.totalPieces,
      this.totalGrossWeight,
      this.taggedTagCount,
      this.taggedPieces,
      this.taggedGrossWeight,
      this.lotStatus,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.designerDetails,
      this.branch,
      this.lotNumber,
      this.designerName,
      this.sNo});

  LotListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryDate = json['entry_date'];
    entryType = json['entry_type'];
    refInvoiceNumber = json['ref_invoice_number'];
    hallmarkCertificateNumber = json['hallmark_certificate_number'];
    hallmarkCenter = json['hallmark_center'];
    totalTagCount = json['total_tag_count'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'];
    taggedTagCount = json['tagged_tag_count'];
    taggedPieces = json['tagged_pieces'];
    taggedGrossWeight = json['tagged_gross_weight'];
    lotStatus = json['lot_status'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    designerDetails = json['designer_details'];
    branch = json['branch'];
    lotNumber = json['lot_number'];
    designerName = json['designer_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entry_date'] = this.entryDate;
    data['entry_type'] = this.entryType;
    data['ref_invoice_number'] = this.refInvoiceNumber;
    data['hallmark_certificate_number'] = this.hallmarkCertificateNumber;
    data['hallmark_center'] = this.hallmarkCenter;
    data['total_tag_count'] = this.totalTagCount;
    data['total_pieces'] = this.totalPieces;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['tagged_tag_count'] = this.taggedTagCount;
    data['tagged_pieces'] = this.taggedPieces;
    data['tagged_gross_weight'] = this.taggedGrossWeight;
    data['lot_status'] = this.lotStatus;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['designer_details'] = this.designerDetails;
    data['branch'] = this.branch;
    data['lot_number'] = this.lotNumber;
    data['designer_name'] = this.designerName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class LotFormItemDataModel {
  int? id;
  int? itemDetails;
  String? itemDetailsName;
  String? purchaseItemId;
  String? tagCount;
  String? pieces;
  String? grossWeight;
  String? remark;
  late bool isDb;

  LotFormItemDataModel(
      {this.id,
      this.itemDetails,
      this.itemDetailsName,
      this.purchaseItemId,
      this.tagCount,
      this.pieces,
      this.grossWeight,
      this.remark,
      this.isDb = false});

  LotFormItemDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemDetails = json['item_details'];
    itemDetailsName = json['item_details_name'];
    purchaseItemId = json['purchase_item_id'];
    tagCount = json['tag_count'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    remark = json['remark'];
    isDb = json['is_db'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_details'] = this.itemDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['purchase_item_id'] = this.purchaseItemId;
    data['tag_count'] = this.tagCount;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['remark'] = this.remark;
    data['is_db'] = this.isDb;
    return data;
  }
}

class CreateLotDetailsPayload {
  int? menuId;
  String? entryDate;
  String? entryType;
  String? designerDetails;
  String? branch;
  String? refInvoiceNumber;
  String? hallmarkCertificateNumber;
  String? hallmarkCenter;
  List<LotFormItemDataModel>? itemDetails;

  CreateLotDetailsPayload(
      {this.menuId,
      this.entryDate,
      this.entryType,
      this.designerDetails,
      this.branch,
      this.refInvoiceNumber,
      this.hallmarkCertificateNumber,
      this.hallmarkCenter,
      this.itemDetails});

  CreateLotDetailsPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    entryDate = json['entry_date'];
    entryType = json['entry_type'];
    designerDetails = json['designer_details'];
    branch = json['branch'];
    refInvoiceNumber = json['ref_invoice_number'];
    hallmarkCertificateNumber = json['hallmark_certificate_number'];
    hallmarkCenter = json['hallmark_center'];
    if (json['item_details'] != null) {
      itemDetails = <LotFormItemDataModel>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new LotFormItemDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['entry_date'] = this.entryDate;
    data['entry_type'] = this.entryType;
    data['designer_details'] = this.designerDetails;
    data['branch'] = this.branch;
    data['ref_invoice_number'] = this.refInvoiceNumber;
    data['hallmark_certificate_number'] = this.hallmarkCertificateNumber;
    data['hallmark_center'] = this.hallmarkCenter;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CreateLotDetailsResponse {
  int? id;
  int? lotNumber;
  String? entryDate;
  String? entryType;
  String? refInvoiceNumber;
  String? hallmarkCertificateNumber;
  String? hallmarkCenter;
  int? totalTagCount;
  int? totalPieces;
  double? totalGrossWeight;
  int? taggedTagCount;
  int? taggedPieces;
  double? taggedGrossWeight;
  String? lotStatus;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? designerDetails;
  int? branch;

  CreateLotDetailsResponse(
      {this.id,
      this.lotNumber,
      this.entryDate,
      this.entryType,
      this.refInvoiceNumber,
      this.hallmarkCertificateNumber,
      this.hallmarkCenter,
      this.totalTagCount,
      this.totalPieces,
      this.totalGrossWeight,
      this.taggedTagCount,
      this.taggedPieces,
      this.taggedGrossWeight,
      this.lotStatus,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.designerDetails,
      this.branch});

  CreateLotDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lotNumber = json['lot_number'];
    entryDate = json['entry_date'];
    entryType = json['entry_type'];
    refInvoiceNumber = json['ref_invoice_number'];
    hallmarkCertificateNumber = json['hallmark_certificate_number'];
    hallmarkCenter = json['hallmark_center'];
    totalTagCount = json['total_tag_count'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'];
    taggedTagCount = json['tagged_tag_count'];
    taggedPieces = json['tagged_pieces'];
    taggedGrossWeight = json['tagged_gross_weight'];
    lotStatus = json['lot_status'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    designerDetails = json['designer_details'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lot_number'] = this.lotNumber;
    data['entry_date'] = this.entryDate;
    data['entry_type'] = this.entryType;
    data['ref_invoice_number'] = this.refInvoiceNumber;
    data['hallmark_certificate_number'] = this.hallmarkCertificateNumber;
    data['hallmark_center'] = this.hallmarkCenter;
    data['total_tag_count'] = this.totalTagCount;
    data['total_pieces'] = this.totalPieces;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['tagged_tag_count'] = this.taggedTagCount;
    data['tagged_pieces'] = this.taggedPieces;
    data['tagged_gross_weight'] = this.taggedGrossWeight;
    data['lot_status'] = this.lotStatus;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['designer_details'] = this.designerDetails;
    data['branch'] = this.branch;
    return data;
  }
}

class LotDetailsData {
  int? id;
  int? lotNumber;
  String? entryDate;
  String? entryType;
  String? entryTypeName;
  String? refInvoiceNumber;
  String? hallmarkCertificateNumber;
  String? hallmarkCenter;
  int? totalTagCount;
  int? totalPieces;
  double? totalGrossWeight;
  int? taggedTagCount;
  int? taggedPieces;
  double? taggedGrossWeight;
  String? lotStatus;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? designerDetails;
  int? branch;
  String? designerName;
  List<LotItemDetails>? itemList;

  LotDetailsData(
      {this.id,
      this.lotNumber,
      this.entryDate,
      this.entryType,
      this.entryTypeName,
      this.refInvoiceNumber,
      this.hallmarkCertificateNumber,
      this.hallmarkCenter,
      this.totalTagCount,
      this.totalPieces,
      this.totalGrossWeight,
      this.taggedTagCount,
      this.taggedPieces,
      this.taggedGrossWeight,
      this.lotStatus,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.designerDetails,
      this.branch,
      this.designerName,
      this.itemList});

  LotDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lotNumber = json['lot_number'];
    entryDate = json['entry_date'];
    entryType = json['entry_type'];
    entryTypeName = json['entry_type_name'];
    refInvoiceNumber = json['ref_invoice_number'];
    hallmarkCertificateNumber = json['hallmark_certificate_number'];
    hallmarkCenter = json['hallmark_center'];
    totalTagCount = json['total_tag_count'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'];
    taggedTagCount = json['tagged_tag_count'];
    taggedPieces = json['tagged_pieces'];
    taggedGrossWeight = json['tagged_gross_weight'];
    lotStatus = json['lot_status'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    designerDetails = json['designer_details'];
    branch = json['branch'];
    designerName = json['designer_name'];
    if (json['item_list'] != null) {
      itemList = <LotItemDetails>[];
      json['item_list'].forEach((v) {
        itemList!.add(new LotItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lot_number'] = this.lotNumber;
    data['entry_date'] = this.entryDate;
    data['entry_type'] = this.entryType;
    data['entry_type_name'] = this.entryTypeName;
    data['ref_invoice_number'] = this.refInvoiceNumber;
    data['hallmark_certificate_number'] = this.hallmarkCertificateNumber;
    data['hallmark_center'] = this.hallmarkCenter;
    data['total_tag_count'] = this.totalTagCount;
    data['total_pieces'] = this.totalPieces;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['tagged_tag_count'] = this.taggedTagCount;
    data['tagged_pieces'] = this.taggedPieces;
    data['tagged_gross_weight'] = this.taggedGrossWeight;
    data['lot_status'] = this.lotStatus;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['designer_details'] = this.designerDetails;
    data['branch'] = this.branch;
    data['designer_name'] = this.designerName;
    if (this.itemList != null) {
      data['item_list'] = this.itemList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LotItemDetails {
  int? id;
  int? tagCount;
  int? pieces;
  double? grossWeight;
  int? taggedTagCount;
  int? taggedPieces;
  double? taggedGrossWeight;
  String? remark;
  int? lotDetails;
  int? itemDetails;
  String? itemDetailsName;
  late bool isDb;

  LotItemDetails(
      {this.id,
      this.tagCount,
      this.pieces,
      this.grossWeight,
      this.taggedTagCount,
      this.taggedPieces,
      this.taggedGrossWeight,
      this.remark,
      this.lotDetails,
      this.itemDetails,
      this.itemDetailsName,
      this.isDb = false});

  LotItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagCount = json['tag_count'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    taggedTagCount = json['tagged_tag_count'];
    taggedPieces = json['tagged_pieces'];
    taggedGrossWeight = json['tagged_gross_weight'];
    remark = json['remark'];
    lotDetails = json['lot_details'];
    itemDetails = json['item_details'];
    itemDetailsName = json['item_details_name'];
    isDb = json['is_db'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag_count'] = this.tagCount;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['tagged_tag_count'] = this.taggedTagCount;
    data['tagged_pieces'] = this.taggedPieces;
    data['tagged_gross_weight'] = this.taggedGrossWeight;
    data['remark'] = this.remark;
    data['lot_details'] = this.lotDetails;
    data['item_details'] = this.itemDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['is_db'] = this.isDb;
    return data;
  }
}

class UpdateLotPayload {
  int? id;
  int? menuId;
  String? entryDate;
  String? entryType;
  String? designerDetails;
  String? branch;
  String? refInvoiceNumber;
  String? hallmarkCertificateNumber;
  String? hallmarkCenter;
  List<LotFormItemDataModel>? itemDetails;

  UpdateLotPayload(
      {this.id,
      this.menuId,
      this.entryDate,
      this.entryType,
      this.designerDetails,
      this.branch,
      this.refInvoiceNumber,
      this.hallmarkCertificateNumber,
      this.hallmarkCenter,
      this.itemDetails});

  UpdateLotPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    entryDate = json['entry_date'];
    entryType = json['entry_type'];
    designerDetails = json['designer_details'];
    branch = json['branch'];
    refInvoiceNumber = json['ref_invoice_number'];
    hallmarkCertificateNumber = json['hallmark_certificate_number'];
    hallmarkCenter = json['hallmark_center'];
    if (json['item_details'] != null) {
      itemDetails = <LotFormItemDataModel>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new LotFormItemDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['entry_date'] = this.entryDate;
    data['entry_type'] = this.entryType;
    data['designer_details'] = this.designerDetails;
    data['branch'] = this.branch;
    data['ref_invoice_number'] = this.refInvoiceNumber;
    data['hallmark_certificate_number'] = this.hallmarkCertificateNumber;
    data['hallmark_center'] = this.hallmarkCenter;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}