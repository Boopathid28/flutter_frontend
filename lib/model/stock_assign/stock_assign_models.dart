class FetchStockAssignListPayload {
  int? menuId;
  String? catalogDetails;
  String? catalogType;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchStockAssignListPayload(
      {this.menuId,
      this.catalogDetails,
      this.catalogType,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchStockAssignListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    catalogDetails = json['catalog_details'];
    catalogType = json['catalog_type'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['catalog_details'] = this.catalogDetails;
    data['catalog_type'] = this.catalogType;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}



class StockAssignListData {
  int? id;
  int? catalogDetails;
  int? tagDetails;
  String? catalogNumber;
  String? tagNumber;
  String? catalogTypeName;
  int? availablePieces;
  double? availableGrossWeight;
  double? availableNetWeight;
  int? sNo;

  StockAssignListData(
      {this.id,
      this.catalogDetails,
      this.tagDetails,
      this.catalogNumber,
      this.tagNumber,
      this.catalogTypeName,
      this.availablePieces,
      this.availableGrossWeight,
      this.availableNetWeight,
      this.sNo});

  StockAssignListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catalogDetails = json['catalog_details'];
    tagDetails = json['tag_details'];
    catalogNumber = json['catalog_number'];
    tagNumber = json['tag_number'];
    catalogTypeName = json['catalog_type_name'];
    availablePieces = json['available_pieces'];
    availableGrossWeight = json['available_gross_weight'];
    availableNetWeight = json['available_net_weight'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catalog_details'] = this.catalogDetails;
    data['tag_details'] = this.tagDetails;
    data['catalog_number'] = this.catalogNumber;
    data['tag_number'] = this.tagNumber;
    data['catalog_type_name'] = this.catalogTypeName;
    data['available_pieces'] = this.availablePieces;
    data['available_gross_weight'] = this.availableGrossWeight;
    data['available_net_weight'] = this.availableNetWeight;
    data['s_no'] = this.sNo;
    return data;
  }
}


class ValidationTagPayload {
  int? menuId;
  List<String>? tagDetails;

  ValidationTagPayload({this.menuId, this.tagDetails});

  ValidationTagPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    tagDetails = json['tag_details'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['tag_details'] = this.tagDetails;
    return data;
  }
}


class ValidationAssignTagResponse {
  List<AssignedTags>? assignedTags;
  List<int>? newTag;
  bool? popup;

  ValidationAssignTagResponse({this.assignedTags, this.newTag, this.popup});

  ValidationAssignTagResponse.fromJson(Map<String, dynamic> json) {
    if (json['assigned_tags'] != null) {
      assignedTags = <AssignedTags>[];
      json['assigned_tags'].forEach((v) {
        assignedTags!.add(new AssignedTags.fromJson(v));
      });
    }
    newTag = json['new_tag'].cast<int>();
    popup = json['popup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assignedTags != null) {
      data['assigned_tags'] =
          this.assignedTags!.map((v) => v.toJson()).toList();
    }
    data['new_tag'] = this.newTag;
    data['popup'] = this.popup;
    return data;
  }
}

class AssignedTags {
  String? catalogDetails;
  String? tagNumber;
  String? counter;
  String? floor;
  String? branch;

  AssignedTags(
      {this.catalogDetails, this.tagNumber, this.counter, this.floor, this.branch});

  AssignedTags.fromJson(Map<String, dynamic> json) {
    catalogDetails = json['catalog_details'];
    tagNumber = json['tag_number'];
    counter = json['counter'];
    floor = json['floor'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catalog_details'] = this.catalogDetails;
    data['tag_number'] = this.tagNumber;
    data['counter'] = this.counter;
    data['floor'] = this.floor;
    data['branch'] = this.branch;
    return data;
  }
}



class CreateStockAssignPayload {
  int? menuId;
  String? catalogDetails;
  List<String>? tagDetails;

  CreateStockAssignPayload({this.menuId, this.catalogDetails, this.tagDetails});

  CreateStockAssignPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    catalogDetails = json['catalog_details'];
    tagDetails = json['tag_details'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['catalog_details'] = this.catalogDetails;
    data['tag_details'] = this.tagDetails;
    return data;
  }
}
















