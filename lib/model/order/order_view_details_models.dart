class RetrieveOrderDetails {
  int? id;
  String? orderId;
  String? todayrate;
  bool? isFixed;
  double? totalAmount;
  String? gstType;
  String? metalName;
  double? gstAmount;
  double? payableAmount;
  PrintDisplayRate? displayRate;
  double? balanceAmount;
  bool? isCanceled;
  bool? isBilled;
  String? refferenceNumber;
  String? dueDate;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? customerDetails;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  double? totalBenefitAmount;
  double? totalBalanceWeight;
  double? totalSchemeWeight;
  List<ExchangeDetails>? exchangeDetails;
  List<ChitDetails>? chitDetails;
  List<AdvanceDetails>? advanceDetails;
  double? totalExchangeAmount;
  double? totalAdvanceAmount;
  double? totalChitAmount;
  double? paidAmount;
  List<ItemDetails>? itemDetails;
  List<NotissuedItemDetails>? notissuedItemDetails;
  List<IssuedItemDetails>? issuedItemDetails;
  List<NotReceiveditemDetails>? notReceiveditemDetails;
  List<ReceivedItemDetails>? receivedItemDetails;  

  RetrieveOrderDetails(
      {this.id,
      this.orderId,
      this.isFixed,
      this.todayrate,
      this.totalAmount,
      this.gstType,
      this.metalName,
      this.gstAmount,
      this.payableAmount,
      this.balanceAmount,
      this.isCanceled,
      this.isBilled,
      this.refferenceNumber,
      this.dueDate,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.customerDetails,
      this.customerName,
      this.customerPhone,
      this.customerAddress,
      this.totalBenefitAmount,
      this.totalBalanceWeight,
      this.totalSchemeWeight,
      this.exchangeDetails,
      this.chitDetails,
      this.advanceDetails,
      this.totalExchangeAmount,
      this.totalAdvanceAmount,
      this.totalChitAmount,
      this.paidAmount,
      this.itemDetails,
      this.notissuedItemDetails,
      this.issuedItemDetails,
      this.notReceiveditemDetails,
      this.receivedItemDetails});

  RetrieveOrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    isFixed = json['is_fixed'];
    todayrate = json['today_rate'];
    totalAmount = json['total_amount'];
    gstType = json['gst_type'];
    gstAmount = json['gst_amount'];
    metalName = json['metal_name'];
    payableAmount = json['payable_amount'];
    balanceAmount = json['balance_amount'];
    isCanceled = json['is_canceled'];
    isBilled = json['is_billed'];
    refferenceNumber = json['refference_number'];
    dueDate = json['due_date'];
    createdAt = json['created_at'];
    displayRate = json['display_rate'] != null
        ? new PrintDisplayRate.fromJson(json['display_rate'])
        : null;
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    customerDetails = json['customer_details'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    totalBenefitAmount = json['total_benefit_amount'];
    totalBalanceWeight = json['total_balance_weight'];
    totalSchemeWeight = json['total_scheme_weight'];
    if (json['exchange_details'] != null) {
      exchangeDetails = <ExchangeDetails>[];
      json['exchange_details'].forEach((v) {
        exchangeDetails!.add(new ExchangeDetails.fromJson(v));
      });
    }
    if (json['chit_details'] != null) {
      chitDetails = <ChitDetails>[];
      json['chit_details'].forEach((v) {
        chitDetails!.add(new ChitDetails.fromJson(v));
      });
    }
    if (json['advance_details'] != null) {
      advanceDetails = <AdvanceDetails>[];
      json['advance_details'].forEach((v) {
        advanceDetails!.add(new AdvanceDetails.fromJson(v));
      });
    }
    totalExchangeAmount = json['total_exchange_amount'];
    totalAdvanceAmount = json['total_advance_amount'];
    totalChitAmount = json['total_chit_amount'];
    paidAmount = json['paid_amount'];
    if (json['item_details'] != null) {
      itemDetails = <ItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new ItemDetails.fromJson(v));
      });
    }
    if (json['notissued_item_details'] != null) {
      notissuedItemDetails = <NotissuedItemDetails>[];
      json['notissued_item_details'].forEach((v) {
        notissuedItemDetails!.add(new NotissuedItemDetails.fromJson(v));
      });
    }
    if (json['issued_item_details'] != null) {
      issuedItemDetails = <IssuedItemDetails>[];
      json['issued_item_details'].forEach((v) {
        issuedItemDetails!.add(new IssuedItemDetails.fromJson(v));
      });
    }
    if (json['not_receiveditem_details'] != null) {
      notReceiveditemDetails = <NotReceiveditemDetails>[];
      json['not_receiveditem_details'].forEach((v) {
        notReceiveditemDetails!.add(new NotReceiveditemDetails.fromJson(v));
      });
    }
    if (json['received_item_details'] != null) {
      receivedItemDetails = <ReceivedItemDetails>[];
      json['received_item_details'].forEach((v) {
        receivedItemDetails!.add(new ReceivedItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['is_fixed'] = this.isFixed;
    data['total_amount'] = this.totalAmount;
    data['today_rate'] = this.todayrate;
    data['gst_type'] = this.gstType;
    data['gst_amount'] = this.gstAmount;
    data['metal_name'] = this.metalName;
    data['payable_amount'] = this.payableAmount;
    data['balance_amount'] = this.balanceAmount;
    data['is_canceled'] = this.isCanceled;
    data['is_billed'] = this.isBilled;
    data['refference_number'] = this.refferenceNumber;
    data['due_date'] = this.dueDate;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    if (this.displayRate != null) {
      data['display_rate'] = this.displayRate!.toJson();
    }
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['customer_details'] = this.customerDetails;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['total_benefit_amount'] = this.totalBenefitAmount;
    data['total_balance_weight'] = this.totalBalanceWeight;
    data['total_scheme_weight'] = this.totalSchemeWeight;
    if (this.exchangeDetails != null) {
      data['exchange_details'] =
          this.exchangeDetails!.map((v) => v.toJson()).toList();
    }
    if (this.chitDetails != null) {
      data['chit_details'] = this.chitDetails!.map((v) => v.toJson()).toList();
    }
    if (this.advanceDetails != null) {
      data['advance_details'] =
          this.advanceDetails!.map((v) => v.toJson()).toList();
    }
    data['total_exchange_amount'] = this.totalExchangeAmount;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['total_chit_amount'] = this.totalChitAmount;
    data['paid_amount'] = this.paidAmount;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    if (this.notissuedItemDetails != null) {
      data['notissued_item_details'] =
          this.notissuedItemDetails!.map((v) => v.toJson()).toList();
    }
    if (this.issuedItemDetails != null) {
      data['issued_item_details'] =
          this.issuedItemDetails!.map((v) => v.toJson()).toList();
    }
    if (this.notReceiveditemDetails != null) {
      data['not_receiveditem_details'] =
          this.notReceiveditemDetails!.map((v) => v.toJson()).toList();
    }
    if (this.receivedItemDetails != null) {
      data['received_item_details'] =
          this.receivedItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExchangeDetails {
  String? oldBillNumber;
  int? oldGoldPieces;
  double? oldGoldWeight;
  double? oldGoldAmount;
  List<ParticularList>? particularList;

  ExchangeDetails(
      {this.oldBillNumber,
      this.oldGoldPieces,
      this.oldGoldWeight,
      this.oldGoldAmount,
      this.particularList});

  ExchangeDetails.fromJson(Map<String, dynamic> json) {
    oldBillNumber = json['old_bill_number'];
    oldGoldPieces = json['old_gold_pieces'];
    oldGoldWeight = json['old_gold_weight'];
    oldGoldAmount = json['old_gold_amount'];
    if (json['particular_list'] != null) {
      particularList = <ParticularList>[];
      json['particular_list'].forEach((v) {
        particularList!.add(new ParticularList.fromJson(v));
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

class ParticularList {
  double? oldGrossWeight;
  double? oldNetWeight;
  double? oldDustWeight;
  String? oldBillNumber;
  String? metalName;
  String? itemName;
  double? oldRate;
  double? totalAmount;

  ParticularList(
      {this.oldGrossWeight,
      this.oldNetWeight,
      this.oldDustWeight,
      this.oldBillNumber,
      this.metalName,
      this.itemName,
      this.oldRate,
      this.totalAmount});

  ParticularList.fromJson(Map<String, dynamic> json) {
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

class ChitDetails {
  int? id;
  double? totalAmount;
  double? benefitAmount;
  double? schemeWeight;
  double? balanceWeight;
  int? paymentDetails;
  List<DenominationDetails>? denominationDetails;

  ChitDetails(
      {this.id,
      this.totalAmount,
      this.benefitAmount,
      this.schemeWeight,
      this.balanceWeight,
      this.paymentDetails,
      this.denominationDetails});

  ChitDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['total_amount'];
    benefitAmount = json['benefit_amount'];
    schemeWeight = json['scheme_weight'];
    balanceWeight = json['balance_weight'];
    paymentDetails = json['payment_details'];
    if (json['denomination_details'] != null) {
      denominationDetails = <DenominationDetails>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new DenominationDetails.fromJson(v));
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
    data['payment_details'] = this.paymentDetails;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DenominationDetails {
  int? id;
  String? schemeAccountNumber;
  double? schemeWeight;
  double? schemeAmount;
  double? bonusAmount;
  int? chitDetails;

  DenominationDetails(
      {this.id,
      this.schemeAccountNumber,
      this.schemeWeight,
      this.schemeAmount,
      this.bonusAmount,
      this.chitDetails});

  DenominationDetails.fromJson(Map<String, dynamic> json) {
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

class AdvanceDetails {
  int? id;
  double? redeemWeight;
  double? redeemMetalRate;
  double? redeemMetalValue;
  double? redeemAmount;
  double? totalAmount;
  int? paymentDetails;
  int? advanceDetails;
  String? advanceId;

  AdvanceDetails(
      {this.id,
      this.redeemWeight,
      this.redeemMetalRate,
      this.redeemMetalValue,
      this.redeemAmount,
      this.totalAmount,
      this.paymentDetails,
      this.advanceDetails,
      this.advanceId});

  AdvanceDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    redeemWeight = json['redeem_weight'];
    redeemMetalRate = json['redeem_metal_rate'];
    redeemMetalValue = json['redeem_metal_value'];
    redeemAmount = json['redeem_amount'];
    totalAmount = json['total_amount'];
    paymentDetails = json['payment_details'];
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
    data['payment_details'] = this.paymentDetails;
    data['advance_details'] = this.advanceDetails;
    data['advance_id'] = this.advanceId;
    return data;
  }
}

class ItemDetails {
  int? id;
  double? grossWeight;
  double? netWeight;
  int? pieces;
  double? wastagePercent;
  double? makingCharge;
  double? designCharges;
  double? huidAmount;
  double? totalAmount;
  double? gstAmount;
  double? payableAmount;
  double? metalRate;
  String? gender;
  String? measurementType;
  String? priority;
  String? measurementValue;
  String? issuedDate;
  String? receivedDate;
  String? dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  int? totalStonePieces;
  int? totalDiamondPieces;
  double? totalStoneAmount;
  double? totalDiamondAmount;
  List<int>? orderImages;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? orderDetails;
  int? itemDetails;
  int? subItemDetails;
  int? vendorDetails;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? purityName;
  String? metalName;
  int? purity;
  int? metal;
  String? orderId;
  bool? isDb;
  List<ImagePath>? imagePath;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;
  int? sNo;

  ItemDetails(
      {this.id,
      this.grossWeight,
      this.netWeight,
      this.pieces,
      this.wastagePercent,
      this.makingCharge,
      this.designCharges,
      this.huidAmount,
      this.totalAmount,
      this.gstAmount,
      this.payableAmount,
      this.metalRate,
      this.gender,
      this.measurementType,
      this.priority,
      this.measurementValue,
      this.issuedDate,
      this.receivedDate,
      this.dueDate,
      this.isIssued,
      this.isReceived,
      this.remarks,
      this.totalStonePieces,
      this.totalDiamondPieces,
      this.totalStoneAmount,
      this.totalDiamondAmount,
      this.orderImages,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.orderDetails,
      this.itemDetails,
      this.subItemDetails,
      this.vendorDetails,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.purityName,
      this.metalName,
      this.purity,
      this.metal,
      this.orderId,
      this.isDb,
      this.imagePath,
      this.stoneDetails,
      this.diamondDetails,
      this.sNo});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossWeight = json['gross_weight'];
    netWeight = json['net_weight'];
    pieces = json['pieces'];
    wastagePercent = json['wastage_percent'];
    makingCharge = json['making_charge'];
    designCharges = json['design_charges'];
    huidAmount = json['huid_amount'];
    totalAmount = json['total_amount'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    metalRate = json['metal_rate'];
    gender = json['gender'];
    measurementType = json['measurement_type'];
    priority = json['priority'];
    measurementValue = json['measurement_value'];
    issuedDate = json['issued_date'];
    receivedDate = json['received_date'];
    dueDate = json['due_date'];
    isIssued = json['is_issued'];
    isReceived = json['is_received'];
    remarks = json['remarks'];
    totalStonePieces = json['total_stone_pieces'];
    totalDiamondPieces = json['total_diamond_pieces'];
    totalStoneAmount = json['total_stone_amount'];
    totalDiamondAmount = json['total_diamond_amount'];
    orderImages = json['order_images'].cast<int>();
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    orderDetails = json['order_details'];
    itemDetails = json['item_details'];
    subItemDetails = json['sub_item_details'];
    vendorDetails = json['vendor_details'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    purityName = json['purity_name'];
    metalName = json['metal_name'];
    purity = json['purity'];
    metal = json['metal'];
    orderId = json['order_id'];
    isDb = json['is_db'];
    if (json['image_path'] != null) {
      imagePath = <ImagePath>[];
      json['image_path'].forEach((v) {
        imagePath!.add(new ImagePath.fromJson(v));
      });
    }
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
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['pieces'] = this.pieces;
    data['wastage_percent'] = this.wastagePercent;
    data['making_charge'] = this.makingCharge;
    data['design_charges'] = this.designCharges;
    data['huid_amount'] = this.huidAmount;
    data['total_amount'] = this.totalAmount;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['metal_rate'] = this.metalRate;
    data['gender'] = this.gender;
    data['measurement_type'] = this.measurementType;
    data['priority'] = this.priority;
    data['measurement_value'] = this.measurementValue;
    data['issued_date'] = this.issuedDate;
    data['received_date'] = this.receivedDate;
    data['due_date'] = this.dueDate;
    data['is_issued'] = this.isIssued;
    data['is_received'] = this.isReceived;
    data['remarks'] = this.remarks;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    data['total_stone_amount'] = this.totalStoneAmount;
    data['total_diamond_amount'] = this.totalDiamondAmount;
    data['order_images'] = this.orderImages;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['order_details'] = this.orderDetails;
    data['item_details'] = this.itemDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['vendor_details'] = this.vendorDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['purity_name'] = this.purityName;
    data['metal_name'] = this.metalName;
    data['purity'] = this.purity;
    data['metal'] = this.metal;
    data['order_id'] = this.orderId;
    data['is_db'] = this.isDb;
    if (this.imagePath != null) {
      data['image_path'] = this.imagePath!.map((v) => v.toJson()).toList();
    }
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

class ImagePath {
  String? imagePath;

  ImagePath({this.imagePath});

  ImagePath.fromJson(Map<String, dynamic> json) {
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_path'] = this.imagePath;
    return data;
  }
}

class StoneDetails {
  int? id;
  bool? reduceWeight;
  int? stonePieces;
  double? stoneWeight;
  double? stoneAmount;
  int? orderItemDetails;
  int? stone;
  String? stoneName;
  bool? isDb;

  StoneDetails(
      {this.id,
      this.reduceWeight,
      this.stonePieces,
      this.stoneWeight,
      this.stoneAmount,
      this.orderItemDetails,
      this.stone,
      this.stoneName,
      this.isDb});

  StoneDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reduceWeight = json['reduce_weight'];
    stonePieces = json['stone_pieces'];
    stoneWeight = json['stone_weight'];
    stoneAmount = json['stone_amount'];
    orderItemDetails = json['order_item_details'];
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
    data['order_item_details'] = this.orderItemDetails;
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
  int? orderItemDetails;
  int? diamond;
  String? diamondName;
  bool? isDb;

  DiamondDetails(
      {this.id,
      this.reduceWeight,
      this.diamondPieces,
      this.diamondWeight,
      this.diamondAmount,
      this.orderItemDetails,
      this.diamond,
      this.diamondName,
      this.isDb});

  DiamondDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reduceWeight = json['reduce_weight'];
    diamondPieces = json['diamond_pieces'];
    diamondWeight = json['diamond_weight'];
    diamondAmount = json['diamond_amount'];
    orderItemDetails = json['order_item_details'];
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
    data['order_item_details'] = this.orderItemDetails;
    data['diamond'] = this.diamond;
    data['diamond_name'] = this.diamondName;
    data['is_db'] = this.isDb;
    return data;
  }
}

class NotissuedItemDetails {
  int? id;
  double? grossWeight;
  double? netWeight;
  int? pieces;
  double? wastagePercent;
  double? makingCharge;
  double? designCharges;
  double? huidAmount;
  double? totalAmount;
  double? gstAmount;
  double? payableAmount;
  double? metalRate;
  String? gender;
  String? measurementType;
  String? priority;
  String? measurementValue;
  String? issuedDate;
  String? receivedDate;
  String? dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  int? totalStonePieces;
  int? totalDiamondPieces;
  double? totalStoneAmount;
  double? totalDiamondAmount;
  List<int>? orderImages;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? orderDetails;
  int? itemDetails;
  int? subItemDetails;
  String? vendorDetails;
  String? vendorName;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? purityName;
  String? metalName;
  int? purity;
  int? metal;
  String? orderId;
  bool? isDb;
  List<ImagePath>? imagePath;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;
  int? sNo;
  bool? isCheck;

  NotissuedItemDetails(
      {this.id,
      this.grossWeight,
      this.netWeight,
      this.pieces,
      this.wastagePercent,
      this.makingCharge,
      this.designCharges,
      this.huidAmount,
      this.totalAmount,
      this.gstAmount,
      this.payableAmount,
      this.metalRate,
      this.gender,
      this.measurementType,
      this.priority,
      this.measurementValue,
      this.issuedDate,
      this.receivedDate,
      this.dueDate,
      this.isIssued,
      this.isReceived,
      this.remarks,
      this.totalStonePieces,
      this.totalDiamondPieces,
      this.totalStoneAmount,
      this.totalDiamondAmount,
      this.orderImages,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.orderDetails,
      this.itemDetails,
      this.subItemDetails,
      this.vendorDetails,
      this.vendorName,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.purityName,
      this.metalName,
      this.purity,
      this.metal,
      this.orderId,
      this.isDb,
      this.imagePath,
      this.stoneDetails,
      this.diamondDetails,
      this.sNo,
      this.isCheck = false});

  NotissuedItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossWeight = json['gross_weight'];
    netWeight = json['net_weight'];
    pieces = json['pieces'];
    wastagePercent = json['wastage_percent'];
    makingCharge = json['making_charge'];
    designCharges = json['design_charges'];
    huidAmount = json['huid_amount'];
    totalAmount = json['total_amount'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    metalRate = json['metal_rate'];
    gender = json['gender'];
    measurementType = json['measurement_type'];
    priority = json['priority'];
    measurementValue = json['measurement_value'];
    issuedDate = json['issued_date'];
    receivedDate = json['received_date'];
    dueDate = json['due_date'];
    isIssued = json['is_issued'];
    isReceived = json['is_received'];
    remarks = json['remarks'];
    totalStonePieces = json['total_stone_pieces'];
    totalDiamondPieces = json['total_diamond_pieces'];
    totalStoneAmount = json['total_stone_amount'];
    totalDiamondAmount = json['total_diamond_amount'];
    orderImages = json['order_images'].cast<int>();
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    orderDetails = json['order_details'];
    itemDetails = json['item_details'];
    subItemDetails = json['sub_item_details'];
    vendorDetails = json['vendor_details'];
    vendorName = json['vendor_name'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    purityName = json['purity_name'];
    metalName = json['metal_name'];
    purity = json['purity'];
    metal = json['metal'];
    orderId = json['order_id'];
    isDb = json['is_db'];
    if (json['image_path'] != null) {
      imagePath = <ImagePath>[];
      json['image_path'].forEach((v) {
        imagePath!.add(new ImagePath.fromJson(v));
      });
    }
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
    sNo = json['s_no'];
    isCheck = json['is_check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['pieces'] = this.pieces;
    data['wastage_percent'] = this.wastagePercent;
    data['making_charge'] = this.makingCharge;
    data['design_charges'] = this.designCharges;
    data['huid_amount'] = this.huidAmount;
    data['total_amount'] = this.totalAmount;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['metal_rate'] = this.metalRate;
    data['gender'] = this.gender;
    data['measurement_type'] = this.measurementType;
    data['priority'] = this.priority;
    data['measurement_value'] = this.measurementValue;
    data['issued_date'] = this.issuedDate;
    data['received_date'] = this.receivedDate;
    data['due_date'] = this.dueDate;
    data['is_issued'] = this.isIssued;
    data['is_received'] = this.isReceived;
    data['remarks'] = this.remarks;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    data['total_stone_amount'] = this.totalStoneAmount;
    data['total_diamond_amount'] = this.totalDiamondAmount;
    data['order_images'] = this.orderImages;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['order_details'] = this.orderDetails;
    data['item_details'] = this.itemDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['vendor_details'] = this.vendorDetails;
    data['vendor_name'] = this.vendorName;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['purity_name'] = this.purityName;
    data['metal_name'] = this.metalName;
    data['purity'] = this.purity;
    data['metal'] = this.metal;
    data['order_id'] = this.orderId;
    data['is_db'] = this.isDb;
    if (this.imagePath != null) {
      data['image_path'] = this.imagePath!.map((v) => v.toJson()).toList();
    }
    if (this.stoneDetails != null) {
      data['stone_details'] =
          this.stoneDetails!.map((v) => v.toJson()).toList();
    }
    if (this.diamondDetails != null) {
      data['diamond_details'] =
          this.diamondDetails!.map((v) => v.toJson()).toList();
    }
    data['s_no'] = this.sNo;
    data['is_check'] = this.isCheck;
    return data;
  }
}

class IssuedItemDetails {
  int? id;
  double? grossWeight;
  double? netWeight;
  int? pieces;
  double? wastagePercent;
  double? makingCharge;
  double? designCharges;
  double? huidAmount;
  double? totalAmount;
  double? gstAmount;
  double? payableAmount;
  double? metalRate;
  String? gender;
  String? measurementType;
  String? priority;
  String? measurementValue;
  String? issuedDate;
  String? receivedDate;
  String? dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  int? totalStonePieces;
  int? totalDiamondPieces;
  double? totalStoneAmount;
  double? totalDiamondAmount;
  List<int>? orderImages;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? orderDetails;
  int? itemDetails;
  int? subItemDetails;
  int? vendorDetails;
  String? vendorName;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? purityName;
  String? metalName;
  int? purity;
  int? metal;
  String? orderId;
  bool? isDb;
  List<ImagePath>? imagePath;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;
  int? sNo;
  bool? isCheck;

  IssuedItemDetails(
      {this.id,
      this.grossWeight,
      this.netWeight,
      this.pieces,
      this.wastagePercent,
      this.makingCharge,
      this.designCharges,
      this.huidAmount,
      this.totalAmount,
      this.gstAmount,
      this.payableAmount,
      this.metalRate,
      this.gender,
      this.measurementType,
      this.priority,
      this.measurementValue,
      this.issuedDate,
      this.receivedDate,
      this.dueDate,
      this.isIssued,
      this.isReceived,
      this.remarks,
      this.totalStonePieces,
      this.totalDiamondPieces,
      this.totalStoneAmount,
      this.totalDiamondAmount,
      this.orderImages,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.orderDetails,
      this.itemDetails,
      this.subItemDetails,
      this.vendorDetails,
      this.vendorName,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.purityName,
      this.metalName,
      this.purity,
      this.metal,
      this.orderId,
      this.isDb,
      this.imagePath,
      this.stoneDetails,
      this.diamondDetails,
      this.sNo,
      this.isCheck = false});

  IssuedItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossWeight = json['gross_weight'];
    netWeight = json['net_weight'];
    pieces = json['pieces'];
    wastagePercent = json['wastage_percent'];
    makingCharge = json['making_charge'];
    designCharges = json['design_charges'];
    huidAmount = json['huid_amount'];
    totalAmount = json['total_amount'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    metalRate = json['metal_rate'];
    gender = json['gender'];
    measurementType = json['measurement_type'];
    priority = json['priority'];
    measurementValue = json['measurement_value'];
    issuedDate = json['issued_date'];
    receivedDate = json['received_date'];
    dueDate = json['due_date'];
    isIssued = json['is_issued'];
    isReceived = json['is_received'];
    remarks = json['remarks'];
    totalStonePieces = json['total_stone_pieces'];
    totalDiamondPieces = json['total_diamond_pieces'];
    totalStoneAmount = json['total_stone_amount'];
    totalDiamondAmount = json['total_diamond_amount'];
    orderImages = json['order_images'].cast<int>();
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    orderDetails = json['order_details'];
    itemDetails = json['item_details'];
    subItemDetails = json['sub_item_details'];
    vendorDetails = json['vendor_details'];
    vendorName = json['vendor_name'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    purityName = json['purity_name'];
    metalName = json['metal_name'];
    purity = json['purity'];
    metal = json['metal'];
    orderId = json['order_id'];
    isDb = json['is_db'];
    if (json['image_path'] != null) {
      imagePath = <ImagePath>[];
      json['image_path'].forEach((v) {
        imagePath!.add(new ImagePath.fromJson(v));
      });
    }
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
    sNo = json['s_no'];
    isCheck = json['is_check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['pieces'] = this.pieces;
    data['wastage_percent'] = this.wastagePercent;
    data['making_charge'] = this.makingCharge;
    data['design_charges'] = this.designCharges;
    data['huid_amount'] = this.huidAmount;
    data['total_amount'] = this.totalAmount;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['metal_rate'] = this.metalRate;
    data['gender'] = this.gender;
    data['measurement_type'] = this.measurementType;
    data['priority'] = this.priority;
    data['measurement_value'] = this.measurementValue;
    data['issued_date'] = this.issuedDate;
    data['received_date'] = this.receivedDate;
    data['due_date'] = this.dueDate;
    data['is_issued'] = this.isIssued;
    data['is_received'] = this.isReceived;
    data['remarks'] = this.remarks;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    data['total_stone_amount'] = this.totalStoneAmount;
    data['total_diamond_amount'] = this.totalDiamondAmount;
    data['order_images'] = this.orderImages;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['order_details'] = this.orderDetails;
    data['item_details'] = this.itemDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['vendor_details'] = this.vendorDetails;
    data['vendor_name'] = this.vendorName;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['purity_name'] = this.purityName;
    data['metal_name'] = this.metalName;
    data['purity'] = this.purity;
    data['metal'] = this.metal;
    data['order_id'] = this.orderId;
    data['is_db'] = this.isDb;
    if (this.imagePath != null) {
      data['image_path'] = this.imagePath!.map((v) => v.toJson()).toList();
    }
    if (this.stoneDetails != null) {
      data['stone_details'] =
          this.stoneDetails!.map((v) => v.toJson()).toList();
    }
    if (this.diamondDetails != null) {
      data['diamond_details'] =
          this.diamondDetails!.map((v) => v.toJson()).toList();
    }
    data['s_no'] = this.sNo;
    data['is_check'] = this.isCheck;
    return data;
  }
}

class NotReceiveditemDetails {
  int? id;
  double? grossWeight;
  double? netWeight;
  int? pieces;
  double? wastagePercent;
  double? makingCharge;
  double? designCharges;
  double? huidAmount;
  double? totalAmount;
  double? gstAmount;
  double? payableAmount;
  double? metalRate;
  String? gender;
  String? measurementType;
  String? priority;
  String? measurementValue;
  String? issuedDate;
  String? receivedDate;
  String? dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  int? totalStonePieces;
  int? totalDiamondPieces;
  double? totalStoneAmount;
  double? totalDiamondAmount;
  List<int>? orderImages;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? orderDetails;
  int? itemDetails;
  int? subItemDetails;
  int? vendorDetails;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? purityName;
  String? metalName;
  int? purity;
  int? metal;
  String? orderId;
  bool? isDb;
  List<ImagePath>? imagePath;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;
  int? sNo;

  NotReceiveditemDetails(
      {this.id,
      this.grossWeight,
      this.netWeight,
      this.pieces,
      this.wastagePercent,
      this.makingCharge,
      this.designCharges,
      this.huidAmount,
      this.totalAmount,
      this.gstAmount,
      this.payableAmount,
      this.metalRate,
      this.gender,
      this.measurementType,
      this.priority,
      this.measurementValue,
      this.issuedDate,
      this.receivedDate,
      this.dueDate,
      this.isIssued,
      this.isReceived,
      this.remarks,
      this.totalStonePieces,
      this.totalDiamondPieces,
      this.totalStoneAmount,
      this.totalDiamondAmount,
      this.orderImages,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.orderDetails,
      this.itemDetails,
      this.subItemDetails,
      this.vendorDetails,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.purityName,
      this.metalName,
      this.purity,
      this.metal,
      this.orderId,
      this.isDb,
      this.imagePath,
      this.stoneDetails,
      this.diamondDetails,
      this.sNo});

  NotReceiveditemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossWeight = json['gross_weight'];
    netWeight = json['net_weight'];
    pieces = json['pieces'];
    wastagePercent = json['wastage_percent'];
    makingCharge = json['making_charge'];
    designCharges = json['design_charges'];
    huidAmount = json['huid_amount'];
    totalAmount = json['total_amount'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    metalRate = json['metal_rate'];
    gender = json['gender'];
    measurementType = json['measurement_type'];
    priority = json['priority'];
    measurementValue = json['measurement_value'];
    issuedDate = json['issued_date'];
    receivedDate = json['received_date'];
    dueDate = json['due_date'];
    isIssued = json['is_issued'];
    isReceived = json['is_received'];
    remarks = json['remarks'];
    totalStonePieces = json['total_stone_pieces'];
    totalDiamondPieces = json['total_diamond_pieces'];
    totalStoneAmount = json['total_stone_amount'];
    totalDiamondAmount = json['total_diamond_amount'];
    orderImages = json['order_images'].cast<int>();
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    orderDetails = json['order_details'];
    itemDetails = json['item_details'];
    subItemDetails = json['sub_item_details'];
    vendorDetails = json['vendor_details'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    purityName = json['purity_name'];
    metalName = json['metal_name'];
    purity = json['purity'];
    metal = json['metal'];
    orderId = json['order_id'];
    isDb = json['is_db'];
    if (json['image_path'] != null) {
      imagePath = <ImagePath>[];
      json['image_path'].forEach((v) {
        imagePath!.add(new ImagePath.fromJson(v));
      });
    }
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
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['pieces'] = this.pieces;
    data['wastage_percent'] = this.wastagePercent;
    data['making_charge'] = this.makingCharge;
    data['design_charges'] = this.designCharges;
    data['huid_amount'] = this.huidAmount;
    data['total_amount'] = this.totalAmount;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['metal_rate'] = this.metalRate;
    data['gender'] = this.gender;
    data['measurement_type'] = this.measurementType;
    data['priority'] = this.priority;
    data['measurement_value'] = this.measurementValue;
    data['issued_date'] = this.issuedDate;
    data['received_date'] = this.receivedDate;
    data['due_date'] = this.dueDate;
    data['is_issued'] = this.isIssued;
    data['is_received'] = this.isReceived;
    data['remarks'] = this.remarks;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    data['total_stone_amount'] = this.totalStoneAmount;
    data['total_diamond_amount'] = this.totalDiamondAmount;
    data['order_images'] = this.orderImages;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['order_details'] = this.orderDetails;
    data['item_details'] = this.itemDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['vendor_details'] = this.vendorDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['purity_name'] = this.purityName;
    data['metal_name'] = this.metalName;
    data['purity'] = this.purity;
    data['metal'] = this.metal;
    data['order_id'] = this.orderId;
    data['is_db'] = this.isDb;
    if (this.imagePath != null) {
      data['image_path'] = this.imagePath!.map((v) => v.toJson()).toList();
    }
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

class ReceivedItemDetails {
  int? id;
  double? grossWeight;
  double? netWeight;
  int? pieces;
  double? wastagePercent;
  double? makingCharge;
  double? designCharges;
  double? huidAmount;
  double? totalAmount;
  double? gstAmount;
  double? payableAmount;
  double? metalRate;
  String? gender;
  String? measurementType;
  String? priority;
  String? measurementValue;
  String? issuedDate;
  String? receivedDate;
  String? dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  int? totalStonePieces;
  int? totalDiamondPieces;
  double? totalStoneAmount;
  double? totalDiamondAmount;
  List<int>? orderImages;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? orderDetails;
  int? itemDetails;
  int? subItemDetails;
  int? vendorDetails;
  String? vendorName;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? purityName;
  String? metalName;
  int? purity;
  int? metal;
  String? orderId;
  bool? isDb;
  List<ImagePath>? imagePath;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;
  int? sNo;

  ReceivedItemDetails(
      {this.id,
      this.grossWeight,
      this.netWeight,
      this.pieces,
      this.wastagePercent,
      this.makingCharge,
      this.designCharges,
      this.huidAmount,
      this.totalAmount,
      this.gstAmount,
      this.payableAmount,
      this.metalRate,
      this.gender,
      this.measurementType,
      this.priority,
      this.measurementValue,
      this.issuedDate,
      this.receivedDate,
      this.dueDate,
      this.isIssued,
      this.isReceived,
      this.remarks,
      this.totalStonePieces,
      this.totalDiamondPieces,
      this.totalStoneAmount,
      this.totalDiamondAmount,
      this.orderImages,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.orderDetails,
      this.itemDetails,
      this.subItemDetails,
      this.vendorDetails,
      this.vendorName,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.purityName,
      this.metalName,
      this.purity,
      this.metal,
      this.orderId,
      this.isDb,
      this.imagePath,
      this.stoneDetails,
      this.diamondDetails,
      this.sNo});

  ReceivedItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossWeight = json['gross_weight'];
    netWeight = json['net_weight'];
    pieces = json['pieces'];
    wastagePercent = json['wastage_percent'];
    makingCharge = json['making_charge'];
    designCharges = json['design_charges'];
    huidAmount = json['huid_amount'];
    totalAmount = json['total_amount'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    metalRate = json['metal_rate'];
    gender = json['gender'];
    measurementType = json['measurement_type'];
    priority = json['priority'];
    measurementValue = json['measurement_value'];
    issuedDate = json['issued_date'];
    receivedDate = json['received_date'];
    dueDate = json['due_date'];
    isIssued = json['is_issued'];
    isReceived = json['is_received'];
    remarks = json['remarks'];
    totalStonePieces = json['total_stone_pieces'];
    totalDiamondPieces = json['total_diamond_pieces'];
    totalStoneAmount = json['total_stone_amount'];
    totalDiamondAmount = json['total_diamond_amount'];
    orderImages = json['order_images'].cast<int>();
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    orderDetails = json['order_details'];
    itemDetails = json['item_details'];
    subItemDetails = json['sub_item_details'];
    vendorDetails = json['vendor_details'];
    vendorName = json['vendor_name'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    purityName = json['purity_name'];
    metalName = json['metal_name'];
    purity = json['purity'];
    metal = json['metal'];
    orderId = json['order_id'];
    isDb = json['is_db'];
    if (json['image_path'] != null) {
      imagePath = <ImagePath>[];
      json['image_path'].forEach((v) {
        imagePath!.add(new ImagePath.fromJson(v));
      });
    }
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
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['pieces'] = this.pieces;
    data['wastage_percent'] = this.wastagePercent;
    data['making_charge'] = this.makingCharge;
    data['design_charges'] = this.designCharges;
    data['huid_amount'] = this.huidAmount;
    data['total_amount'] = this.totalAmount;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['metal_rate'] = this.metalRate;
    data['gender'] = this.gender;
    data['measurement_type'] = this.measurementType;
    data['priority'] = this.priority;
    data['measurement_value'] = this.measurementValue;
    data['issued_date'] = this.issuedDate;
    data['received_date'] = this.receivedDate;
    data['due_date'] = this.dueDate;
    data['is_issued'] = this.isIssued;
    data['is_received'] = this.isReceived;
    data['remarks'] = this.remarks;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    data['total_stone_amount'] = this.totalStoneAmount;
    data['total_diamond_amount'] = this.totalDiamondAmount;
    data['order_images'] = this.orderImages;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['order_details'] = this.orderDetails;
    data['item_details'] = this.itemDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['vendor_details'] = this.vendorDetails;
    data['vendor_name'] = this.vendorName;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['purity_name'] = this.purityName;
    data['metal_name'] = this.metalName;
    data['purity'] = this.purity;
    data['metal'] = this.metal;
    data['order_id'] = this.orderId;
    data['is_db'] = this.isDb;
    if (this.imagePath != null) {
      data['image_path'] = this.imagePath!.map((v) => v.toJson()).toList();
    }
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

class AssignOrderItems {
  int? menuId;
  List<OrderItemDetails>? orderItemDetails;

  AssignOrderItems({this.menuId, this.orderItemDetails});

  AssignOrderItems.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    if (json['order_item_details'] != null) {
      orderItemDetails = <OrderItemDetails>[];
      json['order_item_details'].forEach((v) {
        orderItemDetails!.add(new OrderItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    if (this.orderItemDetails != null) {
      data['order_item_details'] =
          this.orderItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItemDetails {
  int? id;
  String? vendorDetails;
  String? dueDate;

  OrderItemDetails({this.id, this.vendorDetails, this.dueDate});

  OrderItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorDetails = json['vendor_details'];
    dueDate = json['due_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_details'] = this.vendorDetails;
    data['due_date'] = this.dueDate;
    return data;
  }
}


class RecieveOrderItems {
  int? menuId;
  List<RecieveOrderItemDetails>? orderItemDetails;

  RecieveOrderItems({this.menuId, this.orderItemDetails});

  RecieveOrderItems.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    if (json['order_item_details'] != null) {
      orderItemDetails = <RecieveOrderItemDetails>[];
      json['order_item_details'].forEach((v) {
        orderItemDetails!.add(new RecieveOrderItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    if (this.orderItemDetails != null) {
      data['order_item_details'] =
          this.orderItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecieveOrderItemDetails {
  int? id;

  RecieveOrderItemDetails({this.id});

  RecieveOrderItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
