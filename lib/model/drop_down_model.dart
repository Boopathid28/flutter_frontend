class DropdownModel {
  String value;
  String label;

  DropdownModel({required this.value, required this.label});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DropdownModel &&
          runtimeType == other.runtimeType &&
          value == other.value &&
          label == other.label;

  @override
  int get hashCode => value.hashCode ^ label.hashCode;
}

class UserRoleDropdownModel {
  int? id;
  String? roleName;

  UserRoleDropdownModel({this.id, this.roleName});

  UserRoleDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_name'] = this.roleName;
    return data;
  }
}

class MetalDropdownModel {
  int? id;
  String? metalName;

  MetalDropdownModel({this.id, this.metalName});

  MetalDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metalName = json['metal_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal_name'] = this.metalName;
    return data;
  }
}

class PurityDropdownModel {
  int? id;
  int? metal;
  String? metalMetalName;
  String? purityName;
  String? purityCode;
  double? purityPercent;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  double? metalRate;

  PurityDropdownModel(
      {this.id,
      this.metal,
      this.metalMetalName,
      this.purityName,
      this.purityCode,
      this.purityPercent,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.metalRate});

  PurityDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metal = json['metal'];
    metalMetalName = json['metal__metal_name'];
    purityName = json['purity_name'];
    purityCode = json['purity_code'];
    purityPercent = json['purity_percent'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    metalRate = json['metal_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal'] = this.metal;
    data['metal__metal_name'] = this.metalMetalName;
    data['purity_name'] = this.purityName;
    data['purity_code'] = this.purityCode;
    data['purity_percent'] = this.purityPercent;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['metal_rate'] = this.metalRate;
    return data;
  }
}

class CustomergroupDropdownModel {
  int? id;
  String? customerGroup;

  CustomergroupDropdownModel({this.id, this.customerGroup});

  CustomergroupDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerGroup = json['customer_group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_group_name'] = this.customerGroup;
    return data;
  }
}

class DesignerDropdownModel {
  int? id;
  String? designerName;
  String? designerCode;

  DesignerDropdownModel({this.id, this.designerName, this.designerCode});

  DesignerDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    designerName = json['designer_name'];
    designerCode = json['designer_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['designer_name'] = this.designerName;
    data['designer_code'] = this.designerCode;
    return data;
  }
}

class ItemDropdownModel {
  int? id;
  String? itemName;
  String? itemCode;
  double? metalRate;
  double? interGst;
  double? intraGst;

  ItemDropdownModel(
      {this.id,
      this.itemName,
      this.itemCode,
      this.metalRate,
      this.interGst,
      this.intraGst});

  ItemDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    itemCode = json['item_code'];
    metalRate = json['metal_rate'];
    interGst = json['inter_gst'];
    intraGst = json['intra_gst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['item_code'] = this.itemCode;
    data['metal_rate'] = this.metalRate;
    data['inter_gst'] = this.interGst;
    data['intra_gst'] = this.intraGst;
    return data;
  }
}


class SubItemDropdownModel {
  int? id;
  String? subItemName;
  String? subItemCode;
  String? hsnCode;
  String? stockType;
  String? measurementType;
  String? calculationType;
  String? calculationTypeName;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? itemDetails;
  double? minFixedRate;
  double? fixedRate;
  String? wastageCalculationType;
  double? minWastagePercent;
  double? wastagePercent;
  String? flatWastageType;
  double? minFlatWastage;
  double? flatWastage;
  String? makingChargeCalculationType;
  double? minMakingChargePerGram;
  double? makingChargePerGram;
  double? minFlatMakingCharge;
  double? flatMakingCharge;
  String? perGramWeightType;
  double? minPerGramRate;
  double? perGramRate;
  double? minPerPieceRate;
  double? perPieceRate;
  int? subItemDetails;
  String? measurementTypeName;
  double? metalRate;
  double? interGst;
  double? intraGst;

  SubItemDropdownModel(
      {this.id,
      this.subItemName,
      this.subItemCode,
      this.hsnCode,
      this.stockType,
      this.measurementType,
      this.calculationType,
      this.calculationTypeName,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.itemDetails,
      this.minFixedRate,
      this.fixedRate,
      this.wastageCalculationType,
      this.minWastagePercent,
      this.wastagePercent,
      this.flatWastageType,
      this.minFlatWastage,
      this.flatWastage,
      this.makingChargeCalculationType,
      this.minMakingChargePerGram,
      this.makingChargePerGram,
      this.minFlatMakingCharge,
      this.flatMakingCharge,
      this.perGramWeightType,
      this.minPerGramRate,
      this.perGramRate,
      this.minPerPieceRate,
      this.perPieceRate,
      this.subItemDetails,
      this.measurementTypeName,
      this.metalRate,
      this.interGst,
      this.intraGst});

  SubItemDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subItemName = json['sub_item_name'];
    subItemCode = json['sub_item_code'];
    hsnCode = json['hsn_code'];
    stockType = json['stock_type'];
    measurementType = json['measurement_type'];
    calculationType = json['calculation_type'];
    calculationTypeName = json['calculation_type_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    itemDetails = json['item_details'];
    minFixedRate = json['min_fixed_rate'];
    fixedRate = json['fixed_rate'];
    wastageCalculationType = json['wastage_calculation_type'];
    minWastagePercent = json['min_wastage_percent'];
    wastagePercent = json['wastage_percent'];
    flatWastageType = json['flat_wastage_type'];
    minFlatWastage = json['min_flat_wastage'];
    flatWastage = json['flat_wastage'];
    makingChargeCalculationType = json['making_charge_calculation_type'];
    minMakingChargePerGram = json['min_making_charge_per_gram'];
    makingChargePerGram = json['making_charge_per_gram'];
    minFlatMakingCharge = json['min_flat_making_charge'];
    flatMakingCharge = json['flat_making_charge'];
    perGramWeightType = json['per_gram_weight_type'];
    minPerGramRate = json['min_per_gram_rate'];
    perGramRate = json['per_gram_rate'];
    minPerPieceRate = json['min_per_piece_rate'];
    perPieceRate = json['per_piece_rate'];
    subItemDetails = json['sub_item_details'];
    measurementTypeName = json['measurement_type_name'];
    metalRate = json['metal_rate'];
    interGst = json['inter_gst'];
    intraGst = json['intra_gst'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_item_name'] = this.subItemName;
    data['sub_item_code'] = this.subItemCode;
    data['hsn_code'] = this.hsnCode;
    data['stock_type'] = this.stockType;
    data['measurement_type'] = this.measurementType;
    data['calculation_type'] = this.calculationType;
    data['calculation_type_name'] = this.calculationTypeName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['item_details'] = this.itemDetails;
    data['min_fixed_rate'] = this.minFixedRate;
    data['fixed_rate'] = this.fixedRate;
    data['wastage_calculation_type'] = this.wastageCalculationType;
    data['min_wastage_percent'] = this.minWastagePercent;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage_type'] = this.flatWastageType;
    data['min_flat_wastage'] = this.minFlatWastage;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_calculation_type'] = this.makingChargeCalculationType;
    data['min_making_charge_per_gram'] = this.minMakingChargePerGram;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['min_flat_making_charge'] = this.minFlatMakingCharge;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['min_per_gram_rate'] = this.minPerGramRate;
    data['per_gram_rate'] = this.perGramRate;
    data['min_per_piece_rate'] = this.minPerPieceRate;
    data['per_piece_rate'] = this.perPieceRate;
    data['sub_item_details'] = this.subItemDetails;
    data['measurement_type_name'] = this.measurementTypeName;
    data['metal_rate'] = this.metalRate;
    data['inter_gst'] = this.interGst;
    data['intra_gst'] = this.intraGst;
    return data;
  }
}

class StockTypeDropdownModel {
  String? lable;
  String? value;

  StockTypeDropdownModel({this.lable, this.value});

  StockTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class MeasurementTypeDropdownModel {
  String? lable;
  String? value;

  MeasurementTypeDropdownModel({this.lable, this.value});

  MeasurementTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class CalculationTypeDropdownModel {
  String? lable;
  String? value;

  CalculationTypeDropdownModel({this.lable, this.value});

  CalculationTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class WeightTypeDropdownModel {
  String? lable;
  String? value;

  WeightTypeDropdownModel({this.lable, this.value});

  WeightTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class FlatWastageTypeDropdownModel {
  String? lable;
  String? value;

  FlatWastageTypeDropdownModel({this.lable, this.value});

  FlatWastageTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class CounterDropdownModel {
  int? id;
  String? counterName;
  bool? isActive;
  String? createdAt;
  String? createdBy;

  CounterDropdownModel(
      {this.id,
      this.counterName,
      this.isActive,
      this.createdAt,
      this.createdBy});

  CounterDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    counterName = json['counter_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['counter_name'] = this.counterName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    return data;
  }
}

class TagTypeDropdownModel {
  int? id;
  String? tagName;
  String? tagCode;
  int? metal;
  String? metalMetalName;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  TagTypeDropdownModel(
      {this.id,
      this.tagName,
      this.tagCode,
      this.metal,
      this.metalMetalName,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  TagTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagName = json['tag_name'];
    tagCode = json['tag_code'];
    metal = json['metal'];
    metalMetalName = json['metal__metal_name'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag_name'] = this.tagName;
    data['tag_code'] = this.tagCode;
    data['metal'] = this.metal;
    data['metal__metal_name'] = this.metalMetalName;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}

class BranchDropDownModel {
  int? id;
  String? branchName;
  String? branchShortcode;

  BranchDropDownModel({this.id, this.branchName, this.branchShortcode});

  BranchDropDownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    branchName = json['branch_name'];
    branchShortcode = json['branch_shortcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['branch_name'] = this.branchName;
    data['branch_shortcode'] = this.branchShortcode;
    return data;
  }
}

class MarriageDropdownModel {
  String? lable;
  String? value;

  MarriageDropdownModel({this.lable, this.value});

  MarriageDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class EntryTypeDropdownModel {
  String? lable;
  String? value;

  EntryTypeDropdownModel({this.lable, this.value});

  EntryTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class GstTypeDropdownModel {
  String? lable;
  String? value;

  GstTypeDropdownModel({this.lable, this.value});

  GstTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class LotStatusDropdownModel {
  String? lable;
  String? value;

  LotStatusDropdownModel({this.lable, this.value});

  LotStatusDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class LotListDropdownModel {
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

  LotListDropdownModel(
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

  LotListDropdownModel.fromJson(Map<String, dynamic> json) {
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

class LotItemListDropDownModel {
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
  String? itemName;
  int? metal;
  String? metalName;
  int? remainingTagCount;
  int? remainingPieces;
  double? remainingGrossWeight;

  LotItemListDropDownModel(
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
      this.itemName,
      this.metal,
      this.metalName,
      this.remainingTagCount,
      this.remainingPieces,
      this.remainingGrossWeight});

  LotItemListDropDownModel.fromJson(Map<String, dynamic> json) {
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
    itemName = json['item_name'];
    metal = json['metal'];
    metalName = json['metal_name'];
    remainingTagCount = json['remaining_tag_count'];
    remainingPieces = json['remaining_pieces'];
    remainingGrossWeight = json['remaining_gross_weight'];
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
    data['item_name'] = this.itemName;
    data['metal'] = this.metal;
    data['metal_name'] = this.metalName;
    data['remaining_tag_count'] = this.remainingTagCount;
    data['remaining_pieces'] = this.remainingPieces;
    data['remaining_gross_weight'] = this.remainingGrossWeight;
    return data;
  }
}

class FloorDropdownModel {
  int? id;
  String? floorName;
  bool? isActive;
  String? branchName;
  int? branch;

  FloorDropdownModel(
      {this.id, this.floorName, this.isActive, this.branchName, this.branch});

  FloorDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    floorName = json['floor_name'];
    isActive = json['is_active'];
    branchName = json['branch_name'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['floor_name'] = this.floorName;
    data['is_active'] = this.isActive;
    data['branch_name'] = this.branchName;
    data['branch'] = this.branch;
    return data;
  }
}

class StoneDropdownModel {
  int? id;
  String? stoneName;
  String? stoneCode;
  double? rate;
  double? certificateAmount;
  late bool reduceWeight;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
 
  StoneDropdownModel(
      {this.id,
      this.stoneName,
      this.stoneCode,
      this.rate,
      this.certificateAmount,
      required this.reduceWeight,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});
 
  StoneDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stoneName = json['stone_name'];
    stoneCode = json['stone_code'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
    reduceWeight = json['reduce_weight'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stone_name'] = this.stoneName;
    data['stone_code'] = this.stoneCode;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['reduce_weight'] = this.reduceWeight;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}
 
class DiamondDropdownModel {
  int? id;
  String? diamondName;
  String? diamondCode;
  double? rate;
  double? certificateAmount;
  late bool reduceWeight;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
 
  DiamondDropdownModel(
      {this.id,
      this.diamondName,
      this.diamondCode,
      this.rate,
      this.certificateAmount,
      required this.reduceWeight,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});
 
  DiamondDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diamondName = json['diamond_name'];
    diamondCode = json['diamond_code'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
    reduceWeight = json['reduce_weight'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['diamond_name'] = this.diamondName;
    data['diamond_code'] = this.diamondCode;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['reduce_weight'] = this.reduceWeight;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}

class CustomerDropDownModel {
  int? id;
  String? customerName;
  int? customerGroup;
  String? customerGroupCustomerGroupName;
  String? email;
  String? mobileNumber;
  String? dob;

  CustomerDropDownModel(
      {this.id,
      this.customerName,
      this.customerGroup,
      this.customerGroupCustomerGroupName,
      this.email,
      this.mobileNumber,
      this.dob});

  CustomerDropDownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    customerGroup = json['customer_group'];
    customerGroupCustomerGroupName =
        json['customer_group__customer_group_name'];
    email = json['email'];
    mobileNumber = json['mobile_number'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['customer_group'] = this.customerGroup;
    data['customer_group__customer_group_name'] =
        this.customerGroupCustomerGroupName;
    data['email'] = this.email;
    data['mobile_number'] = this.mobileNumber;
    data['dob'] = this.dob;
    return data;
  }
}

class OldMetalDropdownModel {
  int? id;
  String? oldRate;
  int? metalDetails;
  String? metalDetailsName;
  String? interGst;
  String? intraGst;

  OldMetalDropdownModel(
      {this.id,
      this.oldRate,
      this.metalDetails,
      this.metalDetailsName,
      this.interGst,
      this.intraGst});

  OldMetalDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldRate = json['old_rate'].toString();
    metalDetails = json['metal_details'];
    metalDetailsName = json['metal_details_name'];
    interGst = json['inter_gst'].toString();
    intraGst = json['intra_gst'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_rate'] = this.oldRate;
    data['metal_details'] = this.metalDetails;
    data['metal_details_name'] = this.metalDetailsName;
    data['inter_gst'] = this.interGst;
    data['intra_gst'] = this.intraGst;
    return data;
  }
}

class TransactionTypeDropdownModel {
  String? lable;
  String? value;

  TransactionTypeDropdownModel({this.lable, this.value});

  TransactionTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class StockTypeLedgerDropdownModel {
  String? lable;
  String? value;
 
  StockTypeLedgerDropdownModel({this.lable, this.value});
 
  StockTypeLedgerDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}




class CatalogDropdownModel {
  int? id;
  String? catalogNumber;
  double? catalogWeight;

  CatalogDropdownModel({this.id, this.catalogNumber, this.catalogWeight});

  CatalogDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catalogNumber = json['catalog_number'];
    catalogWeight = json['catalog_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catalog_number'] = this.catalogNumber;
    data['catalog_weight'] = this.catalogWeight;
    return data;
  }
}






class TagNumberDropdownModel {
  int? id;
  String? tagNumber;

  TagNumberDropdownModel({this.id, this.tagNumber});

  TagNumberDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagNumber = json['tag_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag_number'] = this.tagNumber;
    return data;
  }
}




class PaymentMethodDropDown {
  String? lable;
  String? value;
 
  PaymentMethodDropDown({this.lable, this.value});
 
  PaymentMethodDropDown.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}
 
class PaymentProviderDropDown {
  String? lable;
  String? value;
 
  PaymentProviderDropDown({this.lable, this.value});
 
  PaymentProviderDropDown.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class BagDropDownModel {
  int? id;
  String? bagNumber;
  int? totalItem;
  double? totalGrossWeight;
  double? totalNetWeight;
  double? totalDustWeight;
 
  BagDropDownModel(
      {this.id,
      this.bagNumber,
      this.totalItem,
      this.totalGrossWeight,
      this.totalNetWeight,
      this.totalDustWeight});
 
  BagDropDownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bagNumber = json['bag_number'];
    totalItem = json['total_item'];
    totalGrossWeight = json['total_gross_weight'];
    totalNetWeight = json['total_net_weight'];
    totalDustWeight = json['total_dust_weight'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bag_number'] = this.bagNumber;
    data['total_item'] = this.totalItem;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['total_net_weight'] = this.totalNetWeight;
    data['total_dust_weight'] = this.totalDustWeight;
    return data;
  }
}

class ExpenseDropDown {
  int? id;
  String? expensesName;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
 
  ExpenseDropDown(
      {this.id,
      this.expensesName,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});
 
  ExpenseDropDown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expensesName = json['expenses_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expenses_name'] = this.expensesName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}

class AdvancePurposeDropdownmodel {
  String? lable;
  String? value;
 
  AdvancePurposeDropdownmodel({this.lable, this.value});
 
  AdvancePurposeDropdownmodel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class ExpenseclassificationDropDownModel {
  String? lable;
  String? value;
 
  ExpenseclassificationDropDownModel({this.lable, this.value});
 
  ExpenseclassificationDropDownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class ExpensetypeDropDownModel {
  String? lable;
  String? value;
 
  ExpensetypeDropDownModel({this.lable, this.value});
 
  ExpensetypeDropDownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class SubExpenseDropDownModel {
  int? id;
  int? expenses;
  String? expensesExpensesName;
  String? subExpensesName;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
 
  SubExpenseDropDownModel(
      {this.id,
      this.expenses,
      this.expensesExpensesName,
      this.subExpensesName,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});
 
  SubExpenseDropDownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenses = json['expenses'];
    expensesExpensesName = json['expenses__expenses_name'];
    subExpensesName = json['sub_expenses_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expenses'] = this.expenses;
    data['expenses__expenses_name'] = this.expensesExpensesName;
    data['sub_expenses_name'] = this.subExpensesName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}

class SalesExpensetypeDropDownModel {
  String? lable;
  String? value;
 
  SalesExpensetypeDropDownModel({this.lable, this.value});
 
  SalesExpensetypeDropDownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class CatalogTypeDropdownModel {
  String? lable;
  String? value;

  CatalogTypeDropdownModel({this.lable, this.value});

  CatalogTypeDropdownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class GenderDropDownModel {
  String? lable;
  String? value;
 
  GenderDropDownModel({this.lable, this.value});
 
  GenderDropDownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class PriorityDropDown {
  String? lable;
  String? value;
 
  PriorityDropDown({this.lable, this.value});
 
  PriorityDropDown.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class OldMetalTouchDropDownModel {
  double? touch;
  double? inWeight;
  double? outWeight;
  double? remainingWeight;

  OldMetalTouchDropDownModel(
      {this.touch, this.inWeight, this.outWeight, this.remainingWeight});

  OldMetalTouchDropDownModel.fromJson(Map<String, dynamic> json) {
    touch = json['touch'];
    inWeight = json['in_weight'];
    outWeight = json['out_weight'];
    remainingWeight = json['remaining_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['touch'] = this.touch;
    data['in_weight'] = this.inWeight;
    data['out_weight'] = this.outWeight;
    data['remaining_weight'] = this.remainingWeight;
    return data;
  }
}

class TouchDropdownModel {
  double? touch;
  double? inWeight;
  double? outWeight;
  double? remainingWeight;
 
  TouchDropdownModel(
      {this.touch, this.inWeight, this.outWeight, this.remainingWeight});
 
  TouchDropdownModel.fromJson(Map<String, dynamic> json) {
    touch = json['touch'];
    inWeight = json['in_weight'];
    outWeight = json['out_weight'];
    remainingWeight = json['remaining_weight'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['touch'] = this.touch;
    data['in_weight'] = this.inWeight;
    data['out_weight'] = this.outWeight;
    data['remaining_weight'] = this.remainingWeight;
    return data;
  }
}

class oldledgerentrytypeDropDownModel {
  String? lable;
  String? value;
 
  oldledgerentrytypeDropDownModel({this.lable, this.value});
 
  oldledgerentrytypeDropDownModel.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}

class RepairTypeDropDown {
  int? id;
  String? repairType;

  RepairTypeDropDown({this.id, this.repairType, });

  RepairTypeDropDown.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repairType = json['repair_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['repair_type'] = repairType;
    return data;
  }
}

class MeltingDropDownModel {
  int? id;
  String? meltingId;
  double? receivedWeight;

  MeltingDropDownModel({this.id, this.meltingId, this.receivedWeight});

  MeltingDropDownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meltingId = json['melting_id'];
    receivedWeight = json['received_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['melting_id'] = this.meltingId;
    data['received_weight'] = this.receivedWeight;
    return data;
  }
}

class CatalogVerificationTypeDropdown {
  String? lable;
  String? value;
 
  CatalogVerificationTypeDropdown({this.lable, this.value});
 
  CatalogVerificationTypeDropdown.fromJson(Map<String, dynamic> json) {
    lable = json['lable'];
    value = json['value'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lable'] = this.lable;
    data['value'] = this.value;
    return data;
  }
}





class BillMetalDropdownModel {
  int? id;
  String? metalName;

  BillMetalDropdownModel({this.id, this.metalName});

  BillMetalDropdownModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metalName = json['metal_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal_name'] = this.metalName;
    return data;
  }
}