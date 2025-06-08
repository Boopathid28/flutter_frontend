class RetrieveTagDetails {
  int? id;
  String? tagNumber;
  String? measurementValue;
  double? catalogueCoverWeight;
  String? huid;
  String? remark;
  int? pieces;
  double? grossWeight;
  double? reduceWeight;
  double? netWeight;
  int? availablePieces;
  double? availableGrossWeight;
  double? availableNetWeight;
  int? totalStonePieces;
  double? totalStoneWeight;
  double? totalStoneAmount;
  int? totalDiamondPieces;
  double? totalDiamondWeight;
  double? totalDiamondAmount;
  bool? isBilled;
  Null? billedAt;
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
  String? branchName;
  int? tagEntryDetails;
  int? lotItemDetails;
  int? subItemDetails;
  int? tagType;
  int? branch;
  String? wastageCalculationTypeName;
  String? flatWastageTypeName;
  String? makingChargeCalculationTypeName;
  String? perGramWeightTypeName;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? tagTypeName;
  String? tagTypeCode;
  String? calculationType;
  int? metalDetails;
  String? metalDetailsName;
  double? minInterGstValue;
  double? interGstValue;
  double? minIntraGstValue;
  double? intraGstValue;
  double? minInterSaleValue;
  double? minIntraSaleValue;
  double? interSaleValue;
  double? intraSaleValue;
  List<TagStoneDetails>? stoneDetails;
  List<TagDiamondDetails>? diamondDetails;

  RetrieveTagDetails(
      {this.id,
      this.tagNumber,
      this.measurementValue,
      this.huid,
      this.remark,
      this.pieces,
      this.grossWeight,
      this.catalogueCoverWeight,
      this.reduceWeight,
      this.netWeight,
      this.availablePieces,
      this.availableGrossWeight,
      this.availableNetWeight,
      this.totalStonePieces,
      this.totalStoneWeight,
      this.totalStoneAmount,
      this.totalDiamondPieces,
      this.totalDiamondWeight,
      this.totalDiamondAmount,
      this.isBilled,
      this.billedAt,
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
      this.branchName,
      this.tagEntryDetails,
      this.lotItemDetails,
      this.subItemDetails,
      this.tagType,
      this.branch,
      this.wastageCalculationTypeName,
      this.flatWastageTypeName,
      this.makingChargeCalculationTypeName,
      this.perGramWeightTypeName,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.tagTypeName,
      this.tagTypeCode,
      this.calculationType,
      this.metalDetails,
      this.metalDetailsName,
      this.minInterGstValue,
      this.interGstValue,
      this.minIntraGstValue,
      this.intraGstValue,
      this.minInterSaleValue,
      this.minIntraSaleValue,
      this.interSaleValue,
      this.intraSaleValue,
      this.stoneDetails,
      this.diamondDetails});

  RetrieveTagDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagNumber = json['tag_number'];
    measurementValue = json['measurement_value'];
    catalogueCoverWeight = json['catalogue_cover_weight'];
    huid = json['huid'];
    remark = json['remark'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    reduceWeight = json['reduce_weight'];
    netWeight = json['net_weight'];
    availablePieces = json['available_pieces'];
    availableGrossWeight = json['available_gross_weight'];
    availableNetWeight = json['available_net_weight'];
    totalStonePieces = json['total_stone_pieces'];
    totalStoneWeight = json['total_stone_weight'];
    totalStoneAmount = json['total_stone_amount'];
    totalDiamondPieces = json['total_diamond_pieces'];
    totalDiamondWeight = json['total_diamond_weight'];
    totalDiamondAmount = json['total_diamond_amount'];
    isBilled = json['is_billed'];
    billedAt = json['billed_at'];
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
    branchName = json['branch_name'];
    tagEntryDetails = json['tag_entry_details'];
    lotItemDetails = json['lot_item_details'];
    subItemDetails = json['sub_item_details'];
    tagType = json['tag_type'];
    branch = json['branch'];
    wastageCalculationTypeName = json['wastage_calculation_type_name'];
    flatWastageTypeName = json['flat_wastage_type_name'];
    makingChargeCalculationTypeName =
        json['making_charge_calculation_type_name'];
    perGramWeightTypeName = json['per_gram_weight_type_name'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    tagTypeName = json['tag_type_name'];
    tagTypeCode = json['tag_type_code'];
    calculationType = json['calculation_type'];
    metalDetails = json['metal_details'];
    metalDetailsName = json['metal_details_name'];
    minInterGstValue = json['min_inter_gst_value'];
    interGstValue = json['inter_gst_value'];
    minIntraGstValue = json['min_intra_gst_value'];
    intraGstValue = json['intra_gst_value'];
    minInterSaleValue = json['min_inter_sale_value'];
    minIntraSaleValue = json['min_intra_sale_value'];
    interSaleValue = json['inter_sale_value'];
    intraSaleValue = json['intra_sale_value'];
    if (json['stone_details'] != null) {
      stoneDetails = <TagStoneDetails>[];
      json['stone_details'].forEach((v) {
        stoneDetails!.add(new TagStoneDetails.fromJson(v));
      });
    }
    if (json['diamond_details'] != null) {
      diamondDetails = <TagDiamondDetails>[];
      json['diamond_details'].forEach((v) {
        diamondDetails!.add(new TagDiamondDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag_number'] = this.tagNumber;
    data['measurement_value'] = this.measurementValue;
    data['catalogue_cover_weight'] = this.catalogueCoverWeight;
    data['huid'] = this.huid;
    data['remark'] = this.remark;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
    data['available_pieces'] = this.availablePieces;
    data['available_gross_weight'] = this.availableGrossWeight;
    data['available_net_weight'] = this.availableNetWeight;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_stone_weight'] = this.totalStoneWeight;
    data['total_stone_amount'] = this.totalStoneAmount;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    data['total_diamond_weight'] = this.totalDiamondWeight;
    data['total_diamond_amount'] = this.totalDiamondAmount;
    data['is_billed'] = this.isBilled;
    data['billed_at'] = this.billedAt;
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
    data['branch_name'] = this.branchName;
    data['tag_entry_details'] = this.tagEntryDetails;
    data['lot_item_details'] = this.lotItemDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['tag_type'] = this.tagType;
    data['branch'] = this.branch;
    data['wastage_calculation_type_name'] = this.wastageCalculationTypeName;
    data['flat_wastage_type_name'] = this.flatWastageTypeName;
    data['making_charge_calculation_type_name'] =
        this.makingChargeCalculationTypeName;
    data['per_gram_weight_type_name'] = this.perGramWeightTypeName;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['tag_type_name'] = this.tagTypeName;
    data['tag_type_code'] = this.tagTypeCode;
    data['calculation_type'] = this.calculationType;
    data['metal_details'] = this.metalDetails;
    data['metal_details_name'] = this.metalDetailsName;
    data['min_inter_gst_value'] = this.minInterGstValue;
    data['inter_gst_value'] = this.interGstValue;
    data['min_intra_gst_value'] = this.minIntraGstValue;
    data['intra_gst_value'] = this.intraGstValue;
    data['min_inter_sale_value'] = this.minInterSaleValue;
    data['min_intra_sale_value'] = this.minIntraSaleValue;
    data['inter_sale_value'] = this.interSaleValue;
    data['intra_sale_value'] = this.intraSaleValue;
    if (this.stoneDetails != null) {
      data['stone_details'] =
          this.stoneDetails!.map((v) => v.toJson()).toList();
    }
    if (this.diamondDetails != null) {
      data['diamond_details'] =
          this.diamondDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TagStoneDetails {
  String? id;
  bool? reduceWeight;
  int? stonePieces;
  double? stoneWeight;
  double? stoneAmount;
  double? rate;
  double? certificateAmount;
  int? stone;
  String? stoneName;
  bool? isDb;
 
  TagStoneDetails(
      {
      this.id,
      this.reduceWeight,
      this.stonePieces,
      this.stoneWeight,
      this.rate,
      this.certificateAmount,
      this.stoneAmount,
      this.stone,
      this.stoneName,
      this.isDb,});
 
  TagStoneDetails.fromJson(Map<String, dynamic> json) {
    
    id = json['id'].toString();
    reduceWeight = json['reduce_weight'];
    stonePieces = json['stone_pieces'];
    stoneWeight = json['stone_weight'];
    stoneAmount = json['stone_amount'];
    certificateAmount = json['certificate_amount'];
    rate = json['rate'];
    stone = json['stone'];
    stoneName = json['stone_name'];
    isDb = json['is_db'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['id'] = this.id;
    data['reduce_weight'] = this.reduceWeight;
    data['stone_pieces'] = this.stonePieces;
    data['stone_weight'] = this.stoneWeight;
    data['stone_amount'] = this.stoneAmount;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['stone'] = this.stone;
    data['stone_name'] = this.stoneName;
    data['is_db'] = this.isDb;
    return data;
  }
}
 
class TagDiamondDetails {
  String? id;
  bool? reduceWeight;
  int? diamondPieces;
  double? diamondWeight;
  double? diamondAmount;
  double? certificateAmount;
  double? rate;
  int? diamond;
  String? diamondName;
  bool? isDb;
 
  TagDiamondDetails(
      {
      this.id,
      this.reduceWeight,
      this.diamondPieces,
      this.diamondWeight,
      this.diamondAmount,
      this.rate,
      this.certificateAmount,
      this.diamond,
      this.diamondName,
      this.isDb,});
 
  TagDiamondDetails.fromJson(Map<String, dynamic> json) {
    
    id = json['id'].toString();
    reduceWeight = json['reduce_weight'];
    diamondPieces = json['diamond_pieces'];
    diamondWeight = json['diamond_weight'];
    diamondAmount = json['diamond_amount'];
    certificateAmount = json['certificate_amount'];
    rate = json['rate'];
    diamond = json['diamond'];
    diamondName = json['diamond_name'];
    isDb = json['is_db'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    
    data['id'] = this.id;
    data['reduce_weight'] = this.reduceWeight;
    data['diamond_pieces'] = this.diamondPieces;
    data['diamond_weight'] = this.diamondWeight;
    data['diamond_amount'] = this.diamondAmount;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['diamond'] = this.diamond;
    data['diamond_name'] = this.diamondName;
    data['is_db'] = this.isDb;
    return data;
  }
}


class SingleTagUpdatePayload {
  String? tagNumber;
  int? menuId;
  String? tagType;
  String? measurementValue;
  double? catalogueCoverWeight;
  String? huid;
  String? remark;
  double? reduceWeight;
  double? netWeight;
  double? grossWeight;
  int? pieces;
  int? totalStonePieces;
  double? totalStoneWeight;
  double? totalStoneAmount;
  int? totalDiamondPieces;
  double? totalDiamondWeight;
  double? totalDiamondAmount;
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
  List<TagStoneDetails>? stoneDetails;
  List<TagDiamondDetails>? diamondDetails;
  List<String>? deleteStone;
  List<String>? deleteDiamond;

  SingleTagUpdatePayload(
      {this.tagNumber,
      this.menuId,
      this.tagType,
      this.measurementValue,
      this.huid,
      this.remark,
      this.reduceWeight,
      this.catalogueCoverWeight,
      this.netWeight,
      this.grossWeight,
      this.pieces,
      this.totalStonePieces,
      this.totalStoneWeight,
      this.totalStoneAmount,
      this.totalDiamondPieces,
      this.totalDiamondWeight,
      this.totalDiamondAmount,
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
      this.stoneDetails,
      this.diamondDetails,
      this.deleteStone,
      this.deleteDiamond});

  SingleTagUpdatePayload.fromJson(Map<String, dynamic> json) {
    tagNumber = json['tag_number'];
    menuId = json['menu_id'];
    tagType = json['tag_type'];
    measurementValue = json['measurement_value'];
    catalogueCoverWeight = json['catalogue_cover_weight'];
    huid = json['huid'];
    remark = json['remark'];
    reduceWeight = json['reduce_weight'];
    netWeight = json['net_weight'];
    grossWeight = json['gross_weight'];
    pieces = json['pieces'];
    totalStonePieces = json['total_stone_pieces'];
    totalStoneWeight = json['total_stone_weight'];
    totalStoneAmount = json['total_stone_amount'];
    totalDiamondPieces = json['total_diamond_pieces'];
    totalDiamondWeight = json['total_diamond_weight'];
    totalDiamondAmount = json['total_diamond_amount'];
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
    deleteStone = json['delete_stone'];
    deleteDiamond = json['delete_diamond'];
    if (json['stone_details'] != null) {
      stoneDetails = <TagStoneDetails>[];
      json['stone_details'].forEach((v) {
        stoneDetails!.add(new TagStoneDetails.fromJson(v));
      });
    }
    if (json['diamond_details'] != null) {
      diamondDetails = <TagDiamondDetails>[];
      json['diamond_details'].forEach((v) {
        diamondDetails!.add(new TagDiamondDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_number'] = this.tagNumber;
    data['menu_id'] = this.menuId;
    data['tag_type'] = this.tagType;
    data['measurement_value'] = this.measurementValue;
    data['catalogue_cover_weight'] = this.catalogueCoverWeight;
    data['huid'] = this.huid;
    data['remark'] = this.remark;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_stone_weight'] = this.totalStoneWeight;
    data['total_stone_amount'] = this.totalStoneAmount;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    data['total_diamond_weight'] = this.totalDiamondWeight;
    data['total_diamond_amount'] = this.totalDiamondAmount;
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
    data['delete_stone'] = this.deleteStone;
    data['delete_diamond'] = this.deleteDiamond;
    if (this.stoneDetails != null) {
      data['stone_details'] =
          this.stoneDetails!.map((v) => v.toJson()).toList();
    }
    if (this.diamondDetails != null) {
      data['diamond_details'] =
          this.diamondDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}