class FetchAdvanceListPayload {
  int? menuId;
  bool? cancelStatus;
  bool? redeemStatus;
  String? customerDetails;
  String? advancePurpose;
  String? search;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchAdvanceListPayload(
      {this.menuId,
      this.cancelStatus,
      this.redeemStatus,
      this.customerDetails,
      this.advancePurpose,
      this.search,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchAdvanceListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    cancelStatus = json['cancel_status'];
    redeemStatus = json['redeem_status'];
    customerDetails = json['customer_details'];
    advancePurpose = json['advance_purpose'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['cancel_status'] = this.cancelStatus;
    data['redeem_status'] = this.redeemStatus;
    data['customer_details'] = this.customerDetails;
    data['advance_purpose'] = this.advancePurpose;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}




class AdvanceListData {
  int? id;
  String? advanceId;
  double? totalAdvanceAmount;
  double? totalAdvanceWeight;
  String? advancePurpose;
  double? redeemAmount;
  double? redeemWeight;
  String? remark;
  bool? isRedeemed;
  bool? isCancelled;
  String? createdAt;
  String? createdBy;
  String? branchName;
  int? customerDetails;
  int? advanceWeightPurity;
  int? branch;
  String? customerDetailsName;
  double? remainingAmount;
  double? remainingWeight;

  AdvanceListData(
      {this.id,
      this.advanceId,
      this.totalAdvanceAmount,
      this.totalAdvanceWeight,
      this.advancePurpose,
      this.redeemAmount,
      this.redeemWeight,
      this.remark,
      this.isRedeemed,
      this.isCancelled,
      this.createdAt,
      this.createdBy,
      this.branchName,
      this.customerDetails,
      this.advanceWeightPurity,
      this.branch,
      this.customerDetailsName,
      this.remainingAmount,
      this.remainingWeight});

  AdvanceListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advanceId = json['advance_id'];
    totalAdvanceAmount = json['total_advance_amount'];
    totalAdvanceWeight = json['total_advance_weight'];
    advancePurpose = json['advance_purpose'];
    redeemAmount = json['redeem_amount'];
    redeemWeight = json['redeem_weight'];
    remark = json['remark'];
    isRedeemed = json['is_redeemed'];
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    advanceWeightPurity = json['advance_weight_purity'];
    branch = json['branch'];
    customerDetailsName = json['customer_details_name'];
    remainingAmount = json['remaining_amount'];
    remainingWeight = json['remaining_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advance_id'] = this.advanceId;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['total_advance_weight'] = this.totalAdvanceWeight;
    data['advance_purpose'] = this.advancePurpose;
    data['redeem_amount'] = this.redeemAmount;
    data['redeem_weight'] = this.redeemWeight;
    data['remark'] = this.remark;
    data['is_redeemed'] = this.isRedeemed;
    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['advance_weight_purity'] = this.advanceWeightPurity;
    data['branch'] = this.branch;
    data['customer_details_name'] = this.customerDetailsName;
    data['remaining_amount'] = this.remainingAmount;
    data['remaining_weight'] = this.remainingWeight;
    return data;
  }
}



class CreateAdvancePayload {
  int? menuId;
  String? customerDetails;
  String? totalAdvanceAmount;
  String? advanceWeightPurity;
  String? totalAdvanceWeight;
  String? advancePurpose;
  String? remark;
  List<DenominationDetails>? denominationDetails;
  String? branch;

  CreateAdvancePayload(
      {this.menuId,
      this.customerDetails,
      this.totalAdvanceAmount,
      this.advanceWeightPurity,
      this.totalAdvanceWeight,
      this.advancePurpose,
      this.remark,
      this.denominationDetails,
      this.branch});

  CreateAdvancePayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    customerDetails = json['customer_details'];
    totalAdvanceAmount = json['total_advance_amount'];
    advanceWeightPurity = json['advance_weight_purity'];
    totalAdvanceWeight = json['total_advance_weight'];
    advancePurpose = json['advance_purpose'];
    remark = json['remark'];
    if (json['denomination_details'] != null) {
      denominationDetails = <DenominationDetails>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new DenominationDetails.fromJson(v));
      });
    }
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['customer_details'] = this.customerDetails;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['advance_weight_purity'] = this.advanceWeightPurity;
    data['total_advance_weight'] = this.totalAdvanceWeight;
    data['advance_purpose'] = this.advancePurpose;
    data['remark'] = this.remark;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    data['branch'] = this.branch;
    return data;
  }
}

