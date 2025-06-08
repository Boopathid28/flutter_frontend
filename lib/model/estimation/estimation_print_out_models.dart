class PrintEstimationDetails {
  int? id;
  String? estimationId;
  String? estimationDate;
  double? totalAmount;
  String? gstType;
  double? gstAmount;
  double? advanceAmount;
  double? discountAmount;
  double? exchangeAmount;
  double? chitAmount;
  double? saleReturnAmount;
  double? roundoffAmount;
  double? payableAmount;
  double? balanceAmount;
  bool? isBilled;
  String? billNumber;
  String? billAt;
  String? createdAt;
  String? createdBy;
  int? metal;
  int? customerDetails;
  String? metalCode;
  PrintDisplayRate? displayRate;
  String? customerDetailsName;
  String? customerDetailsMobile;
  String? customerDetailsAddress;
  String? metalName;
  String? gstTypeName;
  double? totalBenefitAmount;
  double? totalBalanceWeight;
  double? totalSchemeWeight;
  double? stoneWeight;
  double? diamondWeight;
  List<PrintParticularDetails>? particularDetails;
  int? totalPieces;
  double? totalWeight;
  List<PrintOldGoldDetails>? oldGoldDetails;
  List<PrintExchangeDetails>? exchangeDetails;
  List<PrintOldPurchaseDetails>? oldPurchaseDetails;
  List<PrintAdvanceDetails>? advanceDetails;
  List<PrintChitDetails>? chitDetails;
  double? paidAmount;

  PrintEstimationDetails(
      {this.id,
      this.estimationId,
      this.estimationDate,
      this.totalAmount,
      this.gstType,
      this.gstAmount,
      this.advanceAmount,
      this.discountAmount,
      this.exchangeAmount,
      this.chitAmount,
      this.saleReturnAmount,
      this.roundoffAmount,
      this.payableAmount,
      this.balanceAmount,
      this.isBilled,
      this.billNumber,
      this.billAt,
      this.createdAt,
      this.createdBy,
      this.metal,
      this.customerDetails,
      this.metalCode,
      this.displayRate,
      this.customerDetailsName,
      this.customerDetailsMobile,
      this.customerDetailsAddress,
      this.metalName,
      this.gstTypeName,
      this.totalBenefitAmount,
      this.totalBalanceWeight,
      this.totalSchemeWeight,
      this.stoneWeight,
      this.diamondWeight,
      this.particularDetails,
      this.totalPieces,
      this.totalWeight,
      this.oldGoldDetails,
      this.exchangeDetails,
      this.oldPurchaseDetails,
      this.advanceDetails,
      this.chitDetails,
      this.paidAmount});

  PrintEstimationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estimationId = json['estimation_id'];
    estimationDate = json['estimation_date'];
    totalAmount = json['total_amount'];
    gstType = json['gst_type'];
    gstAmount = json['gst_amount'];
    advanceAmount = json['advance_amount'];
    discountAmount = json['discount_amount'];
    exchangeAmount = json['exchange_amount'];
    chitAmount = json['chit_amount'];
    saleReturnAmount = json['sale_return_amount'];
    roundoffAmount = json['roundoff_amount'];
    payableAmount = json['payable_amount'];
    balanceAmount = json['balance_amount'];
    isBilled = json['is_billed'];
    billNumber = json['bill_number'];
    billAt = json['bill_at'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    metal = json['metal'];
    customerDetails = json['customer_details'];
    metalCode = json['metal_code'];
    displayRate = json['display_rate'] != null
        ? new PrintDisplayRate.fromJson(json['display_rate'])
        : null;
    customerDetailsName = json['customer_details_name'];
    customerDetailsMobile = json['customer_details_mobile'];
    customerDetailsAddress = json['customer_details_address'];
    metalName = json['metal_name'];
    gstTypeName = json['gst_type_name'];
    totalBenefitAmount = json['total_benefit_amount'];
    totalBalanceWeight = json['total_balance_weight'];
    totalSchemeWeight = json['total_scheme_weight'];
    stoneWeight = json['stone_weight'];
    diamondWeight = json['diamond_weight'];
    if (json['particular_details'] != null) {
      particularDetails = <PrintParticularDetails>[];
      json['particular_details'].forEach((v) {
        particularDetails!.add(new PrintParticularDetails.fromJson(v));
      });
    }
    totalPieces = json['total_pieces'];
    totalWeight = json['total_weight'];
    if (json['old_gold_details'] != null) {
      oldGoldDetails = <PrintOldGoldDetails>[];
      json['old_gold_details'].forEach((v) {
        oldGoldDetails!.add(new PrintOldGoldDetails.fromJson(v));
      });
    }
    if (json['exchange_details'] != null) {
      exchangeDetails = <PrintExchangeDetails>[];
      json['exchange_details'].forEach((v) {
        exchangeDetails!.add(new PrintExchangeDetails.fromJson(v));
      });
    }
    if (json['old_purchase_details'] != null) {
      oldPurchaseDetails = <PrintOldPurchaseDetails>[];
      json['old_purchase_details'].forEach((v) {
        oldPurchaseDetails!.add(new PrintOldPurchaseDetails.fromJson(v));
      });
    }
    if (json['advance_details'] != null) {
      advanceDetails = <PrintAdvanceDetails>[];
      json['advance_details'].forEach((v) {
        advanceDetails!.add(new PrintAdvanceDetails.fromJson(v));
      });
    }
    if (json['chit_details'] != null) {
      chitDetails = <PrintChitDetails>[];
      json['chit_details'].forEach((v) {
        chitDetails!.add(new PrintChitDetails.fromJson(v));
      });
    }
    paidAmount = json['paid_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['estimation_id'] = this.estimationId;
    data['estimation_date'] = this.estimationDate;
    data['total_amount'] = this.totalAmount;
    data['gst_type'] = this.gstType;
    data['gst_amount'] = this.gstAmount;
    data['advance_amount'] = this.advanceAmount;
    data['discount_amount'] = this.discountAmount;
    data['exchange_amount'] = this.exchangeAmount;
    data['chit_amount'] = this.chitAmount;
    data['sale_return_amount'] = this.saleReturnAmount;
    data['roundoff_amount'] = this.roundoffAmount;
    data['payable_amount'] = this.payableAmount;
    data['balance_amount'] = this.balanceAmount;
    data['is_billed'] = this.isBilled;
    data['bill_number'] = this.billNumber;
    data['bill_at'] = this.billAt;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['metal'] = this.metal;
    data['customer_details'] = this.customerDetails;
    data['metal_code'] = this.metalCode;
    if (this.displayRate != null) {
      data['display_rate'] = this.displayRate!.toJson();
    }
    data['customer_details_name'] = this.customerDetailsName;
    data['customer_details_mobile'] = this.customerDetailsMobile;
    data['customer_details_address'] = this.customerDetailsAddress;
    data['metal_name'] = this.metalName;
    data['gst_type_name'] = this.gstTypeName;
    data['total_benefit_amount'] = this.totalBenefitAmount;
    data['total_balance_weight'] = this.totalBalanceWeight;
    data['total_scheme_weight'] = this.totalSchemeWeight;
    data['stone_weight'] = this.stoneWeight;
    data['diamond_weight'] = this.diamondWeight;
    if (this.particularDetails != null) {
      data['particular_details'] =
          this.particularDetails!.map((v) => v.toJson()).toList();
    }
    data['total_pieces'] = this.totalPieces;
    data['total_weight'] = this.totalWeight;
    if (this.oldGoldDetails != null) {
      data['old_gold_details'] =
          this.oldGoldDetails!.map((v) => v.toJson()).toList();
    }
    if (this.exchangeDetails != null) {
      data['exchange_details'] =
          this.exchangeDetails!.map((v) => v.toJson()).toList();
    }
    if (this.oldPurchaseDetails != null) {
      data['old_purchase_details'] =
          this.oldPurchaseDetails!.map((v) => v.toJson()).toList();
    }
    if (this.advanceDetails != null) {
      data['advance_details'] =
          this.advanceDetails!.map((v) => v.toJson()).toList();
    }
    if (this.chitDetails != null) {
      data['chit_details'] = this.chitDetails!.map((v) => v.toJson()).toList();
    }
    data['paid_amount'] = this.paidAmount;
    return data;
  }
}

class PrintDisplayRate {
  double? gold;
  double? silver;

  PrintDisplayRate({this.gold, this.silver});

  PrintDisplayRate.fromJson(Map<String, dynamic> json) {
    gold = json['gold'];
    silver = json['silver'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gold'] = this.gold;
    data['silver'] = this.silver;
    return data;
  }
}

class PrintParticularDetails {
  int? id;
  double? rate;
  int? pieces;
  double? grossWeight;
  double? reduceWeight;
  double? netWeight;
  double? wastagePercent;
  double? flatWastage;
  double? makingChargePerGram;
  double? flatMakingCharge;
  double? stoneAmount;
  double? diamondAmount;
  double? huidAmount;
  double? totalAmount;
  double? gstPercent;
  double? gstAmount;
  double? payableAmount;
  int? estimationDetails;
  int? tagDetails;
  String? tagNumber;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? measurementValue;
  String? measurementTypeName;
  String? metalDetailsName;
  String? purityDetailsName;
  String? hsnCode;
  String? hallmarkCenter;
  String? hallmarkCertificateNumber;
  double? wastageGram;
  List<PrintStoneDetails>? stoneDetails;
  List<PrintDiamondDetails>? diamondDetails;
  int? sNo;

  PrintParticularDetails(
      {this.id,
      this.rate,
      this.pieces,
      this.grossWeight,
      this.reduceWeight,
      this.netWeight,
      this.wastagePercent,
      this.flatWastage,
      this.makingChargePerGram,
      this.flatMakingCharge,
      this.stoneAmount,
      this.diamondAmount,
      this.huidAmount,
      this.totalAmount,
      this.gstPercent,
      this.gstAmount,
      this.payableAmount,
      this.estimationDetails,
      this.tagDetails,
      this.tagNumber,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.measurementValue,
      this.measurementTypeName,
      this.metalDetailsName,
      this.purityDetailsName,
      this.hsnCode,
      this.hallmarkCenter,
      this.hallmarkCertificateNumber,
      this.wastageGram,
      this.stoneDetails,
      this.diamondDetails,
      this.sNo});

  PrintParticularDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rate = json['rate'];
    pieces = json['pieces'];
    grossWeight = json['gross_weight'];
    reduceWeight = json['reduce_weight'];
    netWeight = json['net_weight'];
    wastagePercent = json['wastage_percent'];
    flatWastage = json['flat_wastage'];
    makingChargePerGram = json['making_charge_per_gram'];
    flatMakingCharge = json['flat_making_charge'];
    stoneAmount = json['stone_amount'];
    diamondAmount = json['diamond_amount'];
    huidAmount = json['huid_amount'];
    totalAmount = json['total_amount'];
    gstPercent = json['gst_percent'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    estimationDetails = json['estimation_details'];
    tagDetails = json['tag_details'];
    tagNumber = json['tag_number'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    measurementValue = json['measurement_value'];
    measurementTypeName = json['measurement_type_name'];
    metalDetailsName = json['metal_details_name'];
    purityDetailsName = json['purity_details_name'];
    hsnCode = json['hsn_code'];
    hallmarkCenter = json['hallmark_center'];
    hallmarkCertificateNumber = json['hallmark_certificate_number'];
    wastageGram = json['wastage_gram'];
    if (json['stone_details'] != null) {
      stoneDetails = <PrintStoneDetails>[];
      json['stone_details'].forEach((v) {
        stoneDetails!.add(new PrintStoneDetails.fromJson(v));
      });
    }
    if (json['diamond_details'] != null) {
      diamondDetails = <PrintDiamondDetails>[];
      json['diamond_details'].forEach((v) {
        diamondDetails!.add(new PrintDiamondDetails.fromJson(v));
      });
    }
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rate'] = this.rate;
    data['pieces'] = this.pieces;
    data['gross_weight'] = this.grossWeight;
    data['reduce_weight'] = this.reduceWeight;
    data['net_weight'] = this.netWeight;
    data['wastage_percent'] = this.wastagePercent;
    data['flat_wastage'] = this.flatWastage;
    data['making_charge_per_gram'] = this.makingChargePerGram;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['stone_amount'] = this.stoneAmount;
    data['diamond_amount'] = this.diamondAmount;
    data['huid_amount'] = this.huidAmount;
    data['total_amount'] = this.totalAmount;
    data['gst_percent'] = this.gstPercent;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['estimation_details'] = this.estimationDetails;
    data['tag_details'] = this.tagDetails;
    data['tag_number'] = this.tagNumber;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['measurement_value'] = this.measurementValue;
    data['measurement_type_name'] = this.measurementTypeName;
    data['metal_details_name'] = this.metalDetailsName;
    data['purity_details_name'] = this.purityDetailsName;
    data['hsn_code'] = this.hsnCode;
    data['hallmark_center'] = this.hallmarkCenter;
    data['hallmark_certificate_number'] = this.hallmarkCertificateNumber;
    data['wastage_gram'] = this.wastageGram;
    if (this.stoneDetails != null) {
      data['stone_details'] =
          this.stoneDetails!.map((v) => v.toJson()).toList();
    }
    if (this.diamondDetails != null) {
      data['diamond_details'] =
          this.diamondDetails!.map((v) => v.toJson()).toList();
    }
    data['s_no'] = this.sNo;
    return data;
  }
}

class PrintStoneDetails {
  int? id;
  bool? reduceWeight;
  int? stonePieces;
  double? stoneWeight;
  double? stoneAmount;
  int? estimationParticularDetails;
  int? stone;
  double? rate;
  String? stoneName;
  double? certificateAmount;

  PrintStoneDetails(
      {this.id,
      this.reduceWeight,
      this.stonePieces,
      this.stoneWeight,
      this.stoneAmount,
      this.estimationParticularDetails,
      this.stone,
      this.rate,
      this.stoneName,
      this.certificateAmount});

  PrintStoneDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reduceWeight = json['reduce_weight'];
    stonePieces = json['stone_pieces'];
    stoneWeight = json['stone_weight'];
    stoneAmount = json['stone_amount'];
    estimationParticularDetails = json['estimation_particular_details'];
    stone = json['stone'];
    rate = json['rate'];
    stoneName = json['stone_name'];
    certificateAmount = json['certificate_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reduce_weight'] = this.reduceWeight;
    data['stone_pieces'] = this.stonePieces;
    data['stone_weight'] = this.stoneWeight;
    data['stone_amount'] = this.stoneAmount;
    data['estimation_particular_details'] = this.estimationParticularDetails;
    data['stone'] = this.stone;
    data['rate'] = this.rate;
    data['stone_name'] = this.stoneName;
    data['certificate_amount'] = this.certificateAmount;
    return data;
  }
}

class PrintDiamondDetails {
  int? id;
  bool? reduceWeight;
  int? diamondPieces;
  double? diamondWeight;
  double? diamondAmount;
  int? estimationParticularDetails;
  int? diamond;
  double? rate;
  String? diamondName;
  double? certificateAmount;

  PrintDiamondDetails(
      {this.id,
      this.reduceWeight,
      this.diamondPieces,
      this.diamondWeight,
      this.diamondAmount,
      this.estimationParticularDetails,
      this.diamond,
      this.rate,
      this.diamondName,
      this.certificateAmount});

  PrintDiamondDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reduceWeight = json['reduce_weight'];
    diamondPieces = json['diamond_pieces'];
    diamondWeight = json['diamond_weight'];
    diamondAmount = json['diamond_amount'];
    estimationParticularDetails = json['estimation_particular_details'];
    diamond = json['diamond'];
    rate = json['rate'];
    diamondName = json['diamond_name'];
    certificateAmount = json['certificate_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reduce_weight'] = this.reduceWeight;
    data['diamond_pieces'] = this.diamondPieces;
    data['diamond_weight'] = this.diamondWeight;
    data['diamond_amount'] = this.diamondAmount;
    data['estimation_particular_details'] = this.estimationParticularDetails;
    data['diamond'] = this.diamond;
    data['rate'] = this.rate;
    data['diamond_name'] = this.diamondName;
    data['certificate_amount'] = this.certificateAmount;
    return data;
  }
}

class PrintOldGoldDetails {
  int? id;
  String? oldGoldBillNo;
  int? oldGoldPieces;
  double? oldGoldWeight;
  double? totalAmount;

  PrintOldGoldDetails(
      {this.id,
      this.oldGoldBillNo,
      this.oldGoldPieces,
      this.oldGoldWeight,
      this.totalAmount});

  PrintOldGoldDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldGoldBillNo = json['old_gold_bill_no'];
    oldGoldPieces = json['old_gold_pieces'];
    oldGoldWeight = json['old_gold_weight'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_gold_bill_no'] = this.oldGoldBillNo;
    data['old_gold_pieces'] = this.oldGoldPieces;
    data['old_gold_weight'] = this.oldGoldWeight;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class PrintExchangeDetails {
  double? oldGrossWeight;
  double? oldDustWeight;
  String? metalName;
  double? oldRate;
  double? totalAmount;

  PrintExchangeDetails(
      {this.oldGrossWeight,
      this.oldDustWeight,
      this.metalName,
      this.oldRate,
      this.totalAmount});

  PrintExchangeDetails.fromJson(Map<String, dynamic> json) {
    oldGrossWeight = json['old_gross_weight'];
    oldDustWeight = json['old_dust_weight'];
    metalName = json['metal_name'];
    oldRate = json['old_rate'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['old_gross_weight'] = this.oldGrossWeight;
    data['old_dust_weight'] = this.oldDustWeight;
    data['metal_name'] = this.metalName;
    data['old_rate'] = this.oldRate;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class PrintOldPurchaseDetails {
  String? oldBillNumber;
  int? oldGoldPieces;
  double? oldGoldWeight;
  double? oldGoldAmount;
  List<PrintParticularList>? particularList;

  PrintOldPurchaseDetails(
      {this.oldBillNumber,
      this.oldGoldPieces,
      this.oldGoldWeight,
      this.oldGoldAmount,
      this.particularList});

  PrintOldPurchaseDetails.fromJson(Map<String, dynamic> json) {
    oldBillNumber = json['old_bill_number'];
    oldGoldPieces = json['old_gold_pieces'];
    oldGoldWeight = json['old_gold_weight'];
    oldGoldAmount = json['old_gold_amount'];
    if (json['particular_list'] != null) {
      particularList = <PrintParticularList>[];
      json['particular_list'].forEach((v) {
        particularList!.add(new PrintParticularList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['old_bill_number'] = this.oldBillNumber;
    data['old_gold_pieces'] = this.oldGoldPieces;
    data['old_gold_weight'] = this.oldGoldWeight;
    data['old_gold_amount'] = this.oldGoldAmount;
    if (this.particularList != null) {
      data['particular_list'] =
          this.particularList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrintParticularList {
  double? oldGrossWeight;
  double? oldNetWeight;
  double? oldDustWeight;
  String? oldBillNumber;
  String? metalName;
  String? itemName;
  double? oldRate;
  double? totalAmount;

  PrintParticularList(
      {this.oldGrossWeight,
      this.oldNetWeight,
      this.oldDustWeight,
      this.oldBillNumber,
      this.metalName,
      this.itemName,
      this.oldRate,
      this.totalAmount});

  PrintParticularList.fromJson(Map<String, dynamic> json) {
    oldGrossWeight = json['old_gross_weight'];
    oldNetWeight = json['old_net_weight'];
    oldDustWeight = json['old_dust_weight'];
    oldBillNumber = json['old_bill_number'];
    metalName = json['metal_name'];
    itemName = json['item_name'];
    oldRate = json['old_rate'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['old_gross_weight'] = this.oldGrossWeight;
    data['old_net_weight'] = this.oldNetWeight;
    data['old_dust_weight'] = this.oldDustWeight;
    data['old_bill_number'] = this.oldBillNumber;
    data['metal_name'] = this.metalName;
    data['item_name'] = this.itemName;
    data['old_rate'] = this.oldRate;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class PrintAdvanceDetails {
  int? id;
  double? redeemWeight;
  double? redeemMetalRate;
  double? redeemMetalValue;
  double? redeemAmount;
  double? totalAmount;
  int? estimationDetails;
  int? advanceDetails;
  String? advanceId;

  PrintAdvanceDetails(
      {this.id,
      this.redeemWeight,
      this.redeemMetalRate,
      this.redeemMetalValue,
      this.redeemAmount,
      this.totalAmount,
      this.estimationDetails,
      this.advanceDetails,
      this.advanceId});

  PrintAdvanceDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    redeemWeight = json['redeem_weight'];
    redeemMetalRate = json['redeem_metal_rate'];
    redeemMetalValue = json['redeem_metal_value'];
    redeemAmount = json['redeem_amount'];
    totalAmount = json['total_amount'];
    estimationDetails = json['estimation_details'];
    advanceDetails = json['advance_details'];
    advanceId = json['advance_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['redeem_weight'] = this.redeemWeight;
    data['redeem_metal_rate'] = this.redeemMetalRate;
    data['redeem_metal_value'] = this.redeemMetalValue;
    data['redeem_amount'] = this.redeemAmount;
    data['total_amount'] = this.totalAmount;
    data['estimation_details'] = this.estimationDetails;
    data['advance_details'] = this.advanceDetails;
    data['advance_id'] = this.advanceId;
    return data;
  }
}

class PrintChitDetails {
  int? id;
  double? totalAmount;
  double? benefitAmount;
  double? schemeWeight;
  double? balanceWeight;
  int? estimationDetails;
  List<PrintDenominationDetails>? denominationDetails;

  PrintChitDetails(
      {this.id,
      this.totalAmount,
      this.benefitAmount,
      this.schemeWeight,
      this.balanceWeight,
      this.estimationDetails,
      this.denominationDetails});

  PrintChitDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['total_amount'];
    benefitAmount = json['benefit_amount'];
    schemeWeight = json['scheme_weight'];
    balanceWeight = json['balance_weight'];
    estimationDetails = json['estimation_details'];
    if (json['denomination_details'] != null) {
      denominationDetails = <PrintDenominationDetails>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new PrintDenominationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['total_amount'] = this.totalAmount;
    data['benefit_amount'] = this.benefitAmount;
    data['scheme_weight'] = this.schemeWeight;
    data['balance_weight'] = this.balanceWeight;
    data['estimation_details'] = this.estimationDetails;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PrintDenominationDetails {
  int? id;
  String? schemeAccountNumber;
  double? schemeWeight;
  double? schemeAmount;
  double? bonusAmount;
  int? chitDetails;

  PrintDenominationDetails(
      {this.id,
      this.schemeAccountNumber,
      this.schemeWeight,
      this.schemeAmount,
      this.bonusAmount,
      this.chitDetails});

  PrintDenominationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    schemeAccountNumber = json['scheme_account_number'];
    schemeWeight = json['scheme_weight'];
    schemeAmount = json['scheme_amount'];
    bonusAmount = json['bonus_amount'];
    chitDetails = json['chit_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['scheme_account_number'] = this.schemeAccountNumber;
    data['scheme_weight'] = this.schemeWeight;
    data['scheme_amount'] = this.schemeAmount;
    data['bonus_amount'] = this.bonusAmount;
    data['chit_details'] = this.chitDetails;
    return data;
  }
}
