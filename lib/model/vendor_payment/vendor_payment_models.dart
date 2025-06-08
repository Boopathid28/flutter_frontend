class FetchVendorPaymentListPayload {
  int? menuId;
  String? vendor;
  String? branch;
  String? fromDate;
  String? toDate;
  String? search;
  int? page;
  int? itemsPerPage;
  bool? status;

  FetchVendorPaymentListPayload(
      {this.menuId,
      this.vendor,
      this.branch,
      this.fromDate,
      this.toDate,
      this.search,
      this.page,
      this.itemsPerPage,
      this.status});

  FetchVendorPaymentListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    vendor = json['vendor'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['vendor'] = this.vendor;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['status'] = this.status;
    return data;
  }
}

class VendorPaymentListData {
  int? id;
  String? paymentId;
  String? paymentDate;
  double? paymentWeight;
  double? paymentAmount;
  String? remark;
  bool? isCanceled;
  int? vendorDetails;
  String? vendorDetailsName;
  String? branch;
  String? branchName;
  int? sNo;

  VendorPaymentListData(
      {this.id,
      this.paymentId,
      this.paymentDate,
      this.paymentWeight,
      this.paymentAmount,
      this.remark,
      this.isCanceled,
      this.vendorDetails,
      this.vendorDetailsName,
      this.branch,
      this.branchName,
      this.sNo});

  VendorPaymentListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    paymentDate = json['payment_date'];
    paymentWeight = json['payment_weight'];
    paymentAmount = json['payment_amount'];
    remark = json['remark'];
    isCanceled = json['is_canceled'];
    vendorDetails = json['vendor_details'];
    vendorDetailsName = json['vendor_details_name'];
    branch = json['branch'].toString();
    branchName = json['branch_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['payment_date'] = this.paymentDate;
    data['payment_weight'] = this.paymentWeight;
    data['payment_amount'] = this.paymentAmount;
    data['remark'] = this.remark;
    data['is_canceled'] = this.isCanceled;
    data['vendor_details'] = this.vendorDetails;
    data['vendor_details_name'] = this.vendorDetailsName;
    data['branch'] = this.branch;
    data['branch_name'] = this.branchName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class VendorPaymentRetrieveData {
  String? vendorName;
  String? vendorPhone;
  String? vendorAddress;
  double? totalWeight;
  double? totalAmount;
  double? discWeight;
  double? discAmount;
  double? paidWeight;
  double? paidAmount;
  double? balanceWeight;
  double? balanceAmount;
  List<LedgerList>? ledgerList;

  VendorPaymentRetrieveData(
      {this.vendorName,
      this.vendorPhone,
      this.vendorAddress,
      this.totalWeight,
      this.totalAmount,
      this.discWeight,
      this.discAmount,
      this.paidWeight,
      this.paidAmount,
      this.balanceWeight,
      this.balanceAmount,
      this.ledgerList});

  VendorPaymentRetrieveData.fromJson(Map<String, dynamic> json) {
    vendorName = json['vendor_name'];
    vendorPhone = json['vendor_phone'];
    vendorAddress = json['vendor_address'];
    totalWeight = json['total_weight'];
    totalAmount = json['total_amount'];
    discWeight = json['disc_weight'];
    discAmount = json['disc_amount'];
    paidWeight = json['paid_weight'];
    paidAmount = json['paid_amount'];
    balanceWeight = json['balance_weight'];
    balanceAmount = json['balance_amount'];
    if (json['ledger_list'] != null) {
      ledgerList = <LedgerList>[];
      json['ledger_list'].forEach((v) {
        ledgerList!.add(new LedgerList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_name'] = this.vendorName;
    data['vendor_phone'] = this.vendorPhone;
    data['vendor_address'] = this.vendorAddress;
    data['total_weight'] = this.totalWeight;
    data['total_amount'] = this.totalAmount;
    data['disc_weight'] = this.discWeight;
    data['disc_amount'] = this.discAmount;
    data['paid_weight'] = this.paidWeight;
    data['paid_amount'] = this.paidAmount;
    data['balance_weight'] = this.balanceWeight;
    data['balance_amount'] = this.balanceAmount;
    if (this.ledgerList != null) {
      data['ledger_list'] = this.ledgerList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LedgerList {
  int? id;
  String? transactionDate;
  String? refferenceNumber;
  String? transactionType;
  double? transactionWeight;
  double? transactionAmount;
  bool? isCanceled;
  int? vendorDetails;

  LedgerList(
      {this.id,
      this.transactionDate,
      this.refferenceNumber,
      this.transactionType,
      this.transactionWeight,
      this.transactionAmount,
      this.isCanceled,
      this.vendorDetails});

  LedgerList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionDate = json['transaction_date'];
    refferenceNumber = json['refference_number'];
    transactionType = json['transaction_type'];
    transactionWeight = json['transaction_weight'];
    transactionAmount = json['transaction_amount'];
    isCanceled = json['is_canceled'];
    vendorDetails = json['vendor_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_date'] = this.transactionDate;
    data['refference_number'] = this.refferenceNumber;
    data['transaction_type'] = this.transactionType;
    data['transaction_weight'] = this.transactionWeight;
    data['transaction_amount'] = this.transactionAmount;
    data['is_canceled'] = this.isCanceled;
    data['vendor_details'] = this.vendorDetails;
    return data;
  }
}

class VendorMakePaymentPayload {
  int? menuId;
  String? vendorDetails;
  double? paymentWeight;
  double? paymentAmount;
  double? openWeight;
  double? openAmount;
  String? remark;
  List<PaymentDetails>? paymentDetails;
  List<WeightDetails>? weightDetails;
  String? branch;

  VendorMakePaymentPayload(
      {this.menuId,
      this.vendorDetails,
      this.paymentWeight,
      this.paymentAmount,
      this.remark,
      this.paymentDetails,
      this.weightDetails,
      this.openWeight, 
      this.openAmount,
      this.branch});

  VendorMakePaymentPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    vendorDetails = json['vendor_details'];
    paymentWeight = json['payment_weight'];
    paymentAmount = json['payment_amount'];
    remark = json['remark'];
    branch = json['branch'];
    openWeight = json['open_weight'];
    openAmount = json['open_amount'];
    if (json['payment_details'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['payment_details'].forEach((v) {
        paymentDetails!.add(new PaymentDetails.fromJson(v));
      });
    }
    if (json['weight_details'] != null) {
      weightDetails = <WeightDetails>[];
      json['weight_details'].forEach((v) {
        weightDetails!.add(new WeightDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['vendor_details'] = this.vendorDetails;
    data['payment_weight'] = this.paymentWeight;
    data['payment_amount'] = this.paymentAmount;
    data['remark'] = this.remark;
    data['branch'] = this.branch;
    data['open_weight'] = this.openWeight;
    data['open_amount'] = this.openAmount;
    if (this.paymentDetails != null) {
      data['payment_details'] =
          this.paymentDetails!.map((v) => v.toJson()).toList();
    }
    if (this.weightDetails != null) {
      data['weight_details'] =
          this.weightDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentDetails {
  String? id;
  String? paymentMethod;
  String? paymentMethodName;
  String? paymentProviders;
  String? paymentProvidersName;
  String? remarks;
  String? refferedBy;
  double? amount;
  String? paymentType;
  double? pureWeight;
  double? metalRate;

  PaymentDetails({this.paymentMethod, this.paymentMethodName, this.refferedBy, this.paymentProviders, this.paymentType, this.pureWeight, this.metalRate, this.paymentProvidersName, this.amount, this.remarks , this.id});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['payment_method'];
    paymentMethodName = json['payment_method_name'];
    paymentProviders = json['payment_providers'];
    paymentProvidersName = json['payment_providers_name'];
    remarks = json['remarks'];
    refferedBy = json['reffered_by'];
    amount = json['amount'];
    paymentType = json['payment_type'];
    pureWeight = json['pure_weight'];
    metalRate = json['metal_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    data['payment_method_name'] = this.paymentMethodName;
    data['payment_providers'] = this.paymentProviders;
    data['payment_providers_name'] = this.paymentProvidersName;
    data['remarks'] = this.remarks;
    data['amount'] = this.amount;
    data['reffered_by'] = this.refferedBy;
    data['payment_type'] = this.paymentType;
    data['pure_weight'] = this.pureWeight;
    data['metal_rate'] = this.metalRate;
    return data;
  }
}

class WeightDetails {
  String? id;
  String? paymentType;
  double? metalWeight;
  String? metalDetails;
  double? touch;
  String? remarks;
  String? refferedBy;
  double? pureWeight;

  WeightDetails({this.metalWeight, this.remarks, this.refferedBy, this.paymentType, this.metalDetails, this.touch, this.pureWeight, this.id});

  WeightDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentType = json['payment_type'];
    remarks = json['remarks'];
    refferedBy = json['reffered_by'];
    metalWeight = json['metal_weight'];
    metalDetails = json['metal_details'];
    touch = json['touch'];
    pureWeight = json['pure_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['remarks'] = this.remarks;
    data['reffered_by'] = this.refferedBy;
    data['payment_type'] = this.paymentType;
    data['metal_weight'] = this.metalWeight;
    data['metal_details'] = this.metalDetails;
    data['touch'] = this.touch;
    data['pure_weight'] = this.pureWeight;
    return data;
  }
}