class DenominationDetails {
  String? sNo;
  String? paymentMethod;
  String? paymentMethodName;
  String? paymentProviderName;
  String? paymentProvider;
  double? paidAmount;
  String? remark;

  DenominationDetails(
      {this.paymentMethod,
      this.sNo,
      this.paymentMethodName,
      this.paymentProviderName,
      this.paymentProvider,
      this.paidAmount,
      this.remark});

  DenominationDetails.fromJson(Map<String, dynamic> json) {
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


class AdvanceResponse {
  int? id;
  String? advanceId;
  int? totalAdvanceAmount;
  int? totalAdvanceWeight;
  String? advancePurpose;
  int? redeemAmount;
  int? redeemWeight;
  String? remark;
  bool? isRedeemed;
  bool? isCancelled;
  String? createdAt;
  String? createdBy;
  String? branchName;
  int? customerDetails;
  int? advanceWeightPurity;
  int? branch;

  AdvanceResponse(
      {this.id,
      this.advanceId,
      this.totalAdvanceAmount,
      this.totalAdvanceWeight,
      this.advancePurpose,
      this.redeemAmount,
      this.redeemWeight,
      this.remark,
      this.isRedeemed,
      this.isCancelled,
      this.createdAt,
      this.createdBy,
      this.branchName,
      this.customerDetails,
      this.advanceWeightPurity,
      this.branch});

  AdvanceResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advanceId = json['advance_id'];
    totalAdvanceAmount = json['total_advance_amount'];
    totalAdvanceWeight = json['total_advance_weight'];
    advancePurpose = json['advance_purpose'];
    redeemAmount = json['redeem_amount'];
    redeemWeight = json['redeem_weight'];
    remark = json['remark'];
    isRedeemed = json['is_redeemed'];
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    advanceWeightPurity = json['advance_weight_purity'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advance_id'] = this.advanceId;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['total_advance_weight'] = this.totalAdvanceWeight;
    data['advance_purpose'] = this.advancePurpose;
    data['redeem_amount'] = this.redeemAmount;
    data['redeem_weight'] = this.redeemWeight;
    data['remark'] = this.remark;
    data['is_redeemed'] = this.isRedeemed;
    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['advance_weight_purity'] = this.advanceWeightPurity;
    data['branch'] = this.branch;
    return data;
  }
}

class AdvanceRetrieveData {
  int? id;
  String? advanceId;
  double? totalAdvanceAmount;
  double? totalAdvanceWeight;
  String? advancePurpose;
  String? remark;
  bool? isRedeemed;
  bool? isCancelled;
  String? createdAt;
  String? createdBy;
  String? branchName;
  int? customerDetails;
  int? advanceWeightPurity;
  int? branch;
  String? customerDetailsName;
  String? purityName;
  String? redeemAmount;
  String? redeemWeight;
  String? remainingAmount;
  String? remainingWeight;
  String? metalRate;

  AdvanceRetrieveData(
      {this.id,
      this.advanceId,
      this.totalAdvanceAmount,
      this.totalAdvanceWeight,
      this.advancePurpose,
      this.remark,
      this.isRedeemed,
      this.isCancelled,
      this.createdAt,
      this.createdBy,
      this.branchName,
      this.customerDetails,
      this.advanceWeightPurity,
      this.branch,
      this.customerDetailsName,
      this.purityName,
      this.redeemAmount,
      this.redeemWeight,
      this.remainingAmount,
      this.remainingWeight,
      this.metalRate});

  AdvanceRetrieveData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advanceId = json['advance_id'];
    totalAdvanceAmount = json['total_advance_amount'];
    totalAdvanceWeight = json['total_advance_weight'];
    advancePurpose = json['advance_purpose'];
    remark = json['remark'];
    isRedeemed = json['is_redeemed'];
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    advanceWeightPurity = json['advance_weight_purity'];
    branch = json['branch'];
    customerDetailsName = json['customer_details_name'];
    purityName = json['purity_name'];
    redeemAmount = json['redeem_amount'].toString();
    redeemWeight = json['redeem_weight'].toString();
    remainingAmount = json['remaining_amount'].toString();
    remainingWeight = json['remaining_weight'].toString();
    metalRate = json['metal_rate'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advance_id'] = this.advanceId;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['total_advance_weight'] = this.totalAdvanceWeight;
    data['advance_purpose'] = this.advancePurpose;
    data['remark'] = this.remark;
    data['is_redeemed'] = this.isRedeemed;
    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['advance_weight_purity'] = this.advanceWeightPurity;
    data['branch'] = this.branch;
    data['customer_details_name'] = this.customerDetailsName;
    data['purity_name'] = this.purityName;
    data['redeem_amount'] = this.redeemAmount;
    data['redeem_weight'] = this.redeemWeight;
    data['remaining_amount'] = this.remainingAmount;
    data['remaining_weight'] = this.remainingWeight;
    data['metal_rate'] = this.metalRate;
    return data;
  }
}

class AdvanceCreateResponse {
  int? id;
  String? advanceId;
  double? totalAdvanceAmount;
  double? totalAdvanceWeight;
  String? advancePurpose;
  String? remark;
  bool? isRedeemed;
  bool? isCancelled;
  String? createdAt;
  String? createdBy;
  String? branchName;
  int? customerDetails;
  int? advanceWeightPurity;
  int? branch;

  AdvanceCreateResponse(
      {this.id,
      this.advanceId,
      this.totalAdvanceAmount,
      this.totalAdvanceWeight,
      this.advancePurpose,
      this.remark,
      this.isRedeemed,
      this.isCancelled,
      this.createdAt,
      this.createdBy,
      this.branchName,
      this.customerDetails,
      this.advanceWeightPurity,
      this.branch});

  AdvanceCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advanceId = json['advance_id'];
    totalAdvanceAmount = json['total_advance_amount'];
    totalAdvanceWeight = json['total_advance_weight'];
    advancePurpose = json['advance_purpose'];
    remark = json['remark'];
    isRedeemed = json['is_redeemed'];
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    advanceWeightPurity = json['advance_weight_purity'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advance_id'] = this.advanceId;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['total_advance_weight'] = this.totalAdvanceWeight;
    data['advance_purpose'] = this.advancePurpose;
    data['remark'] = this.remark;
    data['is_redeemed'] = this.isRedeemed;
    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['advance_weight_purity'] = this.advanceWeightPurity;
    data['branch'] = this.branch;
    return data;
  }
}

class AdvanceDetailsData {
  int? id;
  String? advanceId;
  double? totalAdvanceAmount;
  double? totalAdvanceWeight;
  String? advancePurpose;
  String? customerMobile;
  String? customerAddress;
  String? remark;
  bool? isRedeemed;
  bool? isCancelled;
  String? createdAt;
  String? createdBy;
  int? customerDetails;
  int? advanceWeightPurity;
  String? customerDetailsName;
  String? purityName;
  double? redeemAmount;
  double? redeemWeight;
  double? remainingAmount;
  double? remainingWeight;
  List<AdvanceDetailsLogDetails>? logDetails;
  List<AdvanceDetailsLedgerData>? ledgerData;
 
  AdvanceDetailsData(
      {this.id,
      this.advanceId,
      this.totalAdvanceAmount,
      this.totalAdvanceWeight,
      this.advancePurpose,
      this.remark,
      this.isRedeemed,
      this.isCancelled,
      this.createdAt,
      this.createdBy,
      this.customerDetails,
      this.advanceWeightPurity,
      this.customerDetailsName,
      this.customerMobile, this.customerAddress,
      this.purityName,
      this.redeemAmount,
      this.redeemWeight,
      this.remainingAmount,
      this.remainingWeight,
      this.logDetails,
      this.ledgerData});
 
  AdvanceDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advanceId = json['advance_id'];
    totalAdvanceAmount = json['total_advance_amount'];
    totalAdvanceWeight = json['total_advance_weight'];
    advancePurpose = json['advance_purpose'];
    remark = json['remark'];
    customerMobile = json['customer_mobile'];
    customerAddress = json['customer_address'];
    isRedeemed = json['is_redeemed'];
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    customerDetails = json['customer_details'];
    advanceWeightPurity = json['advance_weight_purity'];
    customerDetailsName = json['customer_details_name'];
    purityName = json['purity_name'];
    redeemAmount = double.parse(json['redeem_amount'].toString());
    redeemWeight = double.parse(json['redeem_weight'].toString());
    remainingAmount = double.parse(json['remaining_amount'].toString());
    remainingWeight = double.parse(json['remaining_weight'].toString());
    if (json['log_details'] != null) {
      logDetails = <AdvanceDetailsLogDetails>[];
      json['log_details'].forEach((v) {
        logDetails!.add(new AdvanceDetailsLogDetails.fromJson(v));
      });
    }
    if (json['ledger_data'] != null) {
      ledgerData = <AdvanceDetailsLedgerData>[];
      json['ledger_data'].forEach((v) {
        ledgerData!.add(new AdvanceDetailsLedgerData.fromJson(v));
      });
    }
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['advance_id'] = this.advanceId;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['total_advance_weight'] = this.totalAdvanceWeight;
    data['advance_purpose'] = this.advancePurpose;
    data['remark'] = this.remark;
    data['is_redeemed'] = this.isRedeemed;
    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['customer_mobile'] = this.customerMobile;
    data['customer_address'] = this.customerAddress;
    data['customer_details'] = this.customerDetails;
    data['advance_weight_purity'] = this.advanceWeightPurity;
    data['customer_details_name'] = this.customerDetailsName;
    data['purity_name'] = this.purityName;
    data['redeem_amount'] = this.redeemAmount;
    data['redeem_weight'] = this.redeemWeight;
    data['remaining_amount'] = this.remainingAmount;
    data['remaining_weight'] = this.remainingWeight;
    if (this.logDetails != null) {
      data['log_details'] = this.logDetails!.map((v) => v.toJson()).toList();
    }
    if (this.ledgerData != null) {
      data['ledger_data'] = this.ledgerData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdvanceDetailsLogDetails {
  int? id;
  String? billNumber;
  double? redeemAmount;
  double? redeemWeight;
  bool? isCancelled;
  int? advanceDetails;

  AdvanceDetailsLogDetails(
      {this.id,
      this.billNumber,
      this.redeemAmount,
      this.redeemWeight,
      this.isCancelled,
      this.advanceDetails});

  AdvanceDetailsLogDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billNumber = json['bill_number'];
    redeemAmount = json['redeem_amount'];
    redeemWeight = json['redeem_weight'];
    isCancelled = json['is_cancelled'];
    advanceDetails = json['advance_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bill_number'] = this.billNumber;
    data['redeem_amount'] = this.redeemAmount;
    data['redeem_weight'] = this.redeemWeight;
    data['is_cancelled'] = this.isCancelled;
    data['advance_details'] = this.advanceDetails;
    return data;
  }
}

class AdvanceDetailsLedgerData {
  int? id;
  String? entryDate;
  String? entryType;
  String? transactionType;
  String? invoiceNumber;
  String? reffrenceNumber;
  double? transactionAmount;
  double? transactionWeight;
  bool? isCancelled;
  int? customerDetails;

  AdvanceDetailsLedgerData(
      {this.id,
      this.entryDate,
      this.entryType,
      this.transactionType,
      this.invoiceNumber,
      this.reffrenceNumber,
      this.transactionAmount,
      this.transactionWeight,
      this.isCancelled,
      this.customerDetails});

  AdvanceDetailsLedgerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryDate = json['entry_date'];
    entryType = json['entry_type'];
    transactionType = json['transaction_type'];
    invoiceNumber = json['invoice_number'];
    reffrenceNumber = json['reffrence_number'];
    transactionAmount = json['transaction_amount'];
    transactionWeight = json['transaction_weight'];
    isCancelled = json['is_cancelled'];
    customerDetails = json['customer_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entry_date'] = this.entryDate;
    data['entry_type'] = this.entryType;
    data['transaction_type'] = this.transactionType;
    data['invoice_number'] = this.invoiceNumber;
    data['reffrence_number'] = this.reffrenceNumber;
    data['transaction_amount'] = this.transactionAmount;
    data['transaction_weight'] = this.transactionWeight;
    data['is_cancelled'] = this.isCancelled;
    data['customer_details'] = this.customerDetails;
    return data;
  }
}
