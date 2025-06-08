import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';

class InvoicePayload {
  int? menuId;
  String? billDate;
  int? customerDetails;
  String? metal;
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
  double? orderAmount;
  String? branch;
  List<String>? orderDetails;
  bool? isPayment;
  bool? isIssued;
  List<ParticularDetails>? particularDetails;
  List<int>? exchangeDetails;
  List<int>? suspenseDetails;
  List<InvoiceAdvanceDetails>? advanceDetails;
  List<PaymentDenominationDetails>? paymentDenominationDetails;
  List<ChitPaymentDetails>? chitDetails;

  InvoicePayload(
      {this.menuId,
      this.billDate,
      this.customerDetails,
      this.metal,
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
      this.orderAmount,
      this.branch,
      this.orderDetails,
      this.isIssued,
      this.particularDetails,
      this.exchangeDetails,
      this.isPayment,
      this.advanceDetails,
      this.paymentDenominationDetails,
      this.suspenseDetails,
      this.chitDetails});

  InvoicePayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    billDate = json['bill_date'];
    customerDetails = json['customer_details'];
    metal = json['metal'];
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
    orderAmount = json['order_amount'];
    isPayment = json['is_payment'];
    orderDetails = json['order_details'].cast<String>();
    isIssued = json['is_issued'];
    branch = json['branch'];
    if (json['particular_details'] != null) {
      particularDetails = <ParticularDetails>[];
      json['particular_details'].forEach((v) {
        particularDetails!.add(new ParticularDetails.fromJson(v));
      });
    }
    exchangeDetails = json['exchange_details'].cast<int>();
    suspenseDetails = json['suspense_details'].cast<int>();
    if (json['advance_details'] != null) {
      advanceDetails = <InvoiceAdvanceDetails>[];
      json['advance_details'].forEach((v) {
        advanceDetails!.add(new InvoiceAdvanceDetails.fromJson(v));
      });
    }
    if (json['payment_denomination_details'] != null) {
      paymentDenominationDetails = <PaymentDenominationDetails>[];
      json['advance_details'].forEach((v) {
        paymentDenominationDetails!.add(new PaymentDenominationDetails.fromJson(v));
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
    data['bill_date'] = this.billDate;
    data['customer_details'] = this.customerDetails;
    data['metal'] = this.metal;
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
    data['order_amount'] = this.orderAmount;
    data['is_payment'] = this.isPayment;
    data['is_issued'] = this.isIssued;
    data['order_details'] = this.orderDetails;
    data['branch'] = this.branch;
    if (this.particularDetails != null) {
      data['particular_details'] =
          this.particularDetails!.map((v) => v.toJson()).toList();
    }
    data['exchange_details'] = this.exchangeDetails;
    data['suspense_details'] = this.suspenseDetails;
    if (this.advanceDetails != null) {
      data['advance_details'] =
          this.advanceDetails!.map((v) => v.toJson()).toList();
    }
    if (this.paymentDenominationDetails != null) {
      data['payment_denomination_details'] =
          this.paymentDenominationDetails!.map((v) => v.toJson()).toList();
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
  String? subItem;
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
  double? withoutgsttotalAmount;
  double? gstPercent;
  double? gstAmount;
  double? intergstAmount;
  double? intragstAmount;
  double? payableAmount;
  double? interpayableAmount;
  double? intrapayableAmount;
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
      this.actualPayableAmount,
      this.reduceWeight,
      this.netWeight,
      this.subItem,
      this.remainingNetWeight,
      this.wastagePercent,
      this.flatWastage,
      this.makingChargePerGram,
      this.flatMakingCharge,
      this.minWastagePercent,
      this.minFlatWastage,
      this.minMakingChargePerGram,
      this.minFlatMakingCharge,
      this.stoneAmount,
      this.diamondAmount,
      this.huidAmount,
      this.totalAmount,
      this.withoutgsttotalAmount,
      this.gstPercent,
      this.gstAmount,
      this.intragstAmount,
      this.intergstAmount,
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
    tag = json['tag_number'];
    rate = json['rate'];
    minRate = json['min_rate'];
    pieces = json['pieces'];
    subItem = json['sub_item'];
    actualPayableAmount = json['actual_payable_amount'];
    remainingPieces = json['remaining_pieces'];
    grossWeight = json['gross_weight'];
    remainingGrossWeight = json['remaining_gross_weight'];
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
    withoutgsttotalAmount = json['without_gst_rate'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    intragstAmount = json['intra_gst_value'];
    intergstAmount = json['inter_gst_value'];
    payableAmount = json['payable_amount'];
    intrapayableAmount = json['intra_sale_value'];
    interpayableAmount = json['inter_sale_value'];
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
    data['tag_number'] = this.tag;
    data['rate'] = this.rate;
    data['min_rate'] = this.minRate;
    data['pieces'] = this.pieces;
    data['sub_item'] = this.subItem;
    data['remaining_pieces'] = this.remainingPieces;
    data['gross_weight'] = this.grossWeight;
    data['remaining_gross_weight'] = this.remainingGrossWeight;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
    data['remaining_net_weight'] = this.remainingNetWeight;
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
    data['actual_payable_amount'] = this.actualPayableAmount;
    data['huid_amount'] = this.huidAmount;
    data['total_amount'] = this.totalAmount;
    data['withoutgsttotalAmount'] = this.withoutgsttotalAmount;
    data['gst_percent'] = this.gstPercent;
    data['gst_amount'] = this.gstAmount;
    data['intra_gst_value'] = this.intragstAmount;
    data['inter_gst_value'] = this.intergstAmount;
    data['payable_amount'] = this.payableAmount;
    data['inter_sale_value'] = this.interpayableAmount;
    data['intra_sale_value'] = this.intrapayableAmount;
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
  String? oldMetalName;
  double? oldWeight;
  double? oldRate;
  double? oldDustWeight;
  double? oldNetWeight;
  double? oldAmount;
  double? gstAmount;
  double? totalAmount;

  ExchangeDetails(
      {this.id,
      this.oldMetal,
      this.oldMetalName,
      this.oldWeight,
      this.oldRate,
      this.oldDustWeight,
      this.oldNetWeight,
      this.oldAmount,
      this.gstAmount,
      this.totalAmount});

  ExchangeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldMetal = json['old_metal'];
    oldMetalName = json['old_metal_name'];
    oldWeight = json['old_weight'];
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
    data['old_metal_name'] = this.oldMetalName;
    data['old_weight'] = this.oldWeight;
    data['old_rate'] = this.oldRate;
    data['old_dust_weight'] = this.oldDustWeight;
    data['old_net_weight'] = this.oldNetWeight;
    data['old_amount'] = this.oldAmount;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class InvoiceAdvanceDetails {
  int? advanceDetails;
  String? advanceDetailsNo;
  double? redeemWeight;
  double? redeemMetalRate;
  double? redeemMetalValue;
  double? redeemAmount;
  double? totalAmount;

  InvoiceAdvanceDetails(
      {this.advanceDetails,
      this.advanceDetailsNo,
      this.redeemWeight,
      this.redeemMetalRate,
      this.redeemMetalValue,
      this.redeemAmount,
      this.totalAmount});

  InvoiceAdvanceDetails.fromJson(Map<String, dynamic> json) {
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
  double? rate;
  double? certificateAmount;
  double? diamondAmount;
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

class InvoiceSuspenseFetchParticularsDetails {
  String? id;
  String? suspenseId;
  String? totalAmount;

  InvoiceSuspenseFetchParticularsDetails(
      {this.id, this.suspenseId, this.totalAmount});

  InvoiceSuspenseFetchParticularsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suspenseId = json['suspense_id'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['suspense_id'] = this.suspenseId;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class PaymentDenominationDetails {
  String? sNo;
  String? paymentMethod;
  String? paymentMethodName;
  String? paymentProviderName;
  String? paymentProvider;
  double? paidAmount;
  String? remark;

  PaymentDenominationDetails(
      {this.paymentMethod,
      this.sNo,
      this.paymentMethodName,
      this.paymentProviderName,
      this.paymentProvider,
      this.paidAmount,
      this.remark});

  PaymentDenominationDetails.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    paymentMethod = json['payment_method'];
    paymentMethodName = json['payment_method_name'];
    paymentProviderName = json['payment_provider_name'];
    paymentProvider = json['payment_provider'];
    paidAmount = json['paid_amount'];
    remark = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['payment_method'] = this.paymentMethod;
    data['payment_method_name'] = this.paymentMethodName;
    data['payment_provider_name'] = this.paymentProviderName;
    data['payment_provider'] = this.paymentProvider;
    data['paid_amount'] = this.paidAmount;
    data['remarks'] = this.remark;
    return data;
  }
}

class CreateSuspensePayload {
  int? menuId;
  String? customerDetails;
  String? branch;
  String? remarks;
  List<InvoiceSuspenseItemDetails>? itemDetails;

  CreateSuspensePayload(
      {this.menuId, this.customerDetails, this.branch, this.itemDetails, this.remarks});

  CreateSuspensePayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    remarks = json['remarks'];
    if (json['item_details'] != null) {
      itemDetails = <InvoiceSuspenseItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new InvoiceSuspenseItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    data['remarks'] = this.remarks;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceSuspenseItemDetails {
  String? sNo;
  int? metalDetails;
  String? metalName;
  String? itemDetails;
  String? itemDetailsName;
  String? subItemDetails;
  String? subItemDetailsName;
  double? metalWeight;
  double? metalAmount;
  double? totalAmount;

  InvoiceSuspenseItemDetails(
      {this.sNo,
      this.metalDetails,
      this.metalName,
      this.itemDetails,
      this.itemDetailsName,
      this.subItemDetails,
      this.subItemDetailsName,
      this.metalWeight,
      this.metalAmount,
      this.totalAmount});

  InvoiceSuspenseItemDetails.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    metalDetails = json['metal_details'];
    metalName = json['metal_name'];
    itemDetails = json['item_details'];
    itemDetailsName = json['item_details_name'];
    subItemDetails = json['sub_item_details'];
    subItemDetailsName = json['sub_item_details_name'];
    metalWeight = json['metal_weight'];
    metalAmount = json['metal_amount'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['metal_details'] = this.metalDetails;
    data['metal_name'] = this.metalName;
    data['item_details'] = this.itemDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details'] = this.subItemDetails;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['metal_weight'] = this.metalWeight;
    data['metal_amount'] = this.metalAmount;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class InvoiceCreateSuspenseResponse {
  int? id;
  String? suspenseId;
  bool? isRedeemed;
  String? billNumber;
  bool? isCancelled;
  String? createdAt;
  String? createdBy;
  String? branchName;
  int? customerDetails;
  int? branch;

  InvoiceCreateSuspenseResponse(
      {this.id,
      this.suspenseId,
      this.isRedeemed,
      this.billNumber,
      this.isCancelled,
      this.createdAt,
      this.createdBy,
      this.branchName,
      this.customerDetails,
      this.branch});

  InvoiceCreateSuspenseResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suspenseId = json['suspense_id'];
    isRedeemed = json['is_redeemed'];
    billNumber = json['bill_number'];
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['suspense_id'] = this.suspenseId;
    data['is_redeemed'] = this.isRedeemed;
    data['bill_number'] = this.billNumber;
    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    return data;
  }
}

class InvoiceSuspenseRetrieveDetails {
  int? id;
  String? suspenseId;
  bool? isRedeemed;
  String? billNumber;
  bool? isCancelled;
  String? dueDate;
  bool? isClosed;
  String? closedBy;
  String? closedDate;
  String? remark;
  String? createdAt;
  String? createdBy;
  int? customerDetails;
  String? customerDetailsName;
  double? suspenseAmount;
  double? suspenseWeight;
  double? totalPaidAmount;
  double? remainingAmount;

  InvoiceSuspenseRetrieveDetails(
      {this.id,
      this.suspenseId,
      this.isRedeemed,
      this.billNumber,
      this.isCancelled,
      this.dueDate,
      this.isClosed,
      this.closedBy,
      this.closedDate,
      this.remark,
      this.createdAt,
      this.createdBy,
      this.customerDetails,
      this.customerDetailsName,
      this.suspenseAmount,
      this.suspenseWeight,
      this.totalPaidAmount,
      this.remainingAmount});

  InvoiceSuspenseRetrieveDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suspenseId = json['suspense_id'];
    isRedeemed = json['is_redeemed'];
    billNumber = json['bill_number'];
    isCancelled = json['is_cancelled'];
    dueDate = json['due_date'];
    isClosed = json['is_closed'];
    closedBy = json['closed_by'];
    closedDate = json['closed_date'];
    remark = json['remark'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    customerDetails = json['customer_details'];
    customerDetailsName = json['customer_details_name'];
    suspenseAmount = json['suspense_amount'];
    suspenseWeight = json['suspense_weight'];
    totalPaidAmount = json['total_paid_amount'];
    remainingAmount = json['remaining_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['suspense_id'] = this.suspenseId;
    data['is_redeemed'] = this.isRedeemed;
    data['bill_number'] = this.billNumber;
    data['is_cancelled'] = this.isCancelled;
    data['due_date'] = this.dueDate;
    data['is_closed'] = this.isClosed;
    data['closed_by'] = this.closedBy;
    data['closed_date'] = this.closedDate;
    data['remark'] = this.remark;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['customer_details'] = this.customerDetails;
    data['customer_details_name'] = this.customerDetailsName;
    data['suspense_amount'] = this.suspenseAmount;
    data['suspense_weight'] = this.suspenseWeight;
    data['total_paid_amount'] = this.totalPaidAmount;
    data['remaining_amount'] = this.remainingAmount;
    return data;
  }
}

class InvoiceOldPurchasePayload {
  int? menuId;
  int? customerDetails;
  String? branch;
  List<InvoiceOldItemDetails>? oldItemDetails;

  InvoiceOldPurchasePayload(
      {this.menuId, this.customerDetails, this.branch, this.oldItemDetails});

  InvoiceOldPurchasePayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    if (json['old_item_details'] != null) {
      oldItemDetails = <InvoiceOldItemDetails>[];
      json['old_item_details'].forEach((v) {
        oldItemDetails!.add(new InvoiceOldItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    if (this.oldItemDetails != null) {
      data['old_item_details'] =
          this.oldItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceOldItemDetails {
  String? id;
  String? oldMetal;
  String? oldMetalName;
  String? oldItemName;
  double? oldWeight;
  double? oldRate;
  double? oldDustWeight;
  double? oldNetWeight;
  double? grossWeight;
  double? reduceWeight;
  double? touch;
  double? gstAmount;
  double? totalAmount;

  InvoiceOldItemDetails(
      {this.id,
      this.oldMetal,
      this.oldMetalName,
      this.oldItemName,
      this.oldWeight,
      this.oldRate,
      this.oldDustWeight,
      this.oldNetWeight,
      this.grossWeight,
      this.reduceWeight,
      this.touch,
      this.gstAmount,
      this.totalAmount});

  InvoiceOldItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldMetal = json['old_metal'];
    oldMetalName = json['old_metal_name'];
    oldItemName = json['item_name'];
    oldWeight = json['old_weight'];
    oldRate = json['old_rate'];
    oldDustWeight = json['old_dust_weight'];
    oldNetWeight = json['old_net_weight'];
    grossWeight = json['old_gross_weight'];
    reduceWeight = json['old_reduce_weight'];
    touch = json['old_touch'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_metal'] = this.oldMetal;
    data['old_metal_name'] = this.oldMetalName;
    data['item_name'] = this.oldItemName;
    data['old_weight'] = this.oldWeight;
    data['old_rate'] = this.oldRate;
    data['old_dust_weight'] = this.oldDustWeight;
    data['old_net_weight'] = this.oldNetWeight;
    data['old_gross_weight'] = this.grossWeight;
    data['old_reduce_weight'] = this.reduceWeight;
    data['old_touch'] = this.touch;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class InvoiceOldPurchaseCreateResponse {
  int? id;
  String? oldGoldBillNumber;
  int? oldId;
  double? oldGoldWeight;
  int? oldGoldPieces;
  String? gstType;
  double? gstPercent;
  double? totalGstAmount;
  double? oldGoldAmount;
  bool? isBilled;
  String? refferenceNumber;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? customerDetails;
  int? branch;

  InvoiceOldPurchaseCreateResponse(
      {this.id,
      this.oldGoldBillNumber,
      this.oldId,
      this.oldGoldWeight,
      this.oldGoldPieces,
      this.gstType,
      this.gstPercent,
      this.totalGstAmount,
      this.oldGoldAmount,
      this.isBilled,
      this.refferenceNumber,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.customerDetails,
      this.branch});

  InvoiceOldPurchaseCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldGoldBillNumber = json['old_gold_bill_number'];
    oldId = json['old_id'];
    oldGoldWeight = json['old_gold_weight'];
    oldGoldPieces = json['old_gold_pieces'];
    gstType = json['gst_type'];
    gstPercent = json['gst_percent'];
    totalGstAmount = json['total_gst_amount'];
    oldGoldAmount = json['old_gold_amount'];
    isBilled = json['is_billed'];
    refferenceNumber = json['refference_number'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_gold_bill_number'] = this.oldGoldBillNumber;
    data['old_id'] = this.oldId;
    data['old_gold_weight'] = this.oldGoldWeight;
    data['old_gold_pieces'] = this.oldGoldPieces;
    data['gst_type'] = this.gstType;
    data['gst_percent'] = this.gstPercent;
    data['total_gst_amount'] = this.totalGstAmount;
    data['old_gold_amount'] = this.oldGoldAmount;
    data['is_billed'] = this.isBilled;
    data['refference_number'] = this.refferenceNumber;
    data['is_canceled'] = this.isCanceled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    return data;
  }
}



class OrderTagDetailsListData {
  String? customerMobile;
  String? orderId;
  String? metalId;
  String? metalName;
  String? customerName;
  double? orderTotalAmount;
  String? gstType;
  int? orderDetailsId;
  List<TagDetailsRetrieveData>? itemDetails;

  OrderTagDetailsListData(
      {this.customerMobile,this.orderId, this.metalId, this.metalName, this.customerName,this.orderTotalAmount, this.gstType, this.itemDetails, this.orderDetailsId});

  OrderTagDetailsListData.fromJson(Map<String, dynamic> json) {
    customerMobile = json['customer_mobile'];
    orderId = json['order_id'];
    metalId = json['metal'].toString();
    metalName = json['metal_name'];
    customerName = json['customer_name'];
    orderTotalAmount = json['order_total_amount'];
    gstType = json['gst_type'];
    orderDetailsId = json['order_details_id'];
    if (json['item_details'] != null) {
      itemDetails = <TagDetailsRetrieveData>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new TagDetailsRetrieveData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_mobile'] = this.customerMobile;
    data['order_id'] = this.orderId;
    data['metal'] = this.metalId;
    data['metal_name'] = this.metalName;
    data['customer_name'] = this.customerName;
    data['order_total_amount'] = this.orderTotalAmount;
    data['gst_type'] = this.gstType;
    data['order_details_id'] = this.orderDetailsId;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class SubItemGetDataListMannualEstimation {
  int? id;
  String? subItemName;
  String? subItemCode;
  String? hsnCode;
  String? stockType;
  String? measurementType;
  String? calculationType;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? itemDetails;
  double? metalRate;
  double? huidRate;
  String? itemName;
  int? metal;
  String? metalName;
  int? purity;
  String? purityName;
  String? measurementTypeName;
  String? stockTypeName;
  String? calculationTypeName;
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
  String? wastageCalculationTypeName;
  String? flatWastageTypeName;
  String? makingChargeCalculationTypeName;
  String? perGramWeightTypeName;
   double? intraGst;
  double? interGst;
 
  SubItemGetDataListMannualEstimation(
      {this.id,
      this.subItemName,
      this.subItemCode,
      this.hsnCode,
      this.stockType,
      this.measurementType,
      this.calculationType,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.itemDetails,
      this.metalRate,
      this.huidRate,
      this.itemName,
      this.metal,
      this.metalName,
      this.purity,
      this.purityName,
      this.measurementTypeName,
      this.stockTypeName,
      this.calculationTypeName,
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
      this.wastageCalculationTypeName,
      this.flatWastageTypeName,
      this.makingChargeCalculationTypeName,
      this.intraGst, this.interGst,
      this.perGramWeightTypeName});
 
  SubItemGetDataListMannualEstimation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subItemName = json['sub_item_name'];
    subItemCode = json['sub_item_code'];
    hsnCode = json['hsn_code'];
    stockType = json['stock_type'];
    measurementType = json['measurement_type'];
    calculationType = json['calculation_type'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    itemDetails = json['item_details'];
    metalRate = json['metal_rate'];
    huidRate = json['huid_rate'];
    itemName = json['item_name'];
    metal = json['metal'];
    metalName = json['metal_name'];
    purity = json['purity'];
    purityName = json['purity_name'];
    measurementTypeName = json['measurement_type_name'];
    stockTypeName = json['stock_type_name'];
    calculationTypeName = json['calculation_type_name'];
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
    wastageCalculationTypeName = json['wastage_calculation_type_name'];
    flatWastageTypeName = json['flat_wastage_type_name'];
    makingChargeCalculationTypeName =
        json['making_charge_calculation_type_name'];
    perGramWeightTypeName = json['per_gram_weight_type_name'];
    intraGst = json['intra_gst'];
    interGst = json['inter_gst'];
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
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['item_details'] = this.itemDetails;
    data['metal_rate'] = this.metalRate;
    data['huid_rate'] = this.huidRate;
    data['item_name'] = this.itemName;
    data['metal'] = this.metal;
    data['metal_name'] = this.metalName;
    data['purity'] = this.purity;
    data['purity_name'] = this.purityName;
    data['measurement_type_name'] = this.measurementTypeName;
    data['stock_type_name'] = this.stockTypeName;
    data['calculation_type_name'] = this.calculationTypeName;
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
    data['wastage_calculation_type_name'] = this.wastageCalculationTypeName;
    data['flat_wastage_type_name'] = this.flatWastageTypeName;
    data['making_charge_calculation_type_name'] =
        this.makingChargeCalculationTypeName;
    data['per_gram_weight_type_name'] = this.perGramWeightTypeName;
     data['intra_gst'] = this.intraGst;
    data['inter_gst'] = this.interGst;
    return data;
  }
}
