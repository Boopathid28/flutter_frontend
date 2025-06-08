class FetchCatalogVerificationReportListPayload {
  int? _menuId;
  String? _fromDate;
  String? _toDate;
  String? _catalogType;
  int? _page;
  int? _itemsPerPage;
  String? _branch;

  FetchCatalogVerificationReportListPayload(
      {int? menuId,
      String? fromDate,
      String? toDate,
      String? catalogType,
      int? page,
      int? itemsPerPage,
      String? branch}) {
    if (menuId != null) {
      this._menuId = menuId;
    }
    if (fromDate != null) {
      this._fromDate = fromDate;
    }
    if (toDate != null) {
      this._toDate = toDate;
    }
    if (catalogType != null) {
      this._catalogType = catalogType;
    }
    if (page != null) {
      this._page = page;
    }
    if (itemsPerPage != null) {
      this._itemsPerPage = itemsPerPage;
    }
    if (branch != null) {
      this._branch = branch;
    }
  }

  int? get menuId => _menuId;
  set menuId(int? menuId) => _menuId = menuId;
  String? get fromDate => _fromDate;
  set fromDate(String? fromDate) => _fromDate = fromDate;
  String? get toDate => _toDate;
  set toDate(String? toDate) => _toDate = toDate;
  String? get catalogType => _catalogType;
  set catalogType(String? catalogType) => _catalogType = catalogType;
  int? get page => _page;
  set page(int? page) => _page = page;
  int? get itemsPerPage => _itemsPerPage;
  set itemsPerPage(int? itemsPerPage) => _itemsPerPage = itemsPerPage;
  String? get branch => _branch;
  set branch(String? branch) => _branch = branch;

  FetchCatalogVerificationReportListPayload.fromJson(
      Map<String, dynamic> json) {
    _menuId = json['menu_id'];
    _fromDate = json['from_date'];
    _toDate = json['to_date'];
    _catalogType = json['catalog_type'];
    _page = json['page'];
    _itemsPerPage = json['items_per_page'];
    _branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this._menuId;
    data['from_date'] = this._fromDate;
    data['to_date'] = this._toDate;
    data['catalog_type'] = this._catalogType;
    data['page'] = this._page;
    data['items_per_page'] = this._itemsPerPage;
    data['branch'] = this._branch;
    return data;
  }
}


class CatalogVerificationReportListData {
  int? id;
  String? catalogNumber;
  String? catalogWeight;
  String? catalogType;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? counterDetails;
  String? counterDetailsName;
  String? catalogTypeName;
  int? availablePieces;
  String? availableNetWeight;
  String? availableGrossWeight;
  String? coverWeight;
  String? totalWeight;
  String? balanceWeight;
  int? sNo;

  CatalogVerificationReportListData(
      {this.id,
      this.catalogNumber,
      this.catalogWeight,
      this.catalogType,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.counterDetails,
      this.counterDetailsName,
      this.catalogTypeName,
      this.availablePieces,
      this.availableNetWeight,
      this.availableGrossWeight,
      this.coverWeight,
      this.totalWeight,
      this.balanceWeight,
      this.sNo});

  CatalogVerificationReportListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catalogNumber = json['catalog_number'];
    catalogWeight = json['catalog_weight'].toString();
    catalogType = json['catalog_type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    counterDetails = json['counter_details'];
    counterDetailsName = json['counter_details_name'];
    catalogTypeName = json['catalog_type_name'];
    availablePieces = json['available_pieces'];
    availableNetWeight = json['available_net_weight'].toString();
    availableGrossWeight = json['available_gross_weight'].toString();
    coverWeight = json['cover_weight'].toString();
    totalWeight = json['total_weight'].toString();
    balanceWeight = json['balance_weight'].toString();
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catalog_number'] = this.catalogNumber;
    data['catalog_weight'] = this.catalogWeight;
    data['catalog_type'] = this.catalogType;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['counter_details'] = this.counterDetails;
    data['counter_details_name'] = this.counterDetailsName;
    data['catalog_type_name'] = this.catalogTypeName;
    data['available_pieces'] = this.availablePieces;
    data['available_net_weight'] = this.availableNetWeight;
    data['available_gross_weight'] = this.availableGrossWeight;
    data['cover_weight'] = this.coverWeight;
    data['total_weight'] = this.totalWeight;
    data['balance_weight'] = this.balanceWeight;
    data['s_no'] = this.sNo;
    return data;
  }
}
