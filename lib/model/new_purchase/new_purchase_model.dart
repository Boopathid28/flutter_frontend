class FetchNewPurchaseListPayload {
  int? menuId;
  String? branch;
  String? vendor;
  bool? status;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchNewPurchaseListPayload(
      {this.menuId,
      this.branch,
      this.vendor,
      this.status,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchNewPurchaseListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    vendor = json['vendor'];
    status = json['status'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['vendor'] = this.vendor;
    data['status'] = this.status;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class FetchNewPurchaseListResponse {
  int? id;
  String? poId;
  String? poDate;
  int? totalItems;
  int? totalPieces;
  double? totalGrossWeight;
  double? totalNetWeight;
  double? hallmarkCharges;
  double? otherCharges;
  double? gstAmount;
  double? payableAmount;
  double? payablePureWeight;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? vendor;
  int? branch;
  String? vendorName;
  int? sNo;

  FetchNewPurchaseListResponse(
      {this.id,
      this.poId,
      this.poDate,
      this.totalItems,
      this.totalPieces,
      this.totalGrossWeight,
      this.totalNetWeight,
      this.hallmarkCharges,
      this.otherCharges,
      this.gstAmount,
      this.payableAmount,
      this.payablePureWeight,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.vendor,
      this.branch,
      this.vendorName,
      this.sNo});

  FetchNewPurchaseListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    poId = json['po_id'];
    poDate = json['po_date'];
    totalItems = json['total_items'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'];
    totalNetWeight = json['total_net_weight'];
    hallmarkCharges = json['hallmark_charges'];
    otherCharges = json['other_charges'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    payablePureWeight = json['payable_pure_weight'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    vendor = json['vendor'];
    branch = json['branch'];
    vendorName = json['vendor_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['po_id'] = this.poId;
    data['po_date'] = this.poDate;
    data['total_items'] = this.totalItems;
    data['total_pieces'] = this.totalPieces;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['total_net_weight'] = this.totalNetWeight;
    data['hallmark_charges'] = this.hallmarkCharges;
    data['other_charges'] = this.otherCharges;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['payable_pure_weight'] = this.payablePureWeight;
    data['is_canceled'] = this.isCanceled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['vendor'] = this.vendor;
    data['branch'] = this.branch;
    data['vendor_name'] = this.vendorName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class NewPurchasePayload {
  int? menuId;
  String? branch;
  String? vendor;
  String? poDate;
  String? remark;
  int? totalItems;
  int? totalPieces;
  double? totalGrossWeight;
  double? totalNetWeight;
  double? hallmarkCharges;
  double? otherCharges;
  bool? isConverted;
  double? convertedWeight;
  double? convertionRate;
  double? convertedAmount;
  double? withoutGstConverisonAmount;
  double? coversionGst;
  double? withoutTdsAmount;
  double? tdsPercent;
  int? tdsAmount;
  double? roundOff;
  String? gstType;
  double? gstAmount;
  double? payableAmount;
  double? payablePureWeight;
  double? openWeight;
  double? openAmount;
  List<NewPurchaseItemDetails>? newPurchaseItemDetails;

  NewPurchasePayload(
      {this.menuId,
      this.branch,
      this.vendor,
      this.poDate,
      this.totalItems,
      this.totalPieces,
      this.totalGrossWeight,
      this.totalNetWeight,
      this.hallmarkCharges,
      this.otherCharges,
      this.isConverted,
      this.convertedWeight,
      this.convertionRate,
      this.convertedAmount,
      this.withoutTdsAmount,
      this.tdsPercent,
      this.tdsAmount,
      this.roundOff,
      this.gstType,
      this.gstAmount,
      this.payableAmount,
      this.payablePureWeight,
      this.newPurchaseItemDetails,
      this.withoutGstConverisonAmount,
      this.openWeight, 
      this.openAmount, 
      this.remark, 
      this.coversionGst});

  NewPurchasePayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    vendor = json['vendor'];
    poDate = json['po_date'];
    totalItems = json['total_items'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'];
    totalNetWeight = json['total_net_weight'];
    hallmarkCharges = json['hallmark_charges'];
    otherCharges = json['other_charges'];
    isConverted = json['is_converted'];
    convertedWeight = json['converted_weight'];
    convertionRate = json['convertion_rate'];
    convertedAmount = json['converted_amount'];
    withoutGstConverisonAmount = json['without_gst_converison_amount'];
    coversionGst = json['coversion_gst'];
    withoutTdsAmount = json['without_tds_amount'];
    tdsPercent = json['tds_percent'];
    tdsAmount = json['tds_amount'];
    roundOff = json['round_off'];
    gstType = json['gst_type'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    payablePureWeight = json['payable_pure_weight'];
    openWeight = json['open_weight'];
    openAmount = json['open_amount'];
    remark = json['remarks'];
    if (json['new_purchase_item_details'] != null) {
      newPurchaseItemDetails = <NewPurchaseItemDetails>[];
      json['new_purchase_item_details'].forEach((v) {
        newPurchaseItemDetails!.add(new NewPurchaseItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['vendor'] = this.vendor;
    data['po_date'] = this.poDate;
    data['total_items'] = this.totalItems;
    data['total_pieces'] = this.totalPieces;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['total_net_weight'] = this.totalNetWeight;
    data['hallmark_charges'] = this.hallmarkCharges;
    data['other_charges'] = this.otherCharges;
    data['is_converted'] = this.isConverted;
    data['converted_weight'] = this.convertedWeight;
    data['convertion_rate'] = this.convertionRate;
    data['converted_amount'] = this.convertedAmount;
    data['without_gst_converison_amount'] = this.withoutGstConverisonAmount;
    data['coversion_gst'] = this.coversionGst;
    data['without_tds_amount'] = this.withoutTdsAmount;
    data['tds_percent'] = this.tdsPercent;
    data['tds_amount'] = this.tdsAmount;
    data['round_off'] = this.roundOff;
    data['gst_type'] = this.gstType;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['payable_pure_weight'] = this.payablePureWeight;
    data['open_weight'] = this.openWeight;
    data['open_amount'] = this.openAmount;
    data['remarks'] = this.remark;
    if (this.newPurchaseItemDetails != null) {
      data['new_purchase_item_details'] =
          this.newPurchaseItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NewPurchaseItemDetails {
  String? id;
  String? itemDetails;
  String? itemDetailsId;
  String? itemDetailsName;
  String? subItemDetails;
  String? subItemDetailsName;
  int? pieces;
  double? grossWeight;
  double? reduceWeight;
  double? netWeight;
  String? calculationType;
  String? calculationTypeName;
  double? fixedRate;
  double? touch;
  String? wastageCalculationType;
  String? wastageCalculationTypeName;
  double? wastagePercent;
  String? flatWastageType;
  String? flatWastageTypeName;
  double? flatWastage;
  String? makingChargeCalculationType;
  String? makingChargeCalculationTypeName;
  double? makingChargePerGram;
  double? flatMakingCharge;
  String? perGramWeightType;
  String? perGramWeightTypeName;
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

  NewPurchaseItemDetails(
      {this.id,
      this.itemDetails,
      this.itemDetailsId,
      this.itemDetailsName,
      this.subItemDetails,
      this.subItemDetailsName,
      this.pieces,
      this.grossWeight,
      this.reduceWeight,
      this.netWeight,
      this.calculationType,
      this.calculationTypeName,
      this.fixedRate,
      this.touch,
      this.wastageCalculationType,
      this.wastageCalculationTypeName,
      this.wastagePercent,
      this.flatWastageType,
      this.flatWastageTypeName,
      this.flatWastage,
      this.makingChargeCalculationType,
      this.makingChargeCalculationTypeName,
      this.makingChargePerGram,
      this.flatMakingCharge,
      this.perGramWeightType,
      this.perGramWeightTypeName,
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
      this.totalAmount});

  NewPurchaseItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemDetails = json['item_details'];
    itemDetailsId = json['order_item_id'];
    itemDetailsName = json['item_details_name'];
    subItemDetails = json['sub_item_details'];
    subItemDetailsName = json['sub_item_details_name'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    reduceWeight = json['reduce_weight'];
    netWeight = json['net_weight'];
    calculationType = json['calculation_type'];
    calculationTypeName = json['calculation_type_name'];
    fixedRate = json['fixed_rate'];
    touch = json['touch'];
    wastageCalculationType = json['wastage_calculation_type'];
    wastageCalculationTypeName = json['wastage_calculation_type_name'];
    wastagePercent = json['wastage_percent'];
    flatWastageType = json['flat_wastage_type'];
    flatWastageTypeName = json['flat_wastage_type_name'];
    flatWastage = json['flat_wastage'];
    makingChargeCalculationType = json['making_charge_calculation_type'];
    makingChargeCalculationTypeName = json['making_charge_calculation_type_name'];
    makingChargePerGram = json['making_charge_per_gram'];
    flatMakingCharge = json['flat_making_charge'];
    perGramWeightType = json['per_gram_weight_type'];
    perGramWeightTypeName = json['per_gram_weight_type_name'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_details'] = this.itemDetails;
    data['order_item_id'] = this.itemDetailsId;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details'] = this.subItemDetails;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
    data['calculation_type'] = this.calculationType;
    data['calculation_type_name'] = this.calculationTypeName;
    data['fixed_rate'] = this.fixedRate;
    data['touch'] = this.touch;
    data['wastage_calculation_type'] = this.wastageCalculationType;
    data['wastage_calculation_type_name'] = this.wastageCalculationTypeName;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage_type'] = this.flatWastageType;
    data['flat_wastage_type_name'] = this.flatWastageTypeName;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_calculation_type'] = this.makingChargeCalculationType;
    data['making_charge_calculation_type_name'] = this.makingChargeCalculationTypeName;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['per_gram_weight_type_name'] = this.perGramWeightTypeName;
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
    return data;
  }
}

class SubItemVendorWeightCalcDetailsResponse {
  String? calculationType;
  String? calculationTypeName;
  double? touch;
  double? fixedRate;
  String? wastageCalculationType;
  String? wastageCalculationTypeName;
  double? wastagePercent;
  String? flatWastageType;
  String? flatWastageTypeName;
  double? flatWastage;
  String? makingChargeCalculationType;
  String? makingChargeCalculationTypeName;
  double? makingChargePerGram;
  double? flatMakingCharge;
  String? perGramWeightType;
  String? perGramWeightTypeName;
  double? perGramRate;
  double? perPieceRate;

  SubItemVendorWeightCalcDetailsResponse(
      {this.calculationType,
      this.calculationTypeName,
      this.touch,
      this.fixedRate,
      this.wastageCalculationType,
      this.wastageCalculationTypeName,
      this.wastagePercent,
      this.flatWastageType,
      this.flatWastageTypeName,
      this.flatWastage,
      this.makingChargeCalculationType,
      this.makingChargeCalculationTypeName,
      this.makingChargePerGram,
      this.flatMakingCharge,
      this.perGramWeightType,
      this.perGramWeightTypeName,
      this.perGramRate,
      this.perPieceRate});

  SubItemVendorWeightCalcDetailsResponse.fromJson(Map<String, dynamic> json) {
    calculationType = json['calculation_type'];
    calculationTypeName = json['calculation_type_name'];
    touch = json['touch'];
    fixedRate = json['fixed_rate'];
    wastageCalculationType = json['wastage_calculation_type'];
    wastageCalculationTypeName = json['wastage_calculation_type_name'];
    wastagePercent = json['wastage_percent'];
    flatWastageType = json['flat_wastage_type'];
    flatWastageTypeName = json['flat_wastage_type_name'];
    flatWastage = json['flat_wastage'];
    makingChargeCalculationType = json['making_charge_calculation_type'];
    makingChargeCalculationTypeName =
        json['making_charge_calculation_type_name'];
    makingChargePerGram = json['making_charge_per_gram'];
    flatMakingCharge = json['flat_making_charge'];
    perGramWeightType = json['per_gram_weight_type'];
    perGramWeightTypeName = json['per_gram_weight_type_name'];
    perGramRate = json['per_gram_rate'];
    perPieceRate = json['per_piece_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calculation_type'] = this.calculationType;
    data['calculation_type_name'] = this.calculationTypeName;
    data['touch'] = this.touch;
    data['fixed_rate'] = this.fixedRate;
    data['wastage_calculation_type'] = this.wastageCalculationType;
    data['wastage_calculation_type_name'] = this.wastageCalculationTypeName;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage_type'] = this.flatWastageType;
    data['flat_wastage_type_name'] = this.flatWastageTypeName;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_calculation_type'] = this.makingChargeCalculationType;
    data['making_charge_calculation_type_name'] =
        this.makingChargeCalculationTypeName;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['per_gram_weight_type_name'] = this.perGramWeightTypeName;
    data['per_gram_rate'] = this.perGramRate;
    data['per_piece_rate'] = this.perPieceRate;
    return data;
  }
}

class NewPurchaseRetrieveResponse {
  int? id;
  String? poId;
  String? poDate;
  int? totalItems;
  int? totalPieces;
  double? totalGrossWeight;
  double? totalNetWeight;
  String? gstType;
  double? gstPercent;
  double? gstAmount;
  double? grandTotal;
  bool? isConverted;
  double? convertedWeight;
  double? convertionRate;
  double? convertedAmount;
  double? withoutTdsAmount;
  double? tdsPercent;
  double? tdsAmount;
  double? roundOff;
  double? payableAmount;
  double? payablePureWeight;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  double? openWeight;
  double? openAmount;
  int? vendor;
  int? branch;
  String? vendorName;
  String? vendorAddress;
  String? vendorPhone;
  List<ItemDetails>? itemDetails;

  NewPurchaseRetrieveResponse(
      {this.id,
      this.poId,
      this.poDate,
      this.totalItems,
      this.totalPieces,
      this.totalGrossWeight,
      this.totalNetWeight,
      this.gstType,
      this.gstPercent,
      this.gstAmount,
      this.grandTotal,
      this.isConverted,
      this.convertedWeight,
      this.convertionRate,
      this.convertedAmount,
      this.withoutTdsAmount,
      this.tdsPercent,
      this.tdsAmount,
      this.roundOff,
      this.payableAmount,
      this.payablePureWeight,
      this.openWeight, 
      this.openAmount,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.vendor,
      this.branch,
      this.vendorName,
      this.vendorAddress,
      this.vendorPhone,
      this.itemDetails});

  NewPurchaseRetrieveResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    poId = json['po_id'];
    poDate = json['po_date'];
    totalItems = json['total_items'];
    totalPieces = json['total_pieces'];
    totalGrossWeight = json['total_gross_weight'];
    totalNetWeight = json['total_net_weight'];
    gstType = json['gst_type'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    grandTotal = json['grand_total'];
    isConverted = json['is_converted'];
    convertedWeight = json['converted_weight'];
    convertionRate = json['convertion_rate'];
    convertedAmount = json['converted_amount'];
    withoutTdsAmount = json['without_tds_amount'];
    tdsPercent = json['tds_percent'];
    tdsAmount = json['tds_amount'];
    roundOff = json['round_off'];
    payableAmount = json['payable_amount'];
    openWeight = json['open_weight'];
    openAmount = json['open_amount'];
    payablePureWeight = json['payable_pure_weight'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    vendor = json['vendor'];
    branch = json['branch'];
    vendorName = json['vendor_name'];
    vendorAddress = json['vendor_address'];
    vendorPhone = json['vendor_phone'];
    if (json['item_details'] != null) {
      itemDetails = <ItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new ItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['po_id'] = this.poId;
    data['po_date'] = this.poDate;
    data['total_items'] = this.totalItems;
    data['total_pieces'] = this.totalPieces;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['total_net_weight'] = this.totalNetWeight;
    data['gst_type'] = this.gstType;
    data['gst_percent'] = this.gstPercent;
    data['gst_amount'] = this.gstAmount;
    data['grand_total'] = this.grandTotal;
    data['is_converted'] = this.isConverted;
    data['converted_weight'] = this.convertedWeight;
    data['convertion_rate'] = this.convertionRate;
    data['converted_amount'] = this.convertedAmount;
    data['without_tds_amount'] = this.withoutTdsAmount;
    data['tds_percent'] = this.tdsPercent;
    data['tds_amount'] = this.tdsAmount;
    data['round_off'] = this.roundOff;
    data['payable_amount'] = this.payableAmount;
    data['payable_pure_weight'] = this.payablePureWeight;
    data['is_canceled'] = this.isCanceled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['vendor'] = this.vendor;
    data['branch'] = this.branch;
    data['open_weight'] = this.openWeight;
    data['open_amount'] = this.openAmount;
    data['vendor_name'] = this.vendorName;
    data['vendor_address'] = this.vendorAddress;
    data['vendor_phone'] = this.vendorPhone;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemDetails {
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
  String? subItemDetailsName;
  bool? isDb;

  ItemDetails(
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
      this.subItemDetailsName,
      this.isDb});

  ItemDetails.fromJson(Map<String, dynamic> json) {
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
    subItemDetailsName = json['sub_item_details_name'];
    isDb = json['is_db'];
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
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['is_db'] = this.isDb;
    return data;
  }
}
