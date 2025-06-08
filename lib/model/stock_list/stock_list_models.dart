class FetchStockListPayload {
  int? menuId;
  String? branch;
  String? search;
  String? metal;
  String? purity;
  String? item;
  String? subItem;
  String? stockType;
  String? calculationType;
  String? vendor;
  String? fromWeight;
  String? toWeight;
  String? fromDate;
  String? toDate;
  int? page;
  int? itemsPerPage;

  FetchStockListPayload(
      {this.menuId,
      this.branch,
      this.search,
      this.metal,
      this.purity,
      this.item,
      this.subItem,
      this.stockType,
      this.calculationType,
      this.vendor,
      this.fromWeight,
      this.toWeight,
      this.fromDate,
      this.toDate,
      this.page,
      this.itemsPerPage});

  FetchStockListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    search = json['search'];
    metal = json['metal'];
    purity = json['purity'];
    item = json['item'];
    subItem = json['sub_item'];
    stockType = json['stock_type'];
    calculationType = json['calculation_type'];
    vendor = json['vendor'];
    fromWeight = json['from_weight'];
    toWeight = json['to_weight'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['search'] = this.search;
    data['metal'] = this.metal;
    data['purity'] = this.purity;
    data['item'] = this.item;
    data['sub_item'] = this.subItem;
    data['stock_type'] = this.stockType;
    data['calculation_type'] = this.calculationType;
    data['vendor'] = this.vendor;
    data['from_weight'] = this.fromWeight;
    data['to_weight'] = this.toWeight;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}



class StockListData {
  int? id;
  String? tagNumber;
  String? measurementValue;
  String? huid;
  String? remark;
  int? pieces;
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
  int? tagEntryDetails;
  int? lotItemDetails;
  int? subItemDetails;
  int? tagType;
  int? branch;
  String? metalName;
  String? purityName;
  String? itemName;
  String? subItemName;
  String? stockTypeName;
  String? calculationTypeName;
  String? vendorName;
  String? taggedAt;
  int? sNo;

  StockListData(
      {this.id,
      this.tagNumber,
      this.measurementValue,
      this.huid,
      this.remark,
      this.pieces,
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
      this.metalName,
      this.purityName,
      this.itemName,
      this.subItemName,
      this.stockTypeName,
      this.calculationTypeName,
      this.vendorName,
      this.taggedAt,
      this.sNo});

  StockListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagNumber = json['tag_number'];
    measurementValue = json['measurement_value'];
    huid = json['huid'];
    remark = json['remark'];
    pieces = json['pieces'];
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
    tagEntryDetails = json['tag_entry_details'];
    lotItemDetails = json['lot_item_details'];
    subItemDetails = json['sub_item_details'];
    tagType = json['tag_type'];
    branch = json['branch'];
    metalName = json['metal_name'];
    purityName = json['purity_name'];
    itemName = json['item_name'];
    subItemName = json['sub_item_name'];
    stockTypeName = json['stock_type_name'];
    calculationTypeName = json['calculation_type_name'];
    vendorName = json['vendor_name'];
    taggedAt = json['tagged_at'];
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
    data['metal_name'] = this.metalName;
    data['purity_name'] = this.purityName;
    data['item_name'] = this.itemName;
    data['sub_item_name'] = this.subItemName;
    data['stock_type_name'] = this.stockTypeName;
    data['calculation_type_name'] = this.calculationTypeName;
    data['vendor_name'] = this.vendorName;
    data['tagged_at'] = this.taggedAt;
    data['s_no'] = this.sNo;
    return data;
  }
}
