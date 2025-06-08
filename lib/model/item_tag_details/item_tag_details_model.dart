class ItemTagdetailsList {
  String? sNo;
  String? id;
  String? tagNumber;
  String? measurementValue;
  String? huid;
  String? remark;
  double? metalRate;
  int? pieces;
  double? grossWeight;
  double? reduceWeight;
  double? netWeight;
  int? availablePieces;
  String? calculationtype;
  String? stockType;
  double? availableGrossWeight;
  int? totalStonePieces;
  double? totalStoneWeight;
  double? totalStoneAmount;
  int? totalDiamondPieces;
  double? totalDiamondWeight;
  double? totalDiamondAmount;
  bool? isBilled;
  String? billedAt;
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
  String? MetalDetailsName;
  String? tagTypeName;
  double? minInterGstValue;
  double? interGstValue;
  double? minIntraGstValue;
  double? intraGstValue;
  double? minInterSaleValue;
  double? minIntraSaleValue;
  double? interSaleValue;
  double? intraSaleValue;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;
  double? huidRate;
  double? minWithoutGstRate;
  double? withoutGstRate;
  double? interGstPercent;
  double? intraGstPercent;

  ItemTagdetailsList(
      {this.sNo,
        this.id,
      this.tagNumber,
      this.measurementValue,
      this.huid,
      this.remark,
      this.metalRate,
      this.pieces,
      this.grossWeight,
      this.reduceWeight,
      this.netWeight,
      this.calculationtype,
      this.stockType,
      this.availablePieces,
      this.availableGrossWeight,
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
      this.MetalDetailsName,
      this.tagType,
      this.branch,
      this.wastageCalculationTypeName,
      this.flatWastageTypeName,
      this.makingChargeCalculationTypeName,
      this.perGramWeightTypeName,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.tagTypeName,
      this.minInterGstValue,
      this.interGstValue,
      this.minIntraGstValue,
      this.intraGstValue,
      this.minInterSaleValue,
      this.minIntraSaleValue,
      this.interSaleValue,
      this.intraSaleValue,
      this.stoneDetails,
      this.diamondDetails,
      this.huidRate,
      this.minWithoutGstRate,
      this.withoutGstRate,
      this.interGstPercent,
      this.intraGstPercent});

  ItemTagdetailsList.fromJson(Map<String, dynamic> json) {
    sNo = json['sno'];
    id = json['id'].toString();
    tagNumber = json['tag_number'];
    measurementValue = json['measurement_value'];
    huid = json['huid'];
    remark = json['remark'];
    metalRate = json['metal_rate'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    reduceWeight = json['reduce_weight'];
    netWeight = json['net_weight'];
    availablePieces = json['available_pieces'];
    calculationtype = json['calculation_type'];
    stockType = json['stock_type'];
    availableGrossWeight = json['available_gross_weight'];
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
    MetalDetailsName = json['metal_details_name'];
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
    minInterGstValue = json['min_inter_gst_value'];
    interGstValue = json['inter_gst_value'];
    minIntraGstValue = json['min_intra_gst_value'];
    intraGstValue = json['intra_gst_value'];
    minInterSaleValue = json['min_inter_sale_value'];
    minIntraSaleValue = json['min_intra_sale_value'];
    interSaleValue = json['inter_sale_value'];
    huidRate = json['huid_rate'];
    minWithoutGstRate = json['min_without_gst_rate'];
    withoutGstRate = json['without_gst_rate'];
    interSaleValue = json['inter_sale_value'];
    interGstPercent = json['inter_gst_percent'];
    intraGstPercent = json['intra_gst_percent'];
    if (json['stone_details'] != null) {
      stoneDetails = <StoneDetails>[];
      json['stone_details'].forEach((v) {
        stoneDetails!.add(new StoneDetails.fromJson(v));
      });
    }
    if (json['diamond_details'] != null) {
      diamondDetails = <DiamondDetails>[];
      json['diamond_details'].forEach((v) {
        diamondDetails!.add(new DiamondDetails.fromJson(v));
      });
    }
  }

  get value => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sno'] = this.sNo;
    data['id'] = this.id;
    data['tag_number'] = this.tagNumber;
    data['measurement_value'] = this.measurementValue;
    data['huid'] = this.huid;
    data['remark'] = this.remark;
    data['metal_rate'] = this.metalRate;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
    data['available_pieces'] = this.availablePieces;
    data['calculation_type'] = this.calculationtype;
    data['stock_type'] = this.stockType;
    data['available_gross_weight'] = this.availableGrossWeight;
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
    data['metal_details_name'] = this.MetalDetailsName;
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
    data['min_inter_gst_value'] = this.minInterGstValue;
    data['inter_gst_value'] = this.interGstValue;
    data['min_intra_gst_value'] = this.minIntraGstValue;
    data['intra_gst_value'] = this.intraGstValue;
    data['min_inter_sale_value'] = this.minInterSaleValue;
    data['min_intra_sale_value'] = this.minIntraSaleValue;
    data['inter_sale_value'] = this.interSaleValue;
    data['intra_sale_value'] = this.intraSaleValue;
    data['huid_rate'] = this.huidRate;
    data['min_without_gst_rate'] = this.minWithoutGstRate;
    data['without_gst_rate'] = this.withoutGstRate;
    data['inter_gst_percent'] = this.interGstPercent;
    data['intra_gst_percent'] = this.intraGstPercent;
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

class StoneDetails {
  int? id;
  bool? reduceWeight;
  int? stonePieces;
  double? stoneWeight;
  double? stoneAmount;
  int? tagItem;
  int? stone;
  String? stoneName;
  bool? isDb;

  StoneDetails(
      {this.id,
      this.reduceWeight,
      this.stonePieces,
      this.stoneWeight,
      this.stoneAmount,
      this.tagItem,
      this.stone,
      this.stoneName,
      this.isDb});

  StoneDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reduceWeight = json['reduce_weight'];
    stonePieces = json['stone_pieces'];
    stoneWeight = json['stone_weight'];
    stoneAmount = json['stone_amount'];
    tagItem = json['tag_item'];
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
    data['tag_item'] = this.tagItem;
    data['stone'] = this.stone;
    data['stone_name'] = this.stoneName;
    data['is_db'] = this.isDb;
    return data;
  }
}

class DiamondDetails {
  int? id;
  bool? reduceWeight;
  int? diamondPieces;
  double? diamondWeight;
  double? diamondAmount;
  int? tagItem;
  int? diamond;
  String? diamondName;
  bool? isDb;

  DiamondDetails(
      {this.id,
      this.reduceWeight,
      this.diamondPieces,
      this.diamondWeight,
      this.diamondAmount,
      this.tagItem,
      this.diamond,
      this.diamondName,
      this.isDb});

  DiamondDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reduceWeight = json['reduce_weight'];
    diamondPieces = json['diamond_pieces'];
    diamondWeight = json['diamond_weight'];
    diamondAmount = json['diamond_amount'];
    tagItem = json['tag_item'];
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
    data['tag_item'] = this.tagItem;
    data['diamond'] = this.diamond;
    data['diamond_name'] = this.diamondName;
    data['is_db'] = this.isDb;
    return data;
  }
}
