class NewPurchaseItemListPaylaod {
  int? page;
  int? itemsPerPage;
  String? id;
  int? menuId;

  NewPurchaseItemListPaylaod(
      {this.page, this.itemsPerPage, this.id, this.menuId});

  NewPurchaseItemListPaylaod.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    id = json['id'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    return data;
  }
}



class NewPurchaseItemListData {
  int? id;
  int? pieces;
  double? grossWeight;
  double? reduceWeight;
  double? netWeight;
  String? calculationType;
  double? fixedRate;
  double? touch;
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
  bool? reduceStoneWeight;
  int? stonePieces;
  double? stoneWeight;
  double? stoneAmount;
  bool? reduceDiamondWeight;
  int? diamondPieces;
  double? diamondWeight;
  double? diamondAmount;
  double? hallmarkCharges;
  double? otherCharges;
  double? totalWeight;
  double? gstAmount;
  double? totalAmount;
  int? newPurhcaseDetails;
  int? subItemDetails;
  String? itemDetailsName;
  int? itemDetails;
  String? subItemDetailsName;
  String? metalName;
  String? purityName;
  String? poId;
  String? vendorDetailsName;
  int? sNo;

  NewPurchaseItemListData(
      {this.id,
      this.pieces,
      this.grossWeight,
      this.reduceWeight,
      this.netWeight,
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
      this.perPieceRate,
      this.reduceStoneWeight,
      this.stonePieces,
      this.stoneWeight,
      this.stoneAmount,
      this.reduceDiamondWeight,
      this.diamondPieces,
      this.diamondWeight,
      this.diamondAmount,
      this.hallmarkCharges,
      this.otherCharges,
      this.totalWeight,
      this.gstAmount,
      this.totalAmount,
      this.newPurhcaseDetails,
      this.subItemDetails,
      this.itemDetailsName,
      this.itemDetails,
      this.subItemDetailsName,
      this.metalName,
      this.purityName,
      this.poId,
      this.vendorDetailsName,
      this.sNo});

  NewPurchaseItemListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    reduceWeight = json['reduce_weight'];
    netWeight = json['net_weight'];
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
    reduceStoneWeight = json['reduce_stone_weight'];
    stonePieces = json['stone_pieces'];
    stoneWeight = json['stone_weight'];
    stoneAmount = json['stone_amount'];
    reduceDiamondWeight = json['reduce_diamond_weight'];
    diamondPieces = json['diamond_pieces'];
    diamondWeight = json['diamond_weight'];
    diamondAmount = json['diamond_amount'];
    hallmarkCharges = json['hallmark_charges'];
    otherCharges = json['other_charges'];
    totalWeight = json['total_weight'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
    newPurhcaseDetails = json['new_purhcase_details'];
    subItemDetails = json['sub_item_details'];
    itemDetailsName = json['item_details_name'];
    itemDetails = json['item_details'];
    subItemDetailsName = json['sub_item_details_name'];
    metalName = json['metal_name'];
    purityName = json['purity_name'];
    poId = json['po_id'];
    vendorDetailsName = json['vendor_details_name'];
    sNo = json['s.no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
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
    data['reduce_stone_weight'] = this.reduceStoneWeight;
    data['stone_pieces'] = this.stonePieces;
    data['stone_weight'] = this.stoneWeight;
    data['stone_amount'] = this.stoneAmount;
    data['reduce_diamond_weight'] = this.reduceDiamondWeight;
    data['diamond_pieces'] = this.diamondPieces;
    data['diamond_weight'] = this.diamondWeight;
    data['diamond_amount'] = this.diamondAmount;
    data['hallmark_charges'] = this.hallmarkCharges;
    data['other_charges'] = this.otherCharges;
    data['total_weight'] = this.totalWeight;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    data['new_purhcase_details'] = this.newPurhcaseDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['item_details'] = this.itemDetails;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['metal_name'] = this.metalName;
    data['purity_name'] = this.purityName;
    data['po_id'] = this.poId;
    data['vendor_details_name'] = this.vendorDetailsName;
    data['s.no'] = this.sNo;
    return data;
  }
}



class NewPurchaseItemDetails {
  int? id;
  int? pieces;
  double? grossWeight;
  double? reduceWeight;
  double? netWeight;
  String? calculationType;
  double? fixedRate;
  double? touch;
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
  bool? reduceStoneWeight;
  int? stonePieces;
  double? stoneWeight;
  double? stoneAmount;
  bool? reduceDiamondWeight;
  int? diamondPieces;
  double? diamondWeight;
  double? diamondAmount;
  double? hallmarkCharges;
  double? otherCharges;
  double? totalWeight;
  double? gstAmount;
  double? totalAmount;
  int? newPurhcaseDetails;
  int? subItemDetails;
  // int? itemDetails;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? metalName;
  String? purityName;
  int? vendorDetails;
  String? vendorName;
  String? poId;
  int? branchId;
  String? branchName;

