import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';

class EstimationPayload {
  int? menuId;
  String? estimationDate;
  int? customerDetails;
  String? metalname;
  double? totalAmount;
  double? gstAmount;
  double? advanceAmount;
  double? discountAmount;
  double? exchangeAmount;
  double? chitAmount;
  double? saleReturnAmount;
  String? gstType;
  double? roundoffAmount;
  double? payableAmount;
  String? branch;
  List<ParticularDetails>? particularDetails;
  List<ExchangeDetails>? exchangeDetails;
  List<int>? oldPurchaseDetails;
  List<EstimationAdvanceDetails>? advanceDetails;
  List<ChitPaymentDetails>? chitDetails;

  EstimationPayload(
      {this.menuId,
      this.estimationDate,
      this.customerDetails,
      this.metalname,
      this.totalAmount,
      this.gstAmount,
      this.advanceAmount,
      this.discountAmount,
      this.exchangeAmount,
      this.chitAmount,
      this.saleReturnAmount,
      this.gstType,
      this.roundoffAmount,
      this.payableAmount,
      this.branch,
      this.particularDetails,
      this.exchangeDetails,
      this.oldPurchaseDetails,
      this.advanceDetails,
      this.chitDetails});

  EstimationPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    estimationDate = json['estimation_date'];
    customerDetails = json['customer_details'];
    metalname = json['metal'];
    totalAmount = json['total_amount'];
    gstAmount = json['gst_amount'];
    advanceAmount = json['advance_amount'];
    discountAmount = json['discount_amount'];
    exchangeAmount = json['exchange_amount'];
    chitAmount = json['chit_amount'];
    saleReturnAmount = json['sale_return_amount'];
    gstType = json['gst_type'];
    roundoffAmount = json['roundoff_amount'];
    payableAmount = json['payable_amount'];
    branch = json['branch'];
    if (json['particular_details'] != null) {
      particularDetails = <ParticularDetails>[];
      json['particular_details'].forEach((v) {
        particularDetails!.add(new ParticularDetails.fromJson(v));
      });
    }
    if (json['exchange_details'] != null) {
      exchangeDetails = <ExchangeDetails>[];
      json['exchange_details'].forEach((v) {
        exchangeDetails!.add(new ExchangeDetails.fromJson(v));
      });
    }
    oldPurchaseDetails = json['old_purchase_details'].cast<int>();
    if (json['advance_details'] != null) {
      advanceDetails = <EstimationAdvanceDetails>[];
      json['advance_details'].forEach((v) {
        advanceDetails!.add(new EstimationAdvanceDetails.fromJson(v));
      });
    }
    if (json['chit_details'] != null) {
      chitDetails = <ChitPaymentDetails>[];
      json['chit_details'].forEach((v) {
        chitDetails!.add(new ChitPaymentDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['estimation_date'] = this.estimationDate;
    data['customer_details'] = this.customerDetails;
    data['metal'] = this.metalname;
    data['total_amount'] = this.totalAmount;
    data['gst_amount'] = this.gstAmount;
    data['advance_amount'] = this.advanceAmount;
    data['discount_amount'] = this.discountAmount;
    data['exchange_amount'] = this.exchangeAmount;
    data['chit_amount'] = this.chitAmount;
    data['sale_return_amount'] = this.saleReturnAmount;
    data['gst_type'] = this.gstType;
    data['roundoff_amount'] = this.roundoffAmount;
    data['payable_amount'] = this.payableAmount;
    data['branch'] = this.branch;
    if (this.particularDetails != null) {
      data['particular_details'] =
          this.particularDetails!.map((v) => v.toJson()).toList();
    }
    if (this.exchangeDetails != null) {
      data['exchange_details'] =
          this.exchangeDetails!.map((v) => v.toJson()).toList();
    }
    data['old_purchase_details'] = this.oldPurchaseDetails;
    if (this.advanceDetails != null) {
      data['advance_details'] =
          this.advanceDetails!.map((v) => v.toJson()).toList();
    }
    if (this.chitDetails != null) {
      data['chit_details'] = this.chitDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ParticularDetails {
  String? sNo;
  String? tag;
  double? rate;
  double? minRate;
  int? pieces;
  int? remainingPieces;
  double? grossWeight;
  double? remainingGrossWeight;
  double? netWeight;
  double? remainingNetWeight;
  double? reduceWeight;
  double? wastagePercent;
  double? flatWastage;
  double? actualPayableAmount;
  double? makingChargePerGram;
  double? flatMakingCharge;
  double? minWastagePercent;
  double? minFlatWastage;
  double? minMakingChargePerGram;
  double? minFlatMakingCharge;
  double? stoneAmount;
  double? diamondAmount;
  double? huidAmount;
  double? totalAmount;
  double? gstPercent;
  double? gstAmount;
  double? payableAmount;
  String? calculationType;
  String? stockType;
  String? perGramWeightType;
  String? wastageWeightType;
  String? flatWastageType;
  String? makingChargeType;
  double? wastageWeightReduced;
  List<TagDetailStoneDetails>? stoneDetails;
  List<TagDetailDiamondDetails>? diamondDetails;

  ParticularDetails(
      {this.sNo,
      this.tag,
      this.rate,
      this.minRate,
      this.pieces,
      this.remainingPieces,
      this.grossWeight,
      this.remainingGrossWeight,
      this.reduceWeight,
      this.netWeight,
      this.remainingNetWeight,
      this.wastagePercent,
      this.flatWastage,
      this.makingChargePerGram,
      this.flatMakingCharge,
      this.minWastagePercent,
      this.actualPayableAmount,
      this.minFlatWastage,
      this.minMakingChargePerGram,
      this.minFlatMakingCharge,
      this.stoneAmount,
      this.diamondAmount,
      this.huidAmount,
      this.totalAmount,
      this.gstPercent,
      this.gstAmount,
      this.payableAmount,
      this.calculationType,
      this.stockType,
      this.perGramWeightType,
      this.wastageWeightType,
      this.flatWastageType,
      this.makingChargeType,
      this.wastageWeightReduced,
      this.stoneDetails,
      this.diamondDetails});

  ParticularDetails.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    tag = json['tag'];
    rate = json['rate'];
    minRate = json['min_rate'];
    pieces = json['pieces'];
    remainingPieces = json['remaining_pieces'];
    grossWeight = json['gross_weight'];
    remainingGrossWeight = json['remaining_gross_weight'];
    actualPayableAmount = json['actual_payable_amount'];
    reduceWeight = json['reduce_weight'];
    netWeight = json['net_weight'];
    remainingNetWeight = json['remaining_net_weight'];
    wastagePercent = json['wastage_percent'];
    flatWastage = json['flat_wastage'];
    makingChargePerGram = json['making_charge_per_gram'];
    flatMakingCharge = json['flat_making_charge'];
    minWastagePercent = json['min_wastage_percent'];
    minFlatWastage = json['min_flat_wastage'];
    minMakingChargePerGram = json['min_making_charge_per_gram'];
    minFlatMakingCharge = json['min_flat_making_charge'];
    stoneAmount = json['stone_amount'];
    diamondAmount = json['diamond_amount'];
    huidAmount = json['huid_amount'];
    totalAmount = json['total_amount'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    calculationType = json['calculation_type'];
    stockType = json['stock_type'];
    wastageWeightType = json['wastage_weight_type'];
    flatWastageType = json['flat_wastage_type'];
    makingChargeType = json['making_charge_type'];
    perGramWeightType = json['per_gram_weight_type'];
    wastageWeightReduced = json['wastage_weight_reduced'];
    if (json['stone_details'] != null) {
      stoneDetails = <TagDetailStoneDetails>[];
      json['stone_details'].forEach((v) {
        stoneDetails!.add(new TagDetailStoneDetails.fromJson(v));
      });
    }
    if (json['diamond_details'] != null) {
      diamondDetails = <TagDetailDiamondDetails>[];
      json['diamond_details'].forEach((v) {
        diamondDetails!.add(new TagDetailDiamondDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['tag'] = this.tag;
    data['rate'] = this.rate;
    data['min_rate'] = this.minRate;
    data['pieces'] = this.pieces;
    data['remaining_pieces'] = this.remainingPieces;
    data['gross_weight'] = this.grossWeight;
    data['remaining_gross_weight'] = this.remainingGrossWeight;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
    data['remaining_net_weight'] = this.remainingNetWeight;
    data['actual_payable_amount'] = this.actualPayableAmount;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['min_wastage_percent'] = this.minWastagePercent;
    data['min_flat_wastage'] = this.minFlatWastage;
    data['min_making_charge_per_gram'] = this.minMakingChargePerGram;
    data['min_flat_making_charge'] = this.minFlatMakingCharge;
    data['stone_amount'] = this.stoneAmount;
    data['diamond_amount'] = this.diamondAmount;
    data['huid_amount'] = this.huidAmount;
    data['total_amount'] = this.totalAmount;
    data['gst_percent'] = this.gstPercent;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['calculation_type'] = this.calculationType;
    data['stock_type'] = this.stockType;
    data['wastage_weight_type'] = this.wastageWeightType;
    data['flat_wastage_type'] = this.flatWastageType;
    data['making_charge_type'] = this.makingChargeType;
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['wastage_weight_reduced'] = this.wastageWeightReduced;
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
  int? stone;
  bool? reduceWeight;
  int? stonePieces;
  double? stoneWeight;
  double? stoneAmount;

  StoneDetails(
      {this.stone,
      this.reduceWeight,
      this.stonePieces,
      this.stoneWeight,
      this.stoneAmount});

  StoneDetails.fromJson(Map<String, dynamic> json) {
    stone = json['stone'];
    reduceWeight = json['reduce_weight'];
    stonePieces = json['stone_pieces'];
    stoneWeight = json['stone_weight'];
    stoneAmount = json['stone_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stone'] = this.stone;
    data['reduce_weight'] = this.reduceWeight;
    data['stone_pieces'] = this.stonePieces;
    data['stone_weight'] = this.stoneWeight;
    data['stone_amount'] = this.stoneAmount;
    return data;
  }
}

class DiamondDetails {
  int? diamond;
  bool? reduceWeight;
  int? diamondPieces;
  double? diamondWeight;
  double? diamondAmount;

  DiamondDetails(
      {this.diamond,
      this.reduceWeight,
      this.diamondPieces,
      this.diamondWeight,
      this.diamondAmount});

  DiamondDetails.fromJson(Map<String, dynamic> json) {
    diamond = json['diamond'];
    reduceWeight = json['reduce_weight'];
    diamondPieces = json['diamond_pieces'];
    diamondWeight = json['diamond_weight'];
    diamondAmount = json['diamond_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['diamond'] = this.diamond;
    data['reduce_weight'] = this.reduceWeight;
    data['diamond_pieces'] = this.diamondPieces;
    data['diamond_weight'] = this.diamondWeight;
    data['diamond_amount'] = this.diamondAmount;
    return data;
  }
}

class ExchangeDetails {
  String? id;
  String? oldMetal;
  String? oldItem;
  String? oldMetalName;
  double? oldGrossWeight;
  double? oldReduceWeight;
  double? oldTouch;
  double? oldRate;
  double? oldDustWeight;
  double? oldNetWeight;
  double? oldAmount;
  double? gstAmount;
  double? totalAmount;

  ExchangeDetails(
      {this.id,
      this.oldMetal,
      this.oldItem,
      this.oldMetalName,
      this.oldGrossWeight,
      this.oldReduceWeight,
      this.oldTouch,
      this.oldRate,
      this.oldDustWeight,
      this.oldNetWeight,
      this.oldAmount,
      this.gstAmount,
      this.totalAmount});

  ExchangeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldMetal = json['old_metal'];
    oldItem = json['item_name'];
    oldMetalName = json['old_metal_name'];
    oldGrossWeight = json['old_gross_weight'];
    oldReduceWeight = json['old_reduce_weight'];
    oldTouch = json['old_touch'];
    oldRate = json['old_rate'];
    oldDustWeight = json['old_dust_weight'];
    oldNetWeight = json['old_net_weight'];
    oldAmount = json['old_amount'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_metal'] = this.oldMetal;
    data['item_name'] = this.oldItem;
    data['old_metal_name'] = this.oldMetalName;
    data['old_gross_weight'] = this.oldGrossWeight;
    data['old_reduce_weight'] = this.oldReduceWeight;
    data['old_touch'] = this.oldTouch;
    data['old_rate'] = this.oldRate;
    data['old_dust_weight'] = this.oldDustWeight;
    data['old_net_weight'] = this.oldNetWeight;
    data['old_amount'] = this.oldAmount;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class EstimationAdvanceDetails {
  int? advanceDetails;
  String? advanceDetailsNo;
  double? redeemWeight;
  double? redeemMetalRate;
  double? redeemMetalValue;
  double? redeemAmount;
  double? totalAmount;

  EstimationAdvanceDetails(
      {this.advanceDetails,
      this.advanceDetailsNo,
      this.redeemWeight,
      this.redeemMetalRate,
      this.redeemMetalValue,
      this.redeemAmount,
      this.totalAmount});

  EstimationAdvanceDetails.fromJson(Map<String, dynamic> json) {
    advanceDetails = json['advance_details'];
    advanceDetailsNo = json['advance_details_no'];
    redeemWeight = json['redeem_weight'];
    redeemMetalRate = json['redeem_metal_rate'];
    redeemMetalValue = json['redeem_metal_value'];
    redeemAmount = json['redeem_amount'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['advance_details'] = this.advanceDetails;
    data['advance_details_no'] = this.advanceDetailsNo;
    data['redeem_weight'] = this.redeemWeight;
    data['redeem_metal_rate'] = this.redeemMetalRate;
    data['redeem_metal_value'] = this.redeemMetalValue;
    data['redeem_amount'] = this.redeemAmount;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class TagDetailsRetrieveData {
  int? id;
  String? tagNumber;
  String? measurementValue;
  String? huid;
  String? remark;
  int? pieces;
  double? metalRate;
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
  String? tagTypeName;
  String? tagTypeCode;
  String? calculationType;
  int? metalDetails;
  String? metalDetailsName;
  double? huidRate;
  String? stockType;
  double? minInterGstValue;
  double? interGstPercent;
  double? interGstValue;
  double? minIntraGstValue;
  double? intraGstPercent;
  double? intraGstValue;
  double? minWithoutGstRate;
  double? minInterSaleValue;
  double? minIntraSaleValue;
  double? interSaleValue;
  double? intraSaleValue;
  double? withoutGstRate;
  double? stoneReduceWeight;
  double? diamondReduceWeight;
  List<TagDetailStoneDetails>? stoneDetails;
  List<TagDetailDiamondDetails>? diamondDetails;

  TagDetailsRetrieveData(
      {this.id,
      this.tagNumber,
      this.measurementValue,
      this.huid,
      this.remark,
      this.pieces,
      this.metalRate,
      this.grossWeight,
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
      this.huidRate,
      this.stockType,
      this.minInterGstValue,
      this.interGstPercent,
      this.interGstValue,
      this.minIntraGstValue,
      this.intraGstPercent,
      this.intraGstValue,
      this.minWithoutGstRate,
      this.minInterSaleValue,
      this.minIntraSaleValue,
      this.interSaleValue,
      this.intraSaleValue,
      this.withoutGstRate,
      this.stoneReduceWeight,
      this.diamondReduceWeight,
      this.stoneDetails,
      this.diamondDetails});

  TagDetailsRetrieveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagNumber = json['tag_number'];
    measurementValue = json['measurement_value'];
    huid = json['huid'];
    remark = json['remark'];
    pieces = json['pieces'];
    metalRate = json['metal_rate'];
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
    huidRate = json['huid_rate'];
    stockType = json['stock_type'];
    minInterGstValue = json['min_inter_gst_value'];
    interGstPercent = double.parse(json['inter_gst_percent'].toString());
    interGstValue = double.parse(json['inter_gst_value'].toString());
    minIntraGstValue = json['min_intra_gst_value'];
    intraGstPercent = double.parse(json['intra_gst_percent'].toString());
    intraGstValue = double.parse(json['intra_gst_value'].toString());
    minWithoutGstRate = json['min_without_gst_rate'];
    minInterSaleValue = json['min_inter_sale_value'];
    minIntraSaleValue = json['min_intra_sale_value'];
    interSaleValue = json['inter_sale_value'];
    intraSaleValue = json['intra_sale_value'];
    withoutGstRate = json['without_gst_rate'];
    stoneReduceWeight = double.parse(json['stone_reduce_weight'].toString()??"0");
    diamondReduceWeight = double.parse(json['diamond_reduce_weight'].toString()??"0");
    if (json['stone_details'] != null) {
      stoneDetails = <TagDetailStoneDetails>[];
      json['stone_details'].forEach((v) {
        stoneDetails!.add(new TagDetailStoneDetails.fromJson(v));
      });
    }
    if (json['diamond_details'] != null) {
      diamondDetails = <TagDetailDiamondDetails>[];
      json['diamond_details'].forEach((v) {
        diamondDetails!.add(new TagDetailDiamondDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag_number'] = this.tagNumber;
    data['measurement_value'] = this.measurementValue;
    data['huid'] = this.huid;
    data['remark'] = this.remark;
    data['pieces'] = this.pieces;
    data['metal_rate'] = this.metalRate;
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
    data['huid_rate'] = this.huidRate;
    data['stock_type'] = this.stockType;
    data['min_inter_gst_value'] = this.minInterGstValue;
    data['inter_gst_percent'] = this.interGstPercent;
    data['inter_gst_value'] = this.interGstValue;
    data['min_intra_gst_value'] = this.minIntraGstValue;
    data['intra_gst_percent'] = this.intraGstPercent;
    data['intra_gst_value'] = this.intraGstValue;
    data['min_without_gst_rate'] = this.minWithoutGstRate;
    data['min_inter_sale_value'] = this.minInterSaleValue;
    data['min_intra_sale_value'] = this.minIntraSaleValue;
    data['inter_sale_value'] = this.interSaleValue;
    data['intra_sale_value'] = this.intraSaleValue;
    data['without_gst_rate'] = this.withoutGstRate;
    data['stone_reduce_weight'] = this.stoneReduceWeight;
    data['diamond_reduce_weight'] = this.diamondReduceWeight;
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

class TagDetailStoneDetails {
  String? id;
  bool? reduceWeight;
  int? stonePieces;
  double? stoneWeight;
  double? stoneAmount;
  double? rate;
  double? certificateAmount;
  int? tagItem;
  int? stone;
  String? stoneName;
  bool? isDb;
 
  TagDetailStoneDetails(
      {this.id,
      this.reduceWeight,
      this.stonePieces,
      this.stoneWeight,
      this.stoneAmount,
      this.rate,
      this.certificateAmount,
      this.tagItem,
      this.stone,
      this.stoneName,
      this.isDb});
 
  TagDetailStoneDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    reduceWeight = json['reduce_weight'];
    stonePieces = json['stone_pieces'];
    stoneWeight = json['stone_weight'];
    stoneAmount = json['stone_amount'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
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
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['tag_item'] = this.tagItem;
    data['stone'] = this.stone;
    data['stone_name'] = this.stoneName;
    data['is_db'] = this.isDb;
    return data;
  }
}
 
class TagDetailDiamondDetails {
  String? id;
  bool? reduceWeight;
  int? diamondPieces;
  double? diamondWeight;
  double? diamondAmount;
  double? rate;
  double? certificateAmount;
  int? tagItem;
  int? diamond;
  String? diamondName;
  bool? isDb;
 
  TagDetailDiamondDetails(
      {this.id,
      this.reduceWeight,
      this.diamondPieces,
      this.diamondWeight,
      this.diamondAmount,
      this.rate,
      this.certificateAmount,
      this.tagItem,
      this.diamond,
      this.diamondName,
      this.isDb});
 
  TagDetailDiamondDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    reduceWeight = json['reduce_weight'];
    diamondPieces = json['diamond_pieces'];
    diamondWeight = json['diamond_weight'];
    diamondAmount = json['diamond_amount'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
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
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['tag_item'] = this.tagItem;
    data['diamond'] = this.diamond;
    data['diamond_name'] = this.diamondName;
    data['is_db'] = this.isDb;
    return data;
  }
}

class OldPurchaseParticularsDetails {
  String? id;
  String? oldGoldBillNo;
  String? totalAmount;

  OldPurchaseParticularsDetails(
      {this.id, this.oldGoldBillNo, this.totalAmount});

  OldPurchaseParticularsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldGoldBillNo = json['old_gold_bill_no'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_gold_bill_no'] = this.oldGoldBillNo;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}
