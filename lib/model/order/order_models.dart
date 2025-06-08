import 'dart:ffi';

class FetchOrderListPayload {
  String? customer;
  String? search;
  int? menuId;

  FetchOrderListPayload({this.customer, this.search, this.menuId});

  FetchOrderListPayload.fromJson(Map<String, dynamic> json) {
    customer = json['customer'];
    search = json['search'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer'] = this.customer;
    data['search'] = this.search;
    data['menu_id'] = this.menuId;
    return data;
  }
}

class OrderListData {
  int? id;
  String? orderId;
  String? orderStatus;
  String? dueDate;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? customerDetails;
  int? branch;
  String? customerName;
  int? sNo;

  OrderListData(
      {this.id,
      this.orderId,
      this.orderStatus,
      this.dueDate,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.customerDetails,
      this.branch,
      this.customerName,
      this.sNo});

  OrderListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    isCanceled = json['is_canceled'];
    orderStatus = json['order_status'];
    dueDate = json['due_date'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    customerName = json['customer_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['order_status'] = this.orderStatus;
    data['due_date'] = this.dueDate;
    data['is_canceled'] = this.isCanceled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    data['customer_name'] = this.customerName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class CreateOrderPayload {
  String? customerDetails;
  int? menuId;
  String? branch;
  String? metal;
  String? gstType;
  double? gstAmount;
  double? payableAmount;
  double? totalAmount;
  String? dueDate;
  bool? isFixed;
  double? balanceAmount;
  bool? isPayment;
  List<OrderItemDetails>? orderItemDetails;
  List<int>? exchangeDetails;
  List<AdvanceDetails>? advanceDetails;
  List<ChitDetails>? chitDetails;

  CreateOrderPayload(
      {this.customerDetails,
      this.menuId,
      this.branch,
      this.metal,
      this.gstType,
      this.gstAmount,
      this.payableAmount,
      this.totalAmount,
      this.isPayment,
      this.orderItemDetails,
      this.exchangeDetails,
      this.advanceDetails,
      this.dueDate, 
      this.isFixed, 
      this.balanceAmount,
      this.chitDetails});

  CreateOrderPayload.fromJson(Map<String, dynamic> json) {
    customerDetails = json['customer_details'];
    menuId = json['menu_id'];
    branch = json['branch'];
    metal = json['metal'];
    gstType = json['gst_type'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    totalAmount = json['total_amount'];
    isPayment = json['is_payment'];
    dueDate = json['due_date'];
    isFixed = json['is_fixed'];
    balanceAmount = json['balance_amount'];
    if (json['order_item_details'] != null) {
      orderItemDetails = <OrderItemDetails>[];
      json['order_item_details'].forEach((v) {
        orderItemDetails!.add(new OrderItemDetails.fromJson(v));
      });
    }
    exchangeDetails = json['exchange_details'].cast<int>();
    if (json['advance_details'] != null) {
      advanceDetails = <AdvanceDetails>[];
      json['advance_details'].forEach((v) {
        advanceDetails!.add(new AdvanceDetails.fromJson(v));
      });
    }
    if (json['chit_details'] != null) {
      chitDetails = <ChitDetails>[];
      json['chit_details'].forEach((v) {
        chitDetails!.add(new ChitDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_details'] = this.customerDetails;
    data['menu_id'] = this.menuId;
    data['metal'] = this.metal;
    data['branch'] = this.branch;
    data['gst_type'] = this.gstType;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['total_amount'] = this.totalAmount;
    data['is_payment'] = this.isPayment;
    data['due_date'] = this.dueDate;
    data['is_fixed'] = this.isFixed;
    data['balance_amount'] = this.balanceAmount;
    if (this.orderItemDetails != null) {
      data['order_item_details'] =
          this.orderItemDetails!.map((v) => v.toJson()).toList();
    }
    data['exchange_details'] = this.exchangeDetails;
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

class OrderItemDetails {
  String? sNo;
  String? purityDetails;
  String? putrityDetailsName;
  String? itemDetails;
  String? itemDetailsName;
  String? subItemDetails;
  String? subItemDetailsName;
  String? grossWeight;
  String? netWeight;
  String? wastagePercent;
  double? wastageWeightReduced;
  String? makingCharge;
  String? flatWastage;
  String? flatMakingCharge;
  double? huidAmount;
  int? pieces;
  String? priority;
  String? priorityName;
  String? gender;
  String? genderName;
  String? measurementType;
  String? measurementTypeName;
  String? measurementValue;
  String? remarks;
  String? totalDiamondPieces;
  String? totalStonePieces;
  double? totalDiamondAmount;
  double? totalStoneAmount;
  double? metalRate;
  double? totalAmount;
  double? gstAmount;
  double? designCharges;
  double? payableAmount;
  List<OrderEdiImageUpload>? orderUploadImages;
  List<int>? orderImages;
  List<StoneDetails>? stoneDetails;
  List<DiamondDetails>? diamondDetails;

  OrderItemDetails(
      {this.sNo,
      this.purityDetails,
      this.putrityDetailsName,
      this.itemDetails,
      this.itemDetailsName,
      this.subItemDetails,
      this.subItemDetailsName,
      this.grossWeight,
      this.designCharges,
      this.netWeight,
      this.wastagePercent,
      this.wastageWeightReduced,
      this.makingCharge,
      this.flatWastage,
      this.flatMakingCharge,
      this.huidAmount,
      this.pieces,
      this.priority,
      this.priorityName,
      this.gender,
      this.genderName,
      this.measurementType,
      this.measurementTypeName,
      this.measurementValue,
      this.remarks,
      this.totalDiamondPieces,
      this.totalStonePieces,
      this.totalDiamondAmount,
      this.totalStoneAmount,
      this.metalRate,
      this.totalAmount,
      this.gstAmount,
      this.payableAmount,
      this.orderUploadImages,
      this.orderImages,
      this.stoneDetails,
      this.diamondDetails});

  OrderItemDetails.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    purityDetails = json['purity_details'];
    putrityDetailsName = json['putrity_details_name'];
    itemDetails = json['item_details'];
    itemDetailsName = json['item_details_name'];
    subItemDetails = json['sub_item_details'];
    subItemDetailsName = json['sub_item_details_name'];
    grossWeight = json['gross_weight'];
    designCharges = json['design_charges'];
    netWeight = json['net_weight'];
    wastagePercent = json['wastage_percent'];
    wastageWeightReduced = json['wastage_weight_reduced'];
    makingCharge = json['making_charge'];
    flatWastage = json['flat_wastage'];
    flatMakingCharge = json['flat_making_charge'];
    huidAmount = json['huid_amount'];
    pieces = json['pieces'];
    priority = json['priority'];
    priorityName = json['priority_name'];
    gender = json['gender'];
    genderName = json['gender_name'];
    measurementType = json['measurement_type'];
    measurementTypeName = json['measurement_type_name'];
    measurementValue = json['measurement_value'].toString();
    remarks = json['remarks'];
    totalDiamondPieces = json['total_diamond_pieces'];
    totalStonePieces = json['total_stone_pieces'];
    totalDiamondAmount = json['total_diamond_amount'];
    totalStoneAmount = json['total_stone_amount'];
    metalRate = json['metal_rate'];
    totalAmount = json['total_amount'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    orderImages = json['order_images'].cast<int>();
    if (json['order_images_upload'] != null) {
      orderUploadImages = <OrderEdiImageUpload>[];
      json['order_images_upload'].forEach((v) {
        orderUploadImages!.add(new OrderEdiImageUpload.fromJson(v));
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['purity_details'] = this.purityDetails;
    data['putrity_details_name'] = this.putrityDetailsName;
    data['item_details'] = this.itemDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details'] = this.subItemDetails;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['wastage_percent'] = this.wastagePercent;
    data['wastage_weight_reduced'] = this.wastageWeightReduced;
    data['making_charge'] = this.makingCharge;
    data['flat_wastage'] = this.flatWastage;
    data['flat_making_charge'] = this.flatMakingCharge;
    data['huid_amount'] = this.huidAmount;
    data['pieces'] = this.pieces;
    data['priority'] = this.priority;
    data['priority_name'] = this.priorityName;
    data['design_charges'] = this.designCharges;
    data['gender'] = this.gender;
    data['gender_name'] = this.genderName;
    data['measurement_type'] = this.measurementType;
    data['measurement_type_name'] = this.measurementTypeName;
    data['measurement_value'] = this.measurementValue;
    data['remarks'] = this.remarks;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_diamond_amount'] = this.totalDiamondAmount;
    data['total_stone_amount'] = this.totalStoneAmount;
    data['order_images'] = this.orderImages;
    data['metal_rate'] = this.metalRate;
    data['total_amount'] = this.totalAmount;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    if (this.orderUploadImages != null) {
      data['order_images_upload'] =
          this.orderUploadImages!.map((v) => v.toJson()).toList();
    }
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
  String? sNo;
  int? stone;
  String? stoneName;
  double? rate;
  double? certificateAmount;
  int? stonePieces;
  bool? reduceWeight;
  double? stoneAmount;
  double? stoneWeight;
 
  StoneDetails(
      {this.sNo,
      this.stone,
      this.stoneName,
      this.rate,
      this.certificateAmount,
      this.stonePieces,
      this.reduceWeight,
      this.stoneAmount,
      this.stoneWeight});
 
  StoneDetails.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    stone = json['stone'];
    stoneName = json['stone_name'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
    stonePieces = json['stone_pieces'];
    reduceWeight = json['reduce_weight'];
    stoneAmount = json['stone_amount'];
    stoneWeight = json['stone_weight'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['stone'] = this.stone;
    data['stone_name'] = this.stoneName;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['stone_pieces'] = this.stonePieces;
    data['reduce_weight'] = this.reduceWeight;
    data['stone_amount'] = this.stoneAmount;
    data['stone_weight'] = this.stoneWeight;
    return data;
  }
}
 
class DiamondDetails {
  String? sNo;
  int? diamond;
  String? diamondName;
  double? rate;
  double? certificateAmount;
  int? diamondPieces;
  bool? reduceWeight;
  double? diamondWeight;
  double? diamondAmount;
 
  DiamondDetails(
      {this.sNo,
      this.diamond,
      this.diamondName,
      this.rate,
      this.certificateAmount,
      this.diamondPieces,
      this.reduceWeight,
      this.diamondWeight,
      this.diamondAmount});
 
  DiamondDetails.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    diamond = json['diamond'];
    diamondName = json['diamond_name'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
    diamondPieces = json['diamond_pieces'];
    reduceWeight = json['reduce_weight'];
    diamondWeight = json['diamond_weight'];
    diamondAmount = json['diamond_amount'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['diamond'] = this.diamond;
    data['diamond_name'] = this.diamondName;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['diamond_pieces'] = this.diamondPieces;
    data['reduce_weight'] = this.reduceWeight;
    data['diamond_weight'] = this.diamondWeight;
    data['diamond_amount'] = this.diamondAmount;
    return data;
  }
}

class AdvanceDetails {
  int? advanceDetails;
  String? advanceDetailsNo;
  double? redeemWeight;
  double? redeemMetalRate;
  double? redeemMetalValue;
  double? redeemAmount;
  double? totalAmount;

  AdvanceDetails(
      {this.advanceDetails,
      this.advanceDetailsNo,
      this.redeemWeight,
      this.redeemMetalRate,
      this.redeemMetalValue,
      this.redeemAmount,
      this.totalAmount});

  AdvanceDetails.fromJson(Map<String, dynamic> json) {
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

class ChitDetails {
  double? totalAmount;
  double? benefitAmount;
  double? schemeWeight;
  double? balanceWeight;
  List<DenominationDetail>? denominationDetails;

  ChitDetails({this.totalAmount, this.denominationDetails, this.benefitAmount, this.schemeWeight, this.balanceWeight});

  ChitDetails.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    benefitAmount = json['benefit_amount'];
    schemeWeight = json['scheme_weight'];
    balanceWeight = json['balance_weight'];
    if (json['denomination_details'] != null) {
      denominationDetails = <DenominationDetail>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new DenominationDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount'] = this.totalAmount;
    data['benefit_amount'] = this.benefitAmount;
    data['scheme_weight'] = this.schemeWeight;
    data['balance_weight'] = this.balanceWeight;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DenominationDetail {
  String? schemeAccountNumber;
  double? schemeWeight;
  double? schemeAmount;
  double? bonusAmount;

  DenominationDetail(
      {this.schemeAccountNumber,
      this.schemeWeight,
      this.schemeAmount,
      this.bonusAmount});

  DenominationDetail.fromJson(Map<String, dynamic> json) {
    schemeAccountNumber = json['scheme_account_number'];
    schemeWeight = json['scheme_weight'];
    schemeAmount = json['scheme_amount'];
    bonusAmount = json['bonus_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheme_account_number'] = this.schemeAccountNumber;
    data['scheme_weight'] = this.schemeWeight;
    data['scheme_amount'] = this.schemeAmount;
    data['bonus_amount'] = this.bonusAmount;
    return data;
  }
}

class CreateOrderResponse {
  int? id;
  String? orderId;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? customerDetails;
  int? branch;

  CreateOrderResponse(
      {this.id,
      this.orderId,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.customerDetails,
      this.branch});

  CreateOrderResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
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
    data['order_id'] = this.orderId;
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













class OrderOldPurchasePaymentParticularsDetails {
  String? id;
  String? oldGoldBillNo;
  String? totalAmount;

  OrderOldPurchasePaymentParticularsDetails(
      {this.id, this.oldGoldBillNo, this.totalAmount});

  OrderOldPurchasePaymentParticularsDetails.fromJson(Map<String, dynamic> json) {
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

class OrderEdiImageUpload {
  int? id;
  String? orderItemImage;
 
  OrderEdiImageUpload({this.id, this.orderItemImage});
 
  OrderEdiImageUpload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderItemImage = json['order_item_image'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_item_image'] = this.orderItemImage;
    return data;
  }
}







class OrderGetResponse {
  int? id;
  String? orderId;
  double? totalAmount;
  String? gstType;
  double? gstAmount;
  double? payableAmount;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? customerDetails;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  List<ExchangeDetail>? exchangeDetail;
  List<ChitDetail>? chitDetail;
  List<ItemDetail>? itemDetail;

  OrderGetResponse(
      {this.id,
      this.orderId,
      this.totalAmount,
      this.gstType,
      this.gstAmount,
      this.payableAmount,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.customerDetails,
      this.customerName,
      this.customerPhone,
      this.customerAddress,
      this.exchangeDetail,
      this.chitDetail,
      this.itemDetail});

  OrderGetResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    totalAmount = json['total_amount'];
    gstType = json['gst_type'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    customerDetails = json['customer_details'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    if (json['exchange_details'] != null) {
      exchangeDetail = <ExchangeDetail>[];
      json['exchange_details'].forEach((v) {
        exchangeDetail!.add(new ExchangeDetail.fromJson(v));
      });
    }
    if (json['chit_details'] != null) {
      chitDetail = <ChitDetail>[];
      json['chit_details'].forEach((v) {
        chitDetail!.add(new ChitDetail.fromJson(v));
      });
    }
    if (json['item_details'] != null) {
      itemDetail = <ItemDetail>[];
      json['item_details'].forEach((v) {
        itemDetail!.add(new ItemDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['total_amount'] = this.totalAmount;
    data['gst_type'] = this.gstType;
    data['gst_amount'] = this.gstAmount;
    data['payable_amount'] = this.payableAmount;
    data['is_canceled'] = this.isCanceled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['customer_details'] = this.customerDetails;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    if (this.exchangeDetail != null) {
      data['exchange_details'] =
          this.exchangeDetail!.map((v) => v.toJson()).toList();
    }
    if (this.chitDetail != null) {
      data['chit_details'] = this.chitDetail!.map((v) => v.toJson()).toList();
    }
    if (this.itemDetail != null) {
      data['item_details'] = this.itemDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ExchangeDetail {
  String? oldBillNumber;
  int? oldGoldPieces;
  double? oldGoldWeight;
  double? oldGoldAmount;
  List<ParticularList>? particularList;

  ExchangeDetail(
      {this.oldBillNumber,
      this.oldGoldPieces,
      this.oldGoldWeight,
      this.oldGoldAmount,
      this.particularList});

  ExchangeDetail.fromJson(Map<String, dynamic> json) {
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

class ChitDetail {
  int? id;
  double? totalAmount;
  double? benefitAmount;
  double? schemeWeight;
  double? balanceWeight;
  int? paymentDetails;
  List<DenominationDetailed>? denominationDetails;

  ChitDetail(
      {this.id,
      this.totalAmount,
      this.benefitAmount,
      this.schemeWeight,
      this.balanceWeight,
      this.paymentDetails,
      this.denominationDetails});

  ChitDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalAmount = json['total_amount'];
    benefitAmount = json['benefit_amount'];
    schemeWeight = json['scheme_weight'];
    balanceWeight = json['balance_weight'];
    paymentDetails = json['payment_details'];
    if (json['denomination_details'] != null) {
      denominationDetails = <DenominationDetailed>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new DenominationDetailed.fromJson(v));
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

class DenominationDetailed {
  int? id;
  String? schemeAccountNumber;
  double? schemeWeight;
  double? schemeAmount;
  double? bonusAmount;
  int? chitDetails;

  DenominationDetailed(
      {this.id,
      this.schemeAccountNumber,
      this.schemeWeight,
      this.schemeAmount,
      this.bonusAmount,
      this.chitDetails});

  DenominationDetailed.fromJson(Map<String, dynamic> json) {
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

class ItemDetail {
  int? id;
  double? grossWeight;
  double? netWeight;
  int? pieces;
  double? wastagePercent;
  double? makingCharge;
  double? flatWastage;
  double? flatMakingCharge;
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
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? orderDetails;
  int? subItemDetails;
  String? vendorDetails;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? purityName;
  String? metalName;
  int? purity;
  int? metal;
  String? orderId;
  bool? isDb;

  ItemDetail(
      {this.id,
      this.grossWeight,
      this.netWeight,
      this.pieces,
      this.wastagePercent,
      this.makingCharge,
      this.flatWastage,
      this.flatMakingCharge,
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
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.orderDetails,
      this.subItemDetails,
      this.vendorDetails,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.purityName,
      this.metalName,
      this.purity,
      this.metal,
      this.orderId,
      this.isDb});

  ItemDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossWeight = json['gross_weight'];
    netWeight = json['net_weight'];
    pieces = json['pieces'];
    wastagePercent = json['wastage_percent'];
    makingCharge = json['making_charge'];
    flatWastage = json['flat_wastage'];
    flatMakingCharge = json['flat_making_charge'];
    huidAmount = json['huid_amount'];
    totalAmount = json['total_amount'];
    gstAmount = json['gst_amount'];
    payableAmount = json['payable_amount'];
    metalRate = json['metal_rate'];
    gender = json['gender'];
    measurementType = json['measurement_type'];
    priority = json['priority'];
    measurementValue = json['measurement_value'].toString();
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
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    orderDetails = json['order_details'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['pieces'] = this.pieces;
    data['wastage_percent'] = this.wastagePercent;
    data['making_charge'] = this.makingCharge;
    data['flat_wastage'] = this.flatWastage;
    data['flat_making_charge'] = this.flatMakingCharge;
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
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['order_details'] = this.orderDetails;
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
    return data;
  }
}
