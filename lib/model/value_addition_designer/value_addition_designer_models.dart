class FetchValueAdditionListPayload {
  int? menuId;
  String? designer;
  String? subItem;
  int? page;
  int? itemsPerPage;
  String? search;

  FetchValueAdditionListPayload(
      {this.menuId,
      this.designer,
      this.subItem,
      this.page,
      this.itemsPerPage,
      this.search});

  FetchValueAdditionListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    designer = json['designer'];
    subItem = json['sub_item'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['designer'] = this.designer;
    data['sub_item'] = this.subItem;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['search'] = this.search;
    return data;
  }
}

class ValueAdditionListData {
  int? id;
  String? calculationType;
  double? touch;
  double? fixedRate;
  String? wastageCalculationType;
  double? wastagePercent;
  String? flatWastageType;
  double? flatWastage;
  String? makingChargeCalculationType;
  double? makingChargePerGram;
  double? flatMakingCharge;
  String? perGramWeightType;
  double? perGramRate;
  double? perPieceRate;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? designerDetails;
  int? subItemDetails;
  String? designerName;
  String? subItemName;
  int? sNo;

  ValueAdditionListData(
      {this.id,
      this.calculationType,
      this.touch,
      this.fixedRate,
      this.wastageCalculationType,
      this.wastagePercent,
      this.flatWastageType,
      this.flatWastage,
      this.makingChargeCalculationType,
      this.makingChargePerGram,
      this.flatMakingCharge,
      this.perGramWeightType,
      this.perGramRate,
      this.perPieceRate,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.designerDetails,
      this.subItemDetails,
      this.designerName,
      this.subItemName,
      this.sNo});

  ValueAdditionListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    calculationType = json['calculation_type'];
    touch = json['touch'];
    fixedRate = json['fixed_rate'];
    wastageCalculationType = json['wastage_calculation_type'];
    wastagePercent = json['wastage_percent'];
    flatWastageType = json['flat_wastage_type'];
    flatWastage = json['flat_wastage'];
    makingChargeCalculationType = json['making_charge_calculation_type'];
    makingChargePerGram = json['making_charge_per_gram'];
    flatMakingCharge = json['flat_making_charge'];
    perGramWeightType = json['per_gram_weight_type'];
    perGramRate = json['per_gram_rate'];
    perPieceRate = json['per_piece_rate'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    designerDetails = json['designer_details'];
    subItemDetails = json['sub_item_details'];
    designerName = json['designer_name'];
    subItemName = json['sub_item_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['calculation_type'] = this.calculationType;
    data['touch'] = this.touch;
    data['fixed_rate'] = this.fixedRate;
    data['wastage_calculation_type'] = this.wastageCalculationType;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage_type'] = this.flatWastageType;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_calculation_type'] = this.makingChargeCalculationType;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['per_gram_rate'] = this.perGramRate;
    data['per_piece_rate'] = this.perPieceRate;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['designer_details'] = this.designerDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['designer_name'] = this.designerName;
    data['sub_item_name'] = this.subItemName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class CreateValueAdditionDesignerPayload {
  int? menuId;
  String? designerDetails;
  String? subItemDetails;
  String? calculationType;
  String? fixedRate;
  String? touch;
  String? wastageCalculationType;
  String? wastagePercent;
  String? flatWastageType;
  String? flatWastage;
  String? makingChargeCalculationType;
  String? makingChargePerGram;
  String? flatMakingCharge;
  String? perGramWeightType;
  String? perGramRate;
  String? perPieceRate;

  CreateValueAdditionDesignerPayload(
      {this.menuId,
      this.designerDetails,
      this.subItemDetails,
      this.calculationType,
      this.fixedRate,
      this.touch,
      this.wastageCalculationType,
      this.wastagePercent,
      this.flatWastageType,
      this.flatWastage,
      this.makingChargeCalculationType,
      this.makingChargePerGram,
      this.flatMakingCharge,
      this.perGramWeightType,
      this.perGramRate,
      this.perPieceRate});

  CreateValueAdditionDesignerPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    designerDetails = json['designer_details'];
    subItemDetails = json['sub_item_details'];
    calculationType = json['calculation_type'];
    fixedRate = json['fixed_rate'];
    touch = json['touch'];
    wastageCalculationType = json['wastage_calculation_type'];
    wastagePercent = json['wastage_percent'];
    flatWastageType = json['flat_wastage_type'];
    flatWastage = json['flat_wastage'];
    makingChargeCalculationType = json['making_charge_calculation_type'];
    makingChargePerGram = json['making_charge_per_gram'];
    flatMakingCharge = json['flat_making_charge'];
    perGramWeightType = json['per_gram_weight_type'];
    perGramRate = json['per_gram_rate'];
    perPieceRate = json['per_piece_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['designer_details'] = this.designerDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['calculation_type'] = this.calculationType;
    data['fixed_rate'] = this.fixedRate;
    data['touch'] = this.touch;
    data['wastage_calculation_type'] = this.wastageCalculationType;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage_type'] = this.flatWastageType;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_calculation_type'] = this.makingChargeCalculationType;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['per_gram_rate'] = this.perGramRate;
    data['per_piece_rate'] = this.perPieceRate;
    return data;
  }
}


class CreateValueAdditionDesignerresponse {
  int? id;
  String? calculationType;
  double? touch;
  double? fixedRate;
  String? wastageCalculationType;
  double? wastagePercent;
  String? flatWastageType;
  double? flatWastage;
  String? makingChargeCalculationType;
  double? makingChargePerGram;
  double? flatMakingCharge;
  String? perGramWeightType;
  double? perGramRate;
  double? perPieceRate;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? designerDetails;
  int? subItemDetails;

