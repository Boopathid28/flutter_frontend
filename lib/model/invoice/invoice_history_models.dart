import 'package:ausales_application/model/payment/advance_payment_model.dart';
import 'package:ausales_application/model/payment/chit_scheme_payment_model.dart';
import 'package:ausales_application/model/payment/denomination_payment_model.dart';

class FetchBillingHistoryPayload {
  int? menuId;
  String? branch;
  String? customer;
  String? fromDate;
  String? toDate;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchBillingHistoryPayload(
      {this.menuId,
      this.branch,
      this.customer,
      this.fromDate,
      this.toDate,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchBillingHistoryPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    customer = json['customer'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['customer'] = this.customer;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class BillingHistoryListData {
  int? id;
  String? billId;
  String? billDate;
  double? totalAmount;
  String? gstType;
  double? gstAmount;
  double? discountAmount;
  double? roundoffAmount;
  double? payableAmount;
  double? paidAmount;
  double? balanceAmount;
  String? createdAt;
  String? createdBy;
  String? branchName;
  int? customerDetails;
  String? customerMobileNumber;
  int? branch;
  String? customerDetailsName;
  int? sNo;

  BillingHistoryListData(
      {this.id,
      this.billId,
      this.billDate,
      this.totalAmount,
      this.gstType,
      this.gstAmount,
      this.discountAmount,
      this.paidAmount, this.balanceAmount,
      this.roundoffAmount,
      this.payableAmount,
      this.createdAt,
      this.createdBy,
      this.branchName,
      this.customerDetails,
      this.customerMobileNumber,
      this.branch,
      this.customerDetailsName,
      this.sNo});

  BillingHistoryListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billId = json['bill_id'];
    billDate = json['bill_date'];
    totalAmount = json['total_amount'];
    gstType = json['gst_type'];
    gstAmount = json['gst_amount'];
    discountAmount = json['discount_amount'];
    paidAmount = json['paid_amount'];
    balanceAmount = json['balance_amount'];
    roundoffAmount = json['roundoff_amount'];
    payableAmount = json['payable_amount'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    customerMobileNumber = json['customer_mobile_number'];
    branch = json['branch'];
    customerDetailsName = json['customer_details_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_id'] = this.billId;
    data['bill_date'] = this.billDate;
    data['total_amount'] = this.totalAmount;
    data['gst_type'] = this.gstType;
    data['gst_amount'] = this.gstAmount;
    data['discount_amount'] = this.discountAmount;
    data['paid_amount'] = this.paidAmount;
    data['balance_amount'] = this.balanceAmount;
    data['roundoff_amount'] = this.roundoffAmount;
    data['payable_amount'] = this.payableAmount;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['customer_mobile_number'] = this.customerMobileNumber;
    data['branch'] = this.branch;
    data['customer_details_name'] = this.customerDetailsName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class RetrieveBillingDetails {
  int? id;
  String? billId;
  bool? issued;
  String? billDate;
  double? totalAmount;
  String? gstType;
  double? gstAmount;
  double? discountAmount;
  double? roundoffAmount;
  double? payableAmount;
  String? createdAt;
  String? createdBy;
  String? metalName;
  String? branchName;
  String? duedate;
  int? customerDetails;
  int? branch;
  String? customerName;
  String? customerMobile;
  String? customerAddress;
  List<RetrieveParticularDetails>? particularDetails;
  List<PaymentDetails>? paymentDetails;
  List<PrintExchangeDetails>? exchangeDetails;
  List<DenominationDetails>? demoninationDetails;
  double? totalDenominationAmount;
  double? totalExchangeAmount;
  double? totalAdvanceAmount;
  double? totalSuspenseAmount;
  double? paidAmount;
  double? balanceAmount;
  double? TotalCashAmount;
  double? TotalCardAmount;
  double? TotalBankAmount;
  double? TotalUpiAmount;
  double? TotalChitAmount;
  List<OrderDetails>? orderDetails;

  RetrieveBillingDetails(
      {this.id,
      this.billId,
      this.issued,
      this.billDate,
      this.totalAmount,
      this.metalName,
      this.gstType,
      this.gstAmount,
      this.discountAmount,
      this.roundoffAmount,
      this.payableAmount,
      this.createdAt,
      this.createdBy,
      this.branchName,
      this.customerDetails,
      this.branch,
      this.customerName,
      this.customerMobile,
      this.duedate,
      this.customerAddress,
      this.particularDetails,
      this.paymentDetails,
      this.demoninationDetails,
      this.totalDenominationAmount,
      this.totalExchangeAmount,
      this.totalAdvanceAmount,
      this.totalSuspenseAmount,
      this.paidAmount,
      this.exchangeDetails,
      this.TotalBankAmount,
      this.TotalCashAmount,
      this.TotalCardAmount,
      this.TotalUpiAmount,
      this.TotalChitAmount,
      this.orderDetails,
      this.balanceAmount});

  RetrieveBillingDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billId = json['bill_id'];
    issued = json['is_issued'];
    billDate = json['bill_date'];
    duedate = json['due_date'];
    metalName = json['metal_name'];
    totalAmount = json['total_amount'];
    gstType = json['gst_type'];
    gstAmount = json['gst_amount'];
    discountAmount = json['discount_amount'];
    roundoffAmount = json['roundoff_amount'];
    payableAmount = json['payable_amount'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    customerName = json['customer_name'];
    customerMobile = json['customer_mobile'];
    customerAddress = json['customer_address'];
    if (json['particular_details'] != null) {
      particularDetails = <RetrieveParticularDetails>[];
      json['particular_details'].forEach((v) {
        particularDetails!.add(new RetrieveParticularDetails.fromJson(v));
      });
    }
    if (json['payment_details'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['payment_details'].forEach((v) {
        paymentDetails!.add(new PaymentDetails.fromJson(v));
      });
    }
    if (json['exchange_details'] != null) {
      exchangeDetails = <PrintExchangeDetails>[];
      json['exchange_details'].forEach((v) {
        exchangeDetails!.add(new PrintExchangeDetails.fromJson(v));
      });
    }
    if (json['denomination_details'] != null) {
      demoninationDetails = <DenominationDetails>[];
      json['denomination_details'].forEach((v) {
        demoninationDetails!.add(new DenominationDetails.fromJson(v));
      });
    }
    totalDenominationAmount = json['total_denomination_amount'];
    totalExchangeAmount = json['total_exchange_amount'];
    totalAdvanceAmount = json['total_advance_amount'];
    totalSuspenseAmount = json['total_suspense_amount'];
    paidAmount = json['paid_amount'];
    balanceAmount = json['balance_amount'];
    TotalCashAmount = json['total_cash_amount'];
    TotalCardAmount = json['total_card_amount'];
    TotalBankAmount = json['total_bank_amount'];
    TotalUpiAmount = json['total_upi_amount'];
    TotalChitAmount = json['total_chit_amount'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(new OrderDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_id'] = this.billId;
    data['is_issued'] = this.issued;
    data['bill_date'] = this.billDate;
    data['due_date'] = this.duedate;
    data['metal_name'] = this.metalName;
    data['total_amount'] = this.totalAmount;
    data['gst_type'] = this.gstType;
    data['gst_amount'] = this.gstAmount;
    data['discount_amount'] = this.discountAmount;
    data['roundoff_amount'] = this.roundoffAmount;
    data['payable_amount'] = this.payableAmount;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    data['customer_name'] = this.customerName;
    data['customer_mobile'] = this.customerMobile;
    data['customer_address'] = this.customerAddress;
    if (this.particularDetails != null) {
      data['particular_details'] =
          this.particularDetails!.map((v) => v.toJson()).toList();
    }
    if (this.exchangeDetails != null) {
      data['exchange_details'] =
          this.exchangeDetails!.map((v) => v.toJson()).toList();
    }
    if (this.paymentDetails != null) {
      data['payment_details'] =
          this.paymentDetails!.map((v) => v.toJson()).toList();
    }
     if (this.demoninationDetails != null) {
      data['denomination_details'] =
          this.demoninationDetails!.map((v) => v.toJson()).toList();
    }
    data['total_denomination_amount'] = this.totalDenominationAmount;
    data['total_exchange_amount'] = this.totalExchangeAmount;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['total_suspense_amount'] = this.totalSuspenseAmount;
    data['paid_amount'] = this.paidAmount;
    data['balance_amount'] = this.balanceAmount;
    data['total_chit_amount'] = this.TotalChitAmount;
       data['total_upi_amount'] = this.TotalUpiAmount;
    data['total_bank_amount'] = this.TotalBankAmount;
    data['total_card_amount'] = this.TotalCardAmount;
    data['total_cash_amount'] = this.TotalCashAmount;
    if (this.orderDetails != null) {
      data['order_details'] =
          this.orderDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderDetails {
  String? orderId;

  OrderDetails({this.orderId});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    return data;
  }
}

class RetrieveParticularDetails {
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
  int? billingDetails;
  int? tagDetails;
  String? tagNumber;
  String? subItemDetailsName;
  String? itemDetailsName;
  String? purityName;
  String? metalName;
  String? vendorName;
  String? calculationType;
  double? wastageAmount;
  double? wastageWeightReduced;
  String? wastageCalculationType;
  String? flatWastageType;
  String? makingChargeCalculationType;
  String? perGramWeightType;
  String? hsnCode;
  String? hallmarkCenter;
  String? hallmarkCertificateNumber;
  double? wastageGram;

  RetrieveParticularDetails(
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
      this.billingDetails,
      this.tagDetails,
      this.tagNumber,
      this.subItemDetailsName,
      this.itemDetailsName,
      this.purityName,
      this.metalName,
      this.vendorName,
      this.calculationType,
      this.wastageAmount,
      this.wastageWeightReduced,
      this.wastageCalculationType,
      this.flatWastageType,
      this.makingChargeCalculationType,
      this.perGramWeightType,
      this.hsnCode,
      this.hallmarkCenter,
      this.hallmarkCertificateNumber,
      this.wastageGram});

  RetrieveParticularDetails.fromJson(Map<String, dynamic> json) {
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
    billingDetails = json['billing_details'];
    tagDetails = json['tag_details'];
    tagNumber = json['tag_number'];
    subItemDetailsName = json['sub_item'];
    itemDetailsName = json['item_details_name'];
    purityName = json['purity_name'];
    metalName = json['metal_name'];
    vendorName = json['vendor_name'];
    calculationType = json['calculation_type'];
    wastageAmount = json['wastage_amount'];
    wastageWeightReduced = json['wastage_weight_reduced'];
    wastageCalculationType = json['wastage_calculation_type'];
    flatWastageType = json['flat_wastage_type'];
    makingChargeCalculationType = json['making_charge_calculation_type'];
    perGramWeightType = json['per_gram_weight_type'];
    hsnCode = json['hsn_code'];
    hallmarkCenter = json['hallmark_center'];
    hallmarkCertificateNumber = json['hallmark_certificate_number'];
    wastageGram = json['wastage_gram'];
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
    data['billing_details'] = this.billingDetails;
    data['tag_details'] = this.tagDetails;
    data['tag_number'] = this.tagNumber;
    data['sub_item'] = this.subItemDetailsName;
    data['item_details_name'] = this.itemDetailsName;
    data['purity_name'] = this.purityName;
    data['metal_name'] = this.metalName;
    data['vendor_name'] = this.vendorName;
    data['calculation_type'] = this.calculationType;
    data['wastage_amount'] = this.wastageAmount;
    data['wastage_weight_reduced'] = this.wastageWeightReduced;
    data['wastage_calculation_type'] = this.wastageCalculationType;
    data['flat_wastage_type'] = this.flatWastageType;
    data['making_charge_calculation_type'] = this.makingChargeCalculationType;
    data['per_gram_weight_type'] = this.perGramWeightType;
    data['hsn_code'] = this.hsnCode;
    data['hallmark_center'] = this.hallmarkCenter;
    data['hallmark_certificate_number'] = this.hallmarkCertificateNumber;
    data['wastage_gram'] = this.wastageGram;
    return data;
  }
}

class PaymentDetails {
  int? id;
  String? paymentId;
  String? paymentDate;
  String? createdBy;
  String? branchName;
  int? billingDetails;
  int? branch;
  List<DenominationDetails>? denominationDetails;
  List<RetrieveExchangeDetails>? exchangeDetails;
  List<AdvanceDetails>? advanceDetails;
  List<SuspenseDetails>? suspenseDetails;
  double? denominationAmount;
  double? exchangeAmount;
  double? advanceAmount;
  double? chitAmount;
  double? suspenseAmount;

  PaymentDetails(
      {this.id,
      this.paymentId,
      this.paymentDate,
      this.createdBy,
      this.branchName,
      this.billingDetails,
      this.branch,
      this.denominationDetails,
      this.exchangeDetails,
      this.advanceDetails,
      this.suspenseDetails,
      this.denominationAmount,
      this.exchangeAmount,
      this.advanceAmount,
      this.chitAmount,
      this.suspenseAmount});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    paymentDate = json['payment_date'];
    createdBy = json['created_by'];
    branchName = json['branch_name'];
    billingDetails = json['billing_details'];
    branch = json['branch'];
    if (json['denomination_details'] != null) {
      denominationDetails = <DenominationDetails>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new DenominationDetails.fromJson(v));
      });
    }
    if (json['exchange_details'] != null) {
      exchangeDetails = <RetrieveExchangeDetails>[];
      json['exchange_details'].forEach((v) {
        exchangeDetails!.add(new RetrieveExchangeDetails.fromJson(v));
      });
    }
    if (json['advance_details'] != null) {
      advanceDetails = <AdvanceDetails>[];
      json['advance_details'].forEach((v) {
        advanceDetails!.add(new AdvanceDetails.fromJson(v));
      });
    }
    if (json['suspense_details'] != null) {
      suspenseDetails = <SuspenseDetails>[];
      json['suspense_details'].forEach((v) {
        suspenseDetails!.add(new SuspenseDetails.fromJson(v));
      });
    }
    denominationAmount = json['denomination_amount'];
    exchangeAmount = json['exchange_amount'];
    advanceAmount = json['advance_amount'];
    chitAmount = json['chit_amount'];
    suspenseAmount = json['suspense_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['payment_date'] = this.paymentDate;
    data['created_by'] = this.createdBy;
    data['branch_name'] = this.branchName;
    data['billing_details'] = this.billingDetails;
    data['branch'] = this.branch;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    if (this.exchangeDetails != null) {
      data['exchange_details'] =
          this.exchangeDetails!.map((v) => v.toJson()).toList();
    }
    if (this.advanceDetails != null) {
      data['advance_details'] =
          this.advanceDetails!.map((v) => v.toJson()).toList();
    }
    if (this.suspenseDetails != null) {
      data['suspense_details'] =
          this.suspenseDetails!.map((v) => v.toJson()).toList();
    }
    data['denomination_amount'] = this.denominationAmount;
    data['exchange_amount'] = this.exchangeAmount;
    data['advance_amount'] = this.advanceAmount;
    data['chit_amount'] = this.chitAmount;
    data['suspense_amount'] = this.suspenseAmount;
    return data;
  }
}

class DenominationDetails {
  int? id;
  String? paymentMethod;
  String? paymentProvider;
  double? paidAmount;
  String? remark;
  int? paymentDetails;

  DenominationDetails(
      {this.id,
      this.paymentMethod,
      this.paymentProvider,
      this.paidAmount,
      this.remark,
      this.paymentDetails});

  DenominationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['payment_method'];
    paymentProvider = json['payment_provider'];
    paidAmount = json['paid_amount'];
    remark = json['remark'];
    paymentDetails = json['payment_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    data['payment_provider'] = this.paymentProvider;
    data['paid_amount'] = this.paidAmount;
    data['remark'] = this.remark;
    data['payment_details'] = this.paymentDetails;
    return data;
  }
}

class RetrieveExchangeDetails {
  List<CommonDetails>? commonDetails;
  List<Particulars>? particulars;

  RetrieveExchangeDetails({this.commonDetails, this.particulars});

  RetrieveExchangeDetails.fromJson(Map<String, dynamic> json) {
    if (json['common_details'] != null) {
      commonDetails = <CommonDetails>[];
      json['common_details'].forEach((v) {
        commonDetails!.add(new CommonDetails.fromJson(v));
      });
    }
    if (json['particulars'] != null) {
      particulars = <Particulars>[];
      json['particulars'].forEach((v) {
        particulars!.add(new Particulars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.commonDetails != null) {
      data['common_details'] =
          this.commonDetails!.map((v) => v.toJson()).toList();
    }
    if (this.particulars != null) {
      data['particulars'] = this.particulars!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommonDetails {
  String? oldBillNumber;
  int? oldGoldPieces;
  double? oldGoldWeight;
  double? oldGoldAmount;

  CommonDetails(
      {this.oldBillNumber,
      this.oldGoldPieces,
      this.oldGoldWeight,
      this.oldGoldAmount});

  CommonDetails.fromJson(Map<String, dynamic> json) {
    oldBillNumber = json['old_bill_number'];
    oldGoldPieces = json['old_gold_pieces'];
    oldGoldWeight = json['old_gold_weight'];
    oldGoldAmount = json['old_gold_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['old_bill_number'] = this.oldBillNumber;
    data['old_gold_pieces'] = this.oldGoldPieces;
    data['old_gold_weight'] = this.oldGoldWeight;
    data['old_gold_amount'] = this.oldGoldAmount;
    return data;
  }
}

class Particulars {
  double? oldGrossWeight;
  double? oldNetWeight;
  double? oldDustWeight;
  String? oldBillNumber;
  String? metalName;
  String? itemName;
  double? oldRate;
  double? totalAmount;

  Particulars(
      {this.oldGrossWeight,
      this.oldNetWeight,
      this.oldDustWeight,
      this.oldBillNumber,
      this.metalName,
      this.itemName,
      this.oldRate,
      this.totalAmount});

  Particulars.fromJson(Map<String, dynamic> json) {
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

class SuspenseDetails {
  String? suspenseId;
  double? suspenseTotalAmount;
  List<ItemDetails>? itemDetails;

  SuspenseDetails(
      {this.suspenseId, this.suspenseTotalAmount, this.itemDetails});

  SuspenseDetails.fromJson(Map<String, dynamic> json) {
    suspenseId = json['suspense_id'];
    suspenseTotalAmount = json['suspense_total_amount'];
    if (json['item_details'] != null) {
      itemDetails = <ItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new ItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['suspense_id'] = this.suspenseId;
    data['suspense_total_amount'] = this.suspenseTotalAmount;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemDetails {
  String? metalName;
  String? itemName;
  double? metalWeight;
  double? metalAmount;
  double? totalAmount;

  ItemDetails(
      {this.metalName,
      this.itemName,
      this.metalWeight,
      this.metalAmount,
      this.totalAmount});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    metalName = json['metal_name'];
    itemName = json['item_name'];
    metalWeight = json['metal_weight'];
    metalAmount = json['metal_amount'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['metal_name'] = this.metalName;
    data['item_name'] = this.itemName;
    data['metal_weight'] = this.metalWeight;
    data['metal_amount'] = this.metalAmount;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class BillPaymentModel {
  int? menuId;
  String? branch;
  String? id;
  List<int>? exchangeDetails;
  List<int>? suspenseDetails;
  List<AdvancePaymentItemModel>? advanceDetails;
  List<PaymentDenominationItemModel>? paymentDenominationDetails;
  List<ChitPaymentDetails>? chitDetails;

  BillPaymentModel(
      {this.menuId,
      this.branch,
      this.id,
      this.exchangeDetails,
      this.suspenseDetails,
      this.advanceDetails,
      this.paymentDenominationDetails,
      this.chitDetails});

  BillPaymentModel.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    id = json['id'];
    exchangeDetails = json['exchange_details'].cast<int>();
    suspenseDetails = json['suspense_details'].cast<int>();
    if (json['advance_details'] != null) {
      advanceDetails = <AdvancePaymentItemModel>[];
      json['advance_details'].forEach((v) {
        advanceDetails!.add(new AdvancePaymentItemModel.fromJson(v));
      });
    }
    if (json['payment_denomination_details'] != null) {
      paymentDenominationDetails = <PaymentDenominationItemModel>[];
      json['payment_denomination_details'].forEach((v) {
        paymentDenominationDetails!.add(new PaymentDenominationItemModel.fromJson(v));
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
    data['branch'] = this.branch;
    data['id'] = this.id;
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

class ChitDetails {
  int? totalAmount;
  List<ChitPaymentDenominationParticulars>? denominationDetails;

  ChitDetails({this.totalAmount, this.denominationDetails});

  ChitDetails.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    if (json['denomination_details'] != null) {
      denominationDetails = <ChitPaymentDenominationParticulars>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new ChitPaymentDenominationParticulars.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_amount'] = this.totalAmount;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class PrintExchangeDetails {
  String? oldBillNumber;
  int? oldGoldPieces;
  double? oldGoldWeight;
  double? oldGoldAmount;
  List<PrintParticularList>? particularList;

  PrintExchangeDetails(
      {this.oldBillNumber,
      this.oldGoldPieces,
      this.oldGoldWeight,
      this.oldGoldAmount,
      this.particularList});

  PrintExchangeDetails.fromJson(Map<String, dynamic> json) {
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