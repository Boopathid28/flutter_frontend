class FetchItemTagListPayload {
  int? menuId;
  String? search;
  String? fromDate;
  String? toDate;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchItemTagListPayload(
      {this.menuId,
      this.search,
      this.fromDate,
      this.toDate,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchItemTagListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    search = json['search'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['search'] = this.search;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}

class ItemTagListData {
  int? id;
  int? entryTaggedTagCount;
  int? entryTaggedPieces;
  double? entryTaggedGrossWeight;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? lotNumber;
  int? branch;
  String? designerName;
  int? sNo;

  ItemTagListData(
      {this.id,
      this.entryTaggedTagCount,
      this.entryTaggedPieces,
      this.entryTaggedGrossWeight,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.lotNumber,
      this.branch,
      this.designerName,
      this.sNo});

  ItemTagListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryTaggedTagCount = json['entry_tagged_tag_count'];
    entryTaggedPieces = json['entry_tagged_pieces'];
    entryTaggedGrossWeight = json['entry_tagged_gross_weight'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    lotNumber = json['lot_number'];
    branch = json['branch'];
    designerName = json['Designer_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entry_tagged_tag_count'] = this.entryTaggedTagCount;
    data['entry_tagged_pieces'] = this.entryTaggedPieces;
    data['entry_tagged_gross_weight'] = this.entryTaggedGrossWeight;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['lot_number'] = this.lotNumber;
    data['branch'] = this.branch;
    data['Designer_name'] = this.designerName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class CreateTagEntryPayload {
  int? menuId;
  String? lotDetails;
  String? branch;

  CreateTagEntryPayload({this.menuId, this.lotDetails, this.branch});

  CreateTagEntryPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    lotDetails = json['lot_details'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['lot_details'] = this.lotDetails;
    data['branch'] = this.branch;
    return data;
  }
}

class CreateTagEntryItemPayload {
  int? menuId;
  String? lotItemDetails;
  int? tagCount;
  int? pieces;
  double? grossWeight;
  double? touch;
  double? reduceWeight;
  double? netWeight;
  int? tagEntryDetails;
  String? subItemDetails;
  String? tagType;
  String? measurementValue;
  double? catalogueCoverWeight;
  String? remark;
  String? huid;
  int? totalStonePieces;
  double? totalStoneWeight;
  double? totalStoneAmount;
  int? totalDiamondPieces;
  double? totalDiamondWeight;
  double? totalDiamondAmount;
  double? minFixedRate;
  double? fixedRate;
  String? wastageCalculationType;
  String? minWastagePercent;
  String? wastagePercent;
  String? flatWastageType;
  String? minFlatWastage;
  String? flatWastage;
  String? makingChargeCalculationType;
  String? minMakingChargePerGram;
  String? makingChargePerGram;
  String? minFlatMakingCharge;
  String? flatMakingCharge;
  String? perGramWeightType;
  String? minPerGramRate;
  String? perGramRate;
  String? minPerPieceRate;
  String? perPieceRate;
  String? branch;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;

  CreateTagEntryItemPayload(
      {this.menuId,
      this.lotItemDetails,
      this.tagCount,
      this.pieces,
      this.grossWeight,
      this.reduceWeight,
      this.netWeight,
      this.tagEntryDetails,
      this.subItemDetails,
      this.tagType,
      this.measurementValue,
      this.catalogueCoverWeight,
      this.remark,
      this.touch,
      this.huid,
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
      this.branch,
      this.stoneDetails,
      this.diamondDetails});

  CreateTagEntryItemPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    lotItemDetails = json['lot_item_details'];
    tagCount = json['tag_count'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    reduceWeight = json['reduce_weight'];
    netWeight = json['net_weight'];
    tagEntryDetails = json['tag_entry_details'];
    subItemDetails = json['sub_item_details'];
    tagType = json['tag_type'];
    measurementValue = json['measurement_value'];
    catalogueCoverWeight= json['catalogue_cover_weight'];
    remark = json['remark'];
    touch = json['touch'];
    huid = json['huid'];
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
    branch = json['branch'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['lot_item_details'] = this.lotItemDetails;
    data['tag_count'] = this.tagCount;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
    data['tag_entry_details'] = this.tagEntryDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['tag_type'] = this.tagType;
    data['measurement_value'] = this.measurementValue;
    data['catalogue_cover_weight'] = this.catalogueCoverWeight;
    data['remark'] = this.remark;
    data['touch'] = this.touch;
    data['huid'] = this.huid;
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
    data['branch'] = this.branch;
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
  late String sNo;
  int? stone;
  String? stoneName;
  double? rate;
  double? certificateAmount;
  bool? reduceWeight;
  String? stonePieces;
  String? stoneWeight;
  String? stoneAmount;
 
  StoneDetails(
      {required this.sNo,
      this.stone,
      this.stoneName,
      this.rate,
      this.certificateAmount,
      this.reduceWeight,
      this.stonePieces,
      this.stoneWeight,
      this.stoneAmount});
 
  StoneDetails.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'].toString();
    stone = json['stone'];
    stoneName = json['stone_name'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
    reduceWeight = json['reduce_weight'];
    stonePieces = json['stone_pieces'].toString();
    stoneWeight = json['stone_weight'].toString();
    stoneAmount = json['stone_amount'].toString();
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['stone'] = this.stone;
    data['stone_name'] = this.stoneName;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['reduce_weight'] = this.reduceWeight;
    data['stone_pieces'] = this.stonePieces;
    data['stone_weight'] = this.stoneWeight;
    data['stone_amount'] = this.stoneAmount;
    return data;
  }
}
 
class DiamondDetails {
  late String sNo;
  int? diamond;
  String? diamondName;
  double? rate;
  double? certificateAmount;
  bool? reduceWeight;
  String? diamondPieces;
  String? diamondWeight;
  String? diamondAmount;
 
  DiamondDetails(
      {required this.sNo,
      this.diamond,
      this.diamondName,
      this.certificateAmount,
      this.rate,
      this.reduceWeight,
      this.diamondPieces,
      this.diamondWeight,
      this.diamondAmount});
 
  DiamondDetails.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'].toString();
    diamond = json['diamond'];
    diamondName = json['diamond_name'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
    reduceWeight = json['reduce_weight'];
    diamondPieces = json['diamond_pieces'].toString();
    diamondWeight = json['diamond_weight'].toString();
    diamondAmount = json['diamond_amount'].toString();
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['diamond'] = this.diamond;
    data['diamond_name'] = this.diamondName;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['reduce_weight'] = this.reduceWeight;
    data['diamond_pieces'] = this.diamondPieces;
    data['diamond_weight'] = this.diamondWeight;
    data['diamond_amount'] = this.diamondAmount;
    return data;
  }
}

class CreateTagEntryResponse {
  int? id;
  int? entryTaggedTagCount;
  int? entryTaggedPieces;
  double? entryTaggedGrossWeight;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? lotDetails;
  int? branch;

  CreateTagEntryResponse(
      {this.id,
      this.entryTaggedTagCount,
      this.entryTaggedPieces,
      this.entryTaggedGrossWeight,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.lotDetails,
      this.branch});

  CreateTagEntryResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryTaggedTagCount = json['entry_tagged_tag_count'];
    entryTaggedPieces = json['entry_tagged_pieces'];
    entryTaggedGrossWeight = json['entry_tagged_gross_weight'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    lotDetails = json['lot_details'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entry_tagged_tag_count'] = this.entryTaggedTagCount;
    data['entry_tagged_pieces'] = this.entryTaggedPieces;
    data['entry_tagged_gross_weight'] = this.entryTaggedGrossWeight;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['lot_details'] = this.lotDetails;
    data['branch'] = this.branch;
    return data;
  }
}

class TagItemDetailsResponse {
  int? id;
  String? tagNumber;
  String? measurementValue;
  String? huid;
  String? remark;
  int? pieces;
  String? purityName;
  String? designerName;
  double? grossWeight;
  double? reduceWeight;
  double? netWeight;
  int? availablePieces;
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
  String? tagEntryDetails;
  String? lotItemDetails;
  String? subItemDetails;
  String? tagType;
  String? branch;
  String? wastageCalculationTypeName;
  String? flatWastageTypeName;
  String? makingChargeCalculationTypeName;
  String? perGramWeightTypeName;
  String? subItemDetailsName;
  String? subItemDetailsCode;
  String? itemDetailsName;
  String? tagTypeName;
  int? sNo;

  TagItemDetailsResponse(
      {this.id,
      this.tagNumber,
      this.measurementValue,
      this.huid,
      this.remark,
      this.pieces,
      this.purityName,
      this.designerName,
      this.grossWeight,
      this.reduceWeight,
      this.netWeight,
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
      this.tagType,
      this.branch,
      this.wastageCalculationTypeName,
      this.flatWastageTypeName,
      this.makingChargeCalculationTypeName,
      this.perGramWeightTypeName,
      this.subItemDetailsName,
      this.subItemDetailsCode,
      this.itemDetailsName,
      this.tagTypeName,
      this.sNo});

  TagItemDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagNumber = json['tag_number'];
    measurementValue = json['measurement_value'];
    huid = json['huid'];
    remark = json['remark'];
    pieces = json['pieces'];
    purityName = json['purity_name'];
    designerName = json['designer_name'];
    grossWeight = json['gross_weight'];
    reduceWeight = json['reduce_weight'];
    netWeight = json['net_weight'];
    availablePieces = json['available_pieces'];
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
    tagEntryDetails = json['tag_entry_details'].toString();
    lotItemDetails = json['lot_item_details'].toString();
    subItemDetails = json['sub_item_details'].toString();
    tagType = json['tag_type'].toString();
    branch = json['branch'].toString();
    wastageCalculationTypeName = json['wastage_calculation_type_name'];
    flatWastageTypeName = json['flat_wastage_type_name'];
    makingChargeCalculationTypeName =
        json['making_charge_calculation_type_name'];
    perGramWeightTypeName = json['per_gram_weight_type_name'];
    subItemDetailsName = json['sub_item_details_name'];
    subItemDetailsCode = json['sub_item_details_code'];
    itemDetailsName = json['item_details_name'];
    tagTypeName = json['tag_type_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag_number'] = this.tagNumber;
    data['measurement_value'] = this.measurementValue;
    data['huid'] = this.huid;
    data['remark'] = this.remark;
    data['pieces'] = this.pieces;
    data['purity_name'] = this.purityName;
    data['designer_name'] = this.designerName;
    data['gross_weight'] = this.grossWeight;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
    data['available_pieces'] = this.availablePieces;
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
    data['tag_type'] = this.tagType;
    data['branch'] = this.branch;
    data['wastage_calculation_type_name'] = this.wastageCalculationTypeName;
    data['flat_wastage_type_name'] = this.flatWastageTypeName;
    data['making_charge_calculation_type_name'] =
        this.makingChargeCalculationTypeName;
    data['per_gram_weight_type_name'] = this.perGramWeightTypeName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['sub_item_details_code'] = this.subItemDetailsCode;
    data['item_details_name'] = this.itemDetailsName;
    data['tag_type_name'] = this.tagTypeName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class SubItemWeightCalcDetailsResponse {
  String? wastageCalculationType;
  double? minWastagePercent;
  double? wastagePercent;
  String? flatWastageType;
  String? flatWastageTypeName;
  double? minFlatWastage;
  double? flatWastage;
  String? makingChargeCalculationType;
  double? minMakingChargePerGram;
  double? makingChargePerGram;
  double? minFlatMakingCharge;
  double? flatMakingCharge;
  String? wastageCalculationTypeName;
  String? makingChargeCalculationTypeName;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;


  SubItemWeightCalcDetailsResponse(
      {this.wastageCalculationType,
      this.minWastagePercent,
      this.wastagePercent,
      this.flatWastageType,
      this.flatWastageTypeName,
      this.minFlatWastage,
      this.flatWastage,
      this.makingChargeCalculationType,
      this.minMakingChargePerGram,
      this.makingChargePerGram,
      this.minFlatMakingCharge,
      this.flatMakingCharge,
      this.wastageCalculationTypeName,
        this.stoneDetails,
      this.diamondDetails,
      this.makingChargeCalculationTypeName});

  SubItemWeightCalcDetailsResponse.fromJson(Map<String, dynamic> json) {
    wastageCalculationType = json['wastage_calculation_type'];
    minWastagePercent = json['min_wastage_percent'];
    wastagePercent = json['wastage_percent'];
    flatWastageType = json['flat_wastage_type'];
    flatWastageTypeName = json['flat_wastage_type_name'];
    minFlatWastage = json['min_flat_wastage'];
    flatWastage = json['flat_wastage'];
    makingChargeCalculationType = json['making_charge_calculation_type'];
    minMakingChargePerGram = json['min_making_charge_per_gram'];
    makingChargePerGram = json['making_charge_per_gram'];
    minFlatMakingCharge = json['min_flat_making_charge'];
    flatMakingCharge = json['flat_making_charge'];
    wastageCalculationTypeName = json['wastage_calculation_type_name'];
    makingChargeCalculationTypeName =
        json['making_charge_calculation_type_name'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wastage_calculation_type'] = this.wastageCalculationType;
    data['min_wastage_percent'] = this.minWastagePercent;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage_type'] = this.flatWastageType;
    data['flat_wastage_type_name'] = this.flatWastageTypeName;
    data['min_flat_wastage'] = this.minFlatWastage;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_calculation_type'] = this.makingChargeCalculationType;
    data['min_making_charge_per_gram'] = this.minMakingChargePerGram;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['min_flat_making_charge'] = this.minFlatMakingCharge;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['wastage_calculation_type_name'] = this.wastageCalculationTypeName;
    data['making_charge_calculation_type_name'] =
        this.makingChargeCalculationTypeName;
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

class SubItemPerGramCalcDetailsResponse {
  String? perGramWeightType;
  double? minPerGramRate;
  double? perGramRate;
  String? perGramWeightTypeName;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;


  SubItemPerGramCalcDetailsResponse(
      {this.perGramWeightType,
      this.minPerGramRate,
      this.perGramRate,
      this.perGramWeightTypeName,
        this.stoneDetails,
      this.diamondDetails});

  SubItemPerGramCalcDetailsResponse.fromJson(Map<String, dynamic> json) {
    perGramWeightType = json['per_gram_weight_type'];
    minPerGramRate = json['min_per_gram_rate'];
    perGramRate = json['per_gram_rate'];
    perGramWeightTypeName =
        json['per_gram_weight_type_name'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['min_per_gram_rate'] = this.minPerGramRate;
    data['per_gram_rate'] = this.perGramRate;
    data['per_gram_weight_type_name'] =
        this.perGramWeightTypeName;
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

class SubItemFixedCalcDetailsResponse {
  double? minFixedRate;
  double? fixedRate;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;


  SubItemFixedCalcDetailsResponse({this.minFixedRate, this.fixedRate,  this.stoneDetails,
      this.diamondDetails});

  SubItemFixedCalcDetailsResponse.fromJson(Map<String, dynamic> json) {
    minFixedRate = json['min_fixed_rate'];
    fixedRate = json['fixed_rate'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_fixed_rate'] = this.minFixedRate;
    data['fixed_rate'] = this.fixedRate;
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

class SubItemPerPieceCalcDetailsResponse {
  double? minPerPieceRate;
  double? perPieceRate;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;


  SubItemPerPieceCalcDetailsResponse({this.minPerPieceRate, this.perPieceRate,  this.stoneDetails,
      this.diamondDetails});

  SubItemPerPieceCalcDetailsResponse.fromJson(Map<String, dynamic> json) {
    minPerPieceRate = json['min_per_piece_rate'];
    perPieceRate = json['per_piece_rate'];
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['min_per_piece_rate'] = this.minPerPieceRate;
    data['per_piece_rate'] = this.perPieceRate;
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




class StoneAndDiamondDetailsResponse {
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;

  StoneAndDiamondDetailsResponse({this.stoneDetails, this.diamondDetails});

  StoneAndDiamondDetailsResponse.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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