  NewPurchaseItemDetails(
      {this.id,
      this.pieces,
      this.grossWeight,
      this.reduceWeight,
      this.netWeight,
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
      this.perPieceRate,
      this.reduceStoneWeight,
      this.stonePieces,
      this.stoneWeight,
      this.stoneAmount,
      this.reduceDiamondWeight,
      this.diamondPieces,
      this.diamondWeight,
      this.diamondAmount,
      this.hallmarkCharges,
      this.otherCharges,
      this.totalWeight,
      this.gstAmount,
      this.totalAmount,
      this.newPurhcaseDetails,
      this.subItemDetails,
      // this.itemDetails,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.metalName,
      this.purityName,
      this.vendorDetails,
      this.vendorName,
      this.poId,
      this.branchId,
      this.branchName});

  NewPurchaseItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    reduceWeight = json['reduce_weight'];
    netWeight = json['net_weight'];
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
    reduceStoneWeight = json['reduce_stone_weight'];
    stonePieces = json['stone_pieces'];
    stoneWeight = json['stone_weight'];
    stoneAmount = json['stone_amount'];
    reduceDiamondWeight = json['reduce_diamond_weight'];
    diamondPieces = json['diamond_pieces'];
    diamondWeight = json['diamond_weight'];
    diamondAmount = json['diamond_amount'];
    hallmarkCharges = json['hallmark_charges'];
    otherCharges = json['other_charges'];
    totalWeight = json['total_weight'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
    newPurhcaseDetails = json['new_purhcase_details'];
    subItemDetails = json['sub_item_details'];
    // itemDetails = json['item_details'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    metalName = json['metal_name'];
    purityName = json['purity_name'];
    vendorDetails = json['vendor_details'];
    vendorName = json['vendor_name'];
    poId = json['po_id'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
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
    data['reduce_stone_weight'] = this.reduceStoneWeight;
    data['stone_pieces'] = this.stonePieces;
    data['stone_weight'] = this.stoneWeight;
    data['stone_amount'] = this.stoneAmount;
    data['reduce_diamond_weight'] = this.reduceDiamondWeight;
    data['diamond_pieces'] = this.diamondPieces;
    data['diamond_weight'] = this.diamondWeight;
    data['diamond_amount'] = this.diamondAmount;
    data['hallmark_charges'] = this.hallmarkCharges;
    data['other_charges'] = this.otherCharges;
    data['total_weight'] = this.totalWeight;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    data['new_purhcase_details'] = this.newPurhcaseDetails;
    data['sub_item_details'] = this.subItemDetails;
    // data['item_details'] = this.itemDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['metal_name'] = this.metalName;
    data['purity_name'] = this.purityName;
    data['vendor_details'] = this.vendorDetails;
    data['vendor_name'] = this.vendorName;
    data['po_id'] = this.poId;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    return data;
  }
}
