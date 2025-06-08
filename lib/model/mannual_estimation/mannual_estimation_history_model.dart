class ManualEstimationHistoryListData {
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
  String? branchName;
  int? customerDetails;
  int? branch;
  String? customerDetailsName;
  int? sNo;

  ManualEstimationHistoryListData(
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
      this.branchName,
      this.customerDetails,
      this.branch,
      this.customerDetailsName,
      this.sNo});

  ManualEstimationHistoryListData.fromJson(Map<String, dynamic> json) {
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
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    customerDetailsName = json['customer_details_name'];
    sNo = json['s_no'];
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
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    data['customer_details_name'] = this.customerDetailsName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class FetchManualEstimationHistoryPayload {
  int? menuId;
  String? branch;
  String? metalType;
  String? customer;
  String? fromDate;
  String? toDate;
  bool? billStatus;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchManualEstimationHistoryPayload(
      {this.menuId,
      this.branch,
      this.metalType,
      this.customer,
      this.fromDate,
      this.toDate,
      this.billStatus,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchManualEstimationHistoryPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    metalType = json['metal_type'];
    customer = json['customer'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    billStatus = json['bill_status'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['metal_type'] = this.metalType;
    data['customer'] = this.customer;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['bill_status'] = this.billStatus;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}
class ManualRetrieveEstimationDetails {
  int? id;
  String? estimationId;
  String? estimationDate;
  double? totalAmount;
  String? gstType;
  double? gstAmount;
  double? advanceAmount;
  double? totalWeight;
  int? totalPieces;
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
  String? metalCode;
  DisplayRate? displayRate;
  String? createdAt;
  String? createdBy;
  int? customerDetails;
  String? customerDetailsName;
  String? customerDetailsMobile;
  String? customerDetailsAddress;
  double? totalBenefitAmount;
  double? totalBalanceWeight;
  double? totalSchemeWeight;
  List<ManualRetrieveParticularDetails>? particularDetails;
  List<ManualRetrieveExchangeDetails>? exchangeDetails;
  List<int>? oldPurchaseDetails;
  List<int>? advanceDetails;
  List<int>? chitDetails;
 
  ManualRetrieveEstimationDetails(
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
      this.metalCode,
      this.displayRate,
      this.createdAt,
      this.createdBy,
      this.customerDetails,
      this.customerDetailsName,
      this.customerDetailsMobile,
      this.totalWeight,
      this.totalPieces,
      this.customerDetailsAddress,
      this.totalBenefitAmount,
      this.totalBalanceWeight,
      this.totalSchemeWeight,
      this.particularDetails,
      this.exchangeDetails,
      this.oldPurchaseDetails,
      this.advanceDetails,
      this.chitDetails});
 
  ManualRetrieveEstimationDetails.fromJson(Map<String, dynamic> json) {
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
    totalPieces = json['total_pieces'];
    totalWeight = json['total_weight'];
    createdBy = json['created_by'];
    customerDetails = json['customer_details'];
    customerDetailsName = json['customer_details_name'];
    customerDetailsMobile = json['customer_details_mobile'];
    customerDetailsAddress = json['customer_details_address'];
    totalBenefitAmount = json['total_benefit_amount'];
    totalBalanceWeight = json['total_balance_weight'];
    totalSchemeWeight = json['total_scheme_weight'];
    metalCode = json['metal_code'];
    displayRate = json['display_rate'] != null
        ? new DisplayRate.fromJson(json['display_rate'])
        : null;
    if (json['particular_details'] != null) {
      particularDetails = <ManualRetrieveParticularDetails>[];
      json['particular_details'].forEach((v) {
        particularDetails!.add(new ManualRetrieveParticularDetails.fromJson(v));
      });
    }
    if (json['exchange_details'] != null) {
      exchangeDetails = <ManualRetrieveExchangeDetails>[];
      json['exchange_details'].forEach((v) {
        exchangeDetails!.add(new ManualRetrieveExchangeDetails.fromJson(v));
      });
    }
    oldPurchaseDetails = json['old_purchase_details'].cast<int>();
    advanceDetails = json['advance_details'].cast<int>();
    chitDetails = json['chit_details'].cast<int>();
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
    data['customer_details'] = this.customerDetails;
    data['customer_details_name'] = this.customerDetailsName;
    data['customer_details_mobile'] = this.customerDetailsMobile;
    data['customer_details_address'] = this.customerDetailsAddress;
    data['total_benefit_amount'] = this.totalBenefitAmount;
    data['total_balance_weight'] = this.totalBalanceWeight;
    data['total_scheme_weight'] = this.totalSchemeWeight;
    data['metal_code'] = this.metalCode;
    data['total_weight'] = this.totalWeight;
    data['total_pieces'] = this.totalPieces;
    if (this.displayRate != null) {
      data['display_rate'] = this.displayRate!.toJson();
    }
    if (this.particularDetails != null) {
      data['particular_details'] =
          this.particularDetails!.map((v) => v.toJson()).toList();
    }
    if (this.exchangeDetails != null) {
      data['exchange_details'] =
          this.exchangeDetails!.map((v) => v.toJson()).toList();
    }
    data['old_purchase_details'] = this.oldPurchaseDetails;
    data['advance_details'] = this.advanceDetails;
    data['chit_details'] = this.chitDetails;
    return data;
  }
}
 
class DisplayRate {
  double? gold;
  double? silver;
 
  DisplayRate({this.gold, this.silver});
 
  DisplayRate.fromJson(Map<String, dynamic> json) {
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




class ManualRetrieveParticularDetails {
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
  String? metalDetailsName;
  String? purityDetailsName;
  String? hsnCode;
  String? sNo;
  String? hallmarkCenter;
  String? hallmarkCertificateNumber;
  double? wastageGram;
  String? measurementValue;
  String? measurementTypeName;
   String? itemName;
  String? subItemName;
  List<ManualEstimationStoneDetails>? stoneDetails;
  List<ManualEstimationDiamondDetails>? diamondDetails;
 
  ManualRetrieveParticularDetails(
      {this.id,
      this.sNo,
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
      this.metalDetailsName,
      this.purityDetailsName,
      this.stoneDetails,
      this.diamondDetails,
      this.hsnCode,
      this.hallmarkCenter,
      this.hallmarkCertificateNumber,
      this.wastageGram,
      this.measurementValue,
      this.measurementTypeName,
      this.itemName,
       this.subItemName,
      });
 
  ManualRetrieveParticularDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sNo = json['s_no'].toString();
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
    metalDetailsName = json['metal_details_name'];
    purityDetailsName = json['purity_details_name'];
    hsnCode = json['hsn_code'];
    hallmarkCenter = json['hallmark_center'];
    hallmarkCertificateNumber = json['hallmark_certificate_number'];
    wastageGram = json['wastage_gram'];
     itemName = json['item_name'];
    subItemName = json['sub_item_name'];
    measurementValue = json['measurement_value'].toString();
    measurementTypeName = json['measurement_type_name'].toString();
    if (json['stone_details'] != null) {
      stoneDetails = <ManualEstimationStoneDetails>[];
      json['stone_details'].forEach((v) {
        stoneDetails!.add(new ManualEstimationStoneDetails.fromJson(v));
      });
    }
    if (json['diamond_details'] != null) {
      diamondDetails = <ManualEstimationDiamondDetails>[];
      json['diamond_details'].forEach((v) {
        diamondDetails!.add(new ManualEstimationDiamondDetails.fromJson(v));
      });
    }
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['s_no'] = this.sNo;
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
    data['metal_details_name'] = this.metalDetailsName;
    data['purity_details_name'] = this.purityDetailsName;
    data['hsn_code'] = this.hsnCode;
    data['hallmark_center'] = this.hallmarkCenter;
    data['hallmark_certificate_number'] = this.hallmarkCertificateNumber;
    data['wastage_gram'] = this.wastageGram;
    data['measurement_value'] = this.measurementValue;
    data['measurement_type_name'] = this.measurementTypeName;
       data['item_name'] = this.itemName;
    data['sub_item_name'] = this.subItemName;
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

class ManualEstimationStoneDetails {
  String? id;
  bool? reduceWeight;
  int? stonePieces;
  double? rate;
  double? stoneWeight;
  double? stoneAmount;
  double? certificateAmount;
  int? estimationParticularDetails;
  int? stone;
  String? stoneName;
 
  ManualEstimationStoneDetails(
      {this.id,
      this.reduceWeight,
      this.stonePieces,
      this.stoneWeight,
      this.stoneAmount,
      this.rate,
      this.certificateAmount,
      this.estimationParticularDetails,
      this.stone,
      this.stoneName});
 
  ManualEstimationStoneDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    reduceWeight = json['reduce_weight'];
    stonePieces = json['stone_pieces'];
    stoneWeight = json['stone_weight'];
    stoneAmount = json['stone_amount'];
    certificateAmount = json['certificate_amount'];
    rate = json['rate'];
    estimationParticularDetails = json['estimation_particular_details'];
    stone = json['stone'];
    stoneName = json['stone_name'];
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
    data['estimation_particular_details'] = this.estimationParticularDetails;
    data['stone'] = this.stone;
    data['stone_name'] = this.stoneName;
    return data;
  }
}
 
class ManualEstimationDiamondDetails {
  String? id;
  bool? reduceWeight;
  int? diamondPieces;
  double? diamondWeight;
  double? diamondAmount;
  double? rate;
  double? certificateAmount;
  int? estimationParticularDetails;
  int? diamond;
  String? diamondName;
 
  ManualEstimationDiamondDetails(
      {this.id,
      this.reduceWeight,
      this.diamondPieces,
      this.diamondWeight,
      this.diamondAmount,
      this.certificateAmount,
      this.rate,
      this.estimationParticularDetails,
      this.diamond,
      this.diamondName});
 
  ManualEstimationDiamondDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    reduceWeight = json['reduce_weight'];
    diamondPieces = json['diamond_pieces'];
    diamondWeight = json['diamond_weight'];
    diamondAmount = json['diamond_amount'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
    estimationParticularDetails = json['estimation_particular_details'];
    diamond = json['diamond'];
    diamondName = json['diamond_name'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reduce_weight'] = this.reduceWeight;
    data['diamond_pieces'] = this.diamondPieces;
    data['diamond_weight'] = this.diamondWeight;
    data['diamond_amount'] = this.diamondAmount;
    data['certificate_amount'] = this.certificateAmount;
    data['rate'] = this.rate;
    data['estimation_particular_details'] = this.estimationParticularDetails;
    data['diamond'] = this.diamond;
    data['diamond_name'] = this.diamondName;
    return data;
  }
}

class ManualRetrieveExchangeDetails {
  int? id;
  double? oldGrossWeight;
  double? oldReduceWeight;
  double? oldRate;
  double? oldTouch;
  double? oldDustWeight;
  double? oldNetWeight;
  double? oldAmount;
  double? gstAmount;
  double? totalAmount;
  int? estimationDetails;
  int? oldMetal;
  String? oldMetalName;

  ManualRetrieveExchangeDetails(
      {this.id,
      this.oldGrossWeight,
      this.oldReduceWeight,
      this.oldRate,
      this.oldTouch,
      this.oldDustWeight,
      this.oldNetWeight,
      this.oldAmount,
      this.gstAmount,
      this.totalAmount,
      this.estimationDetails,
      this.oldMetal,
      this.oldMetalName});

  ManualRetrieveExchangeDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldGrossWeight = json['old_gross_weight'];
    oldReduceWeight = json['old_reduce_weight'];
    oldRate = json['old_rate'];
    oldTouch = json['old_touch'];
    oldDustWeight = json['old_dust_weight'];
    oldNetWeight = json['old_net_weight'];
    oldAmount = json['old_amount'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
    estimationDetails = json['estimation_details'];
    oldMetal = json['old_metal'];
    oldMetalName = json['old_metal_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_gross_weight'] = this.oldGrossWeight;
    data['old_reduce_weight'] = this.oldReduceWeight;
    data['old_rate'] = this.oldRate;
    data['old_touch'] = this.oldTouch;
    data['old_dust_weight'] = this.oldDustWeight;
    data['old_net_weight'] = this.oldNetWeight;
    data['old_amount'] = this.oldAmount;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    data['estimation_details'] = this.estimationDetails;
    data['old_metal'] = this.oldMetal;
    data['old_metal_name'] = this.oldMetalName;
    return data;
  }
}
