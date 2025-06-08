class FetchDirectIssuesListPayload {
  String? designer;
  String? fromDate;
  String? toDate;
  int? page;
  int? itemsPerPage;
  int? menuId;

  FetchDirectIssuesListPayload(
      {this.designer,
      this.fromDate,
      this.toDate,
      this.page,
      this.itemsPerPage,
      this.menuId});

  FetchDirectIssuesListPayload.fromJson(Map<String, dynamic> json) {
    designer = json['designer'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['designer'] = this.designer;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    return data;
  }
}




class DirectIssuesListData {
  int? id;
  String? directIssueId;
  String? issuedDate;
  String? remarks;
  String? issuedBy;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? issueTo;
  String? designerName;
  int? sNo;

  DirectIssuesListData(
      {this.id,
      this.directIssueId,
      this.issuedDate,
      this.remarks,
      this.issuedBy,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.issueTo,
      this.designerName,
      this.sNo});

  DirectIssuesListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    directIssueId = json['direct_issue_id'];
    issuedDate = json['issued_date'];
    remarks = json['remarks'];
    issuedBy = json['issued_by'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    issueTo = json['issue_to'];
    designerName = json['designer_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['direct_issue_id'] = this.directIssueId;
    data['issued_date'] = this.issuedDate;
    data['remarks'] = this.remarks;
    data['issued_by'] = this.issuedBy;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['issue_to'] = this.issueTo;
    data['designer_name'] = this.designerName;
    data['s_no'] = this.sNo;
    return data;
  }
}




class CreateDirectIssuesPayload {
  int? menuId;
  String? issueTo;
  String? dueDate;
  String? remarks;
  String? branch;
  List<TagItemDetails>? tagItemDetails;

  CreateDirectIssuesPayload(
      {this.menuId,
      this.issueTo,
      this.dueDate,
      this.remarks,
      this.branch,
      this.tagItemDetails});

  CreateDirectIssuesPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    issueTo = json['issue_to'];
    dueDate = json['due_date'];
    remarks = json['remarks'];
    branch = json['branch'];
    if (json['tag_item_details'] != null) {
      tagItemDetails = <TagItemDetails>[];
      json['tag_item_details'].forEach((v) {
        tagItemDetails!.add(new TagItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['issue_to'] = this.issueTo;
    data['due_date'] = this.dueDate;
    data['remarks'] = this.remarks;
    data['branch'] = this.branch;
    if (this.tagItemDetails != null) {
      data['tag_item_details'] =
          this.tagItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TagItemDetails {
  String? tagDetails;

  TagItemDetails({this.tagDetails});

  TagItemDetails.fromJson(Map<String, dynamic> json) {
    tagDetails = json['tag_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_details'] = this.tagDetails;
    return data;
  }
}




class CreateDirectIssuesResponse {
  int? id;
  String? directIssueId;
  String? issuedDate;
  String? remarks;
  String? issuedBy;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? issueTo;

  CreateDirectIssuesResponse(
      {this.id,
      this.directIssueId,
      this.issuedDate,
      this.remarks,
      this.issuedBy,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.issueTo});

  CreateDirectIssuesResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    directIssueId = json['direct_issue_id'];
    issuedDate = json['issued_date'];
    remarks = json['remarks'];
    issuedBy = json['issued_by'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    issueTo = json['issue_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['direct_issue_id'] = this.directIssueId;
    data['issued_date'] = this.issuedDate;
    data['remarks'] = this.remarks;
    data['issued_by'] = this.issuedBy;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['issue_to'] = this.issueTo;
    return data;
  }
}





class RetriveDirectIssuesDetails {
  int? id;
  String? directIssueId;
  String? issuedDate;
  String? remarks;
  String? issuedBy;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? issueTo;
  String? designerName;
  List<ItemDetails>? itemDetails;

  RetriveDirectIssuesDetails(
      {this.id,
      this.directIssueId,
      this.issuedDate,
      this.remarks,
      this.issuedBy,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.issueTo,
      this.designerName,
      this.itemDetails});

  RetriveDirectIssuesDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    directIssueId = json['direct_issue_id'];
    issuedDate = json['issued_date'];
    remarks = json['remarks'];
    issuedBy = json['issued_by'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    issueTo = json['issue_to'];
    designerName = json['designer_name'];
    if (json['item_details'] != null) {
      itemDetails = <ItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new ItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['direct_issue_id'] = this.directIssueId;
    data['issued_date'] = this.issuedDate;
    data['remarks'] = this.remarks;
    data['issued_by'] = this.issuedBy;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['issue_to'] = this.issueTo;
    data['designer_name'] = this.designerName;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemDetails {
  int? id;
  bool? isIssued;
  int? directIssueDetails;
  int? tagItemDetails;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? tagNumber;
  int? pieces;
  String? grossWeight;
  String? netWeight;
  String? totalStonePieces;
  String? totalStoneAmount;
  String? totalStoneWeight;
  String? totalDiamondWeight;
  String? totalDiamondAmount;
  String? totalDiamondPieces;

  ItemDetails(
      {this.id,
      this.isIssued,
      this.directIssueDetails,
      this.tagItemDetails,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.tagNumber,
      this.pieces,
      this.grossWeight,
      this.netWeight,
      this.totalStonePieces,
      this.totalStoneAmount,
      this.totalStoneWeight,
      this.totalDiamondWeight,
      this.totalDiamondAmount,
      this.totalDiamondPieces});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isIssued = json['is_issued'];
    directIssueDetails = json['direct_issue_details'];
    tagItemDetails = json['tag_item_details'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    tagNumber = json['tag_number'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'].toString();
    netWeight = json['net_weight'].toString();
    totalStonePieces = json['total_stone_pieces'].toString();
    totalStoneAmount = json['total_stone_amount'].toString();
    totalStoneWeight = json['total_stone_weight'].toString();
    totalDiamondWeight = json['total_diamond_weight'].toString();
    totalDiamondAmount = json['total_diamond_amount'].toString();
    totalDiamondPieces = json['total_diamond_pieces'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['is_issued'] = this.isIssued;
    data['direct_issue_details'] = this.directIssueDetails;
    data['tag_item_details'] = this.tagItemDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['tag_number'] = this.tagNumber;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_stone_amount'] = this.totalStoneAmount;
    data['total_stone_weight'] = this.totalStoneWeight;
    data['total_diamond_weight'] = this.totalDiamondWeight;
    data['total_diamond_amount'] = this.totalDiamondAmount;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    return data;
  }
}
