class FetchTaxListPayload {
  int? menuId;
  int? metal;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchTaxListPayload(
      {this.menuId, this.metal, this.search, this.page, this.itemsPerPage});

  FetchTaxListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    metal = json['metal'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['metal'] = this.metal;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class TaxListData {
  int? id;
  String? taxName;
  String? taxCode;
  double? purchaseIgst;
  double? purchaseCgst;
  double? purchaseSgst;
  double? salesIgst;
  double? salesCgst;
  double? salesSgst;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? metal;
  String? metalName;
  int? sNo;

  TaxListData(
      {this.id,
      this.taxName,
      this.taxCode,
      this.purchaseIgst,
      this.purchaseCgst,
      this.purchaseSgst,
      this.salesIgst,
      this.salesCgst,
      this.salesSgst,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.metal,
      this.metalName,
      this.sNo});

  TaxListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxName = json['tax_name'];
    taxCode = json['tax_code'];
    purchaseIgst = json['purchase_igst'];
    purchaseCgst = json['purchase_cgst'];
    purchaseSgst = json['purchase_sgst'];
    salesIgst = json['sales_igst'];
    salesCgst = json['sales_cgst'];
    salesSgst = json['sales_sgst'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    metal = json['metal'];
    metalName = json['metal_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax_name'] = this.taxName;
    data['tax_code'] = this.taxCode;
    data['purchase_igst'] = this.purchaseIgst;
    data['purchase_cgst'] = this.purchaseCgst;
    data['purchase_sgst'] = this.purchaseSgst;
    data['sales_igst'] = this.salesIgst;
    data['sales_cgst'] = this.salesCgst;
    data['sales_sgst'] = this.salesSgst;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['metal'] = this.metal;
    data['metal_name'] = this.metalName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class CreateTaxPayload {
  int? menuId;
  int? metal;
  String? taxName;
  String? taxCode;
  double? purchaseIgst;
  double? purchaseCgst;
  double? purchaseSgst;
  double? salesIgst;
  double? salesCgst;
  double? salesSgst;

  CreateTaxPayload(
      {this.menuId,
      this.metal,
      this.taxName,
      this.taxCode,
      this.purchaseIgst,
      this.purchaseCgst,
      this.purchaseSgst,
      this.salesIgst,
      this.salesCgst,
      this.salesSgst});

  CreateTaxPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    metal = json['metal'];
    taxName = json['tax_name'];
    taxCode = json['tax_code'];
    purchaseIgst = json['purchase_igst'];
    purchaseCgst = json['purchase_cgst'];
    purchaseSgst = json['purchase_sgst'];
    salesIgst = json['sales_igst'];
    salesCgst = json['sales_cgst'];
    salesSgst = json['sales_sgst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['metal'] = this.metal;
    data['tax_name'] = this.taxName;
    data['tax_code'] = this.taxCode;
    data['purchase_igst'] = this.purchaseIgst;
    data['purchase_cgst'] = this.purchaseCgst;
    data['purchase_sgst'] = this.purchaseSgst;
    data['sales_igst'] = this.salesIgst;
    data['sales_cgst'] = this.salesCgst;
    data['sales_sgst'] = this.salesSgst;
    return data;
  }
}

class TaxCreateResponse {
  int? id;
  String? taxName;
  String? taxCode;
  double? purchaseIgst;
  double? purchaseCgst;
  double? purchaseSgst;
  double? salesIgst;
  double? salesCgst;
  double? salesSgst;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? metal;

  TaxCreateResponse(
      {this.id,
      this.taxName,
      this.taxCode,
      this.purchaseIgst,
      this.purchaseCgst,
      this.purchaseSgst,
      this.salesIgst,
      this.salesCgst,
      this.salesSgst,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.metal});

  TaxCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxName = json['tax_name'];
    taxCode = json['tax_code'];
    purchaseIgst = json['purchase_igst'];
    purchaseCgst = json['purchase_cgst'];
    purchaseSgst = json['purchase_sgst'];
    salesIgst = json['sales_igst'];
    salesCgst = json['sales_cgst'];
    salesSgst = json['sales_sgst'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    metal = json['metal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax_name'] = this.taxName;
    data['tax_code'] = this.taxCode;
    data['purchase_igst'] = this.purchaseIgst;
    data['purchase_cgst'] = this.purchaseCgst;
    data['purchase_sgst'] = this.purchaseSgst;
    data['sales_igst'] = this.salesIgst;
    data['sales_cgst'] = this.salesCgst;
    data['sales_sgst'] = this.salesSgst;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['metal'] = this.metal;
    return data;
  }
}

class UpdateTaxPayload {
  int? menuId;
  int? id;
  int? metal;
  String? taxName;
  String? taxCode;
  double? purchaseIgst;
  double? purchaseCgst;
  double? purchaseSgst;
  double? salesIgst;
  double? salesCgst;
  double? salesSgst;

  UpdateTaxPayload(
      {this.menuId,
      this.id,
      this.metal,
      this.taxName,
      this.taxCode,
      this.purchaseIgst,
      this.purchaseCgst,
      this.purchaseSgst,
      this.salesIgst,
      this.salesCgst,
      this.salesSgst});

  UpdateTaxPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
    metal = json['metal'];
    taxName = json['tax_name'];
    taxCode = json['tax_code'];
    purchaseIgst = json['purchase_igst'];
    purchaseCgst = json['purchase_cgst'];
    purchaseSgst = json['purchase_sgst'];
    salesIgst = json['sales_igst'];
    salesCgst = json['sales_cgst'];
    salesSgst = json['sales_sgst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    data['metal'] = this.metal;
    data['tax_name'] = this.taxName;
    data['tax_code'] = this.taxCode;
    data['purchase_igst'] = this.purchaseIgst;
    data['purchase_cgst'] = this.purchaseCgst;
    data['purchase_sgst'] = this.purchaseSgst;
    data['sales_igst'] = this.salesIgst;
    data['sales_cgst'] = this.salesCgst;
    data['sales_sgst'] = this.salesSgst;
    return data;
  }
}



class TaxDetailModel {
  int? id;
  String? taxName;
  String? taxCode;
  double? purchaseIgst;
  double? purchaseCgst;
  double? purchaseSgst;
  double? salesIgst;
  double? salesCgst;
  double? salesSgst;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? metal;
  String? metalName;

  TaxDetailModel(
      {this.id,
      this.taxName,
      this.taxCode,
      this.purchaseIgst,
      this.purchaseCgst,
      this.purchaseSgst,
      this.salesIgst,
      this.salesCgst,
      this.salesSgst,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.metal,
      this.metalName});

  TaxDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taxName = json['tax_name'];
    taxCode = json['tax_code'];
    purchaseIgst = json['purchase_igst'];
    purchaseCgst = json['purchase_cgst'];
    purchaseSgst = json['purchase_sgst'];
    salesIgst = json['sales_igst'];
    salesCgst = json['sales_cgst'];
    salesSgst = json['sales_sgst'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    metal = json['metal'];
    metalName = json['metal_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tax_name'] = this.taxName;
    data['tax_code'] = this.taxCode;
    data['purchase_igst'] = this.purchaseIgst;
    data['purchase_cgst'] = this.purchaseCgst;
    data['purchase_sgst'] = this.purchaseSgst;
    data['sales_igst'] = this.salesIgst;
    data['sales_cgst'] = this.salesCgst;
    data['sales_sgst'] = this.salesSgst;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['metal'] = this.metal;
    data['metal_name'] = this.metalName;
    return data;
  }
}