  CreateValueAdditionDesignerresponse(
      {this.id,
      this.calculationType,
      this.touch,
      this.fixedRate,
      this.wastageCalculationType,
      this.wastagePercent,
      this.flatWastageType,
      this.flatWastage,
      this.makingChargeCalculationType,
      this.makingChargePerGram,
      this.flatMakingCharge,
      this.perGramWeightType,
      this.perGramRate,
      this.perPieceRate,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.designerDetails,
      this.subItemDetails});

  CreateValueAdditionDesignerresponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    calculationType = json['calculation_type'];
    touch = json['touch'];
    fixedRate = json['fixed_rate'];
    wastageCalculationType = json['wastage_calculation_type'];
    wastagePercent = json['wastage_percent'];
    flatWastageType = json['flat_wastage_type'];
    flatWastage = json['flat_wastage'];
    makingChargeCalculationType = json['making_charge_calculation_type'];
    makingChargePerGram = json['making_charge_per_gram'];
    flatMakingCharge = json['flat_making_charge'];
    perGramWeightType = json['per_gram_weight_type'];
    perGramRate = json['per_gram_rate'];
    perPieceRate = json['per_piece_rate'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    designerDetails = json['designer_details'];
    subItemDetails = json['sub_item_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['calculation_type'] = this.calculationType;
    data['touch'] = this.touch;
    data['fixed_rate'] = this.fixedRate;
    data['wastage_calculation_type'] = this.wastageCalculationType;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage_type'] = this.flatWastageType;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_calculation_type'] = this.makingChargeCalculationType;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['per_gram_rate'] = this.perGramRate;
    data['per_piece_rate'] = this.perPieceRate;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['designer_details'] = this.designerDetails;
    data['sub_item_details'] = this.subItemDetails;
    return data;
  }
}






class ValueAdditionDesignerDetailsData {
  int? id;
  String? calculationType;
  double? touch;
  double? fixedRate;
  String? wastageCalculationType;
  double? wastagePercent;
  String? flatWastageType;
  double? flatWastage;
  String? makingChargeCalculationType;
  double? makingChargePerGram;
  double? flatMakingCharge;
  String? perGramWeightType;
  double? perGramRate;
  double? perPieceRate;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? designerDetails;
  int? subItemDetails;
  String? designerDetailsName;
  String? subItemDetailsName;
  String? calculationTypeName;
  String? wastageCalculationTypeName;
  String? flatWastageTypeName;
  String? makingChargeCalculationTypeName;
  String? perGramWeightTypeName;

  ValueAdditionDesignerDetailsData(
      {this.id,
      this.calculationType,
      this.touch,
      this.fixedRate,
      this.wastageCalculationType,
      this.wastagePercent,
      this.flatWastageType,
      this.flatWastage,
      this.makingChargeCalculationType,
      this.makingChargePerGram,
      this.flatMakingCharge,
      this.perGramWeightType,
      this.perGramRate,
      this.perPieceRate,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.designerDetails,
      this.subItemDetails,
      this.designerDetailsName,
      this.subItemDetailsName,
      this.calculationTypeName,
      this.wastageCalculationTypeName,
      this.flatWastageTypeName,
      this.makingChargeCalculationTypeName,
      this.perGramWeightTypeName});

  ValueAdditionDesignerDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    calculationType = json['calculation_type'];
    touch = json['touch'];
    fixedRate = json['fixed_rate'];
    wastageCalculationType = json['wastage_calculation_type'];
    wastagePercent = json['wastage_percent'];
    flatWastageType = json['flat_wastage_type'];
    flatWastage = json['flat_wastage'];
    makingChargeCalculationType = json['making_charge_calculation_type'];
    makingChargePerGram = json['making_charge_per_gram'];
    flatMakingCharge = json['flat_making_charge'];
    perGramWeightType = json['per_gram_weight_type'];
    perGramRate = json['per_gram_rate'];
    perPieceRate = json['per_piece_rate'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    designerDetails = json['designer_details'];
    subItemDetails = json['sub_item_details'];
    designerDetailsName = json['designer_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    calculationTypeName = json['calculation_type_name'];
    wastageCalculationTypeName = json['wastage_calculation_type_name'];
    flatWastageTypeName = json['flat_wastage_type_name'];
    makingChargeCalculationTypeName =
        json['making_charge_calculation_type_name'];
    perGramWeightTypeName = json['per_gram_weight_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['calculation_type'] = this.calculationType;
    data['touch'] = this.touch;
    data['fixed_rate'] = this.fixedRate;
    data['wastage_calculation_type'] = this.wastageCalculationType;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage_type'] = this.flatWastageType;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_calculation_type'] = this.makingChargeCalculationType;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['per_gram_rate'] = this.perGramRate;
    data['per_piece_rate'] = this.perPieceRate;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['designer_details'] = this.designerDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['designer_details_name'] = this.designerDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['calculation_type_name'] = this.calculationTypeName;
    data['wastage_calculation_type_name'] = this.wastageCalculationTypeName;
    data['flat_wastage_type_name'] = this.flatWastageTypeName;
    data['making_charge_calculation_type_name'] =
        this.makingChargeCalculationTypeName;
    data['per_gram_weight_type_name'] = this.perGramWeightTypeName;
    return data;
  }
}





class UpdateValueAdditionDesignerPayload {
  int? id;
  int? menuId;
  int? designerDetails;
  int? subItemDetails;
  String? calculationType;
  String? fixedRate;
  String? touch;
  String? wastageCalculationType;
  String? wastagePercent;
  String? flatWastageType;
  String? flatWastage;
  String? makingChargeCalculationType;
  String? makingChargePerGram;
  String? flatMakingCharge;
  String? perGramWeightType;
  String? perGramRate;
  String? perPieceRate;

  UpdateValueAdditionDesignerPayload(
      {this.id,
      this.menuId,
      this.designerDetails,
      this.subItemDetails,
      this.calculationType,
      this.fixedRate,
      this.touch,
      this.wastageCalculationType,
      this.wastagePercent,
      this.flatWastageType,
      this.flatWastage,
      this.makingChargeCalculationType,
      this.makingChargePerGram,
      this.flatMakingCharge,
      this.perGramWeightType,
      this.perGramRate,
      this.perPieceRate});

  UpdateValueAdditionDesignerPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    designerDetails = json['designer_details'];
    subItemDetails = json['sub_item_details'];
    calculationType = json['calculation_type'];
    fixedRate = json['fixed_rate'];
    touch = json['touch'];
    wastageCalculationType = json['wastage_calculation_type'];
    wastagePercent = json['wastage_percent'];
    flatWastageType = json['flat_wastage_type'];
    flatWastage = json['flat_wastage'];
    makingChargeCalculationType = json['making_charge_calculation_type'];
    makingChargePerGram = json['making_charge_per_gram'];
    flatMakingCharge = json['flat_making_charge'];
    perGramWeightType = json['per_gram_weight_type'];
    perGramRate = json['per_gram_rate'];
    perPieceRate = json['per_piece_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['designer_details'] = this.designerDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['calculation_type'] = this.calculationType;
    data['fixed_rate'] = this.fixedRate;
    data['touch'] = this.touch;
    data['wastage_calculation_type'] = this.wastageCalculationType;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage_type'] = this.flatWastageType;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_calculation_type'] = this.makingChargeCalculationType;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['per_gram_rate'] = this.perGramRate;
    data['per_piece_rate'] = this.perPieceRate;
    return data;
  }
}
