class FetchSuspenseListPayload {
  int? menuId;
  String? customerDetails;
  String? fromDate;
  String? toDate;
  bool? redeemeStatus;
  bool? cancelStatus;
  String? search;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchSuspenseListPayload(
      {this.menuId,
      this.customerDetails,
      this.fromDate,
      this.toDate,
      this.redeemeStatus,
      this.cancelStatus,
      this.search,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchSuspenseListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    customerDetails = json['customer_details'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    redeemeStatus = json['redeeme_status'];
    cancelStatus = json['cancel_status'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['customer_details'] = this.customerDetails;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['redeeme_status'] = this.redeemeStatus;
    data['cancel_status'] = this.cancelStatus;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}

class SuspenseListData {
  int? id;
  String? suspenseId;
  bool? isRedeemed;
  String? billNumber;
  bool? isCancelled;
  bool? isClosed;
  String? closedDate;
  String? createdAt;
  String? createdBy;
  String? branchName;
  int? customerDetails;
  int? branch;
  String? customerDetailsName;
  String? totalAmount;
  String? totalPayment;
  String? reaminingAmount;
  int? sNo;

  SuspenseListData(
      {this.id,
      this.suspenseId,
      this.isRedeemed,
      this.billNumber,
      this.isCancelled,
      this.isClosed, 
      this.closedDate,
      this.createdAt,
      this.createdBy,
      this.branchName,
      this.customerDetails,
      this.branch,
      this.customerDetailsName,
      this.totalAmount,
      this.totalPayment,
      this.reaminingAmount,
      this.sNo});

  SuspenseListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    suspenseId = json['suspense_id'];
    isRedeemed = json['is_redeemed'];
    billNumber = json['bill_number'];
    isCancelled = json['is_cancelled'];
    isClosed = json['is_closed'];
    closedDate = json['closed_date'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    customerDetailsName = json['customer_details_name'];
    totalAmount = json['total_amount'].toString();
    totalPayment = json['total_payment'].toString();
    reaminingAmount = json['reamining_amount'].toString();
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['suspense_id'] = this.suspenseId;
    data['is_redeemed'] = this.isRedeemed;
    data['bill_number'] = this.billNumber;
    data['is_cancelled'] = this.isCancelled;
    data['is_closed'] = this.isClosed;
    data['closed_date'] = this.closedDate;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    data['customer_details_name'] = this.customerDetailsName;
    data['total_amount'] = this.totalAmount;
    data['total_payment'] = this.totalPayment;
    data['reamining_amount'] = this.reaminingAmount;
    data['s_no'] = this.sNo;
    return data;
  }
}

class CreateSuspensePayload {
  int? menuId;
  String? customerDetails;
  String? branch;
  List<ItemDetails>? itemDetails;

  CreateSuspensePayload(
      {this.menuId, this.customerDetails, this.branch, this.itemDetails});

  CreateSuspensePayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    if (json['item_details'] != null) {
      itemDetails = <ItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new ItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemDetails {
  late String sNo;
  int? metalDetails;
  String? metalName;
  String? itemDetails;
  String? itemDetailsName;
  String? subItemDetails;
  String? subItemDetailsName;
  int? metalWeight;
  int? metalAmount;
  double? totalAmount;

  ItemDetails(
      {required this.sNo,
      this.metalDetails,
      this.metalName,
      this.itemDetails,
      this.itemDetailsName,
      this.subItemDetails,
      this.subItemDetailsName,
      this.metalWeight,
      this.metalAmount,
      this.totalAmount});

  ItemDetails.fromJson(Map<String, dynamic> json) {
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

class CreateSuspenseResponse {
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

  CreateSuspenseResponse(
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

  CreateSuspenseResponse.fromJson(Map<String, dynamic> json) {
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




class CreateSuspensePaymentPayload {
  int? menuId;
  int? id;
  String? branch;
  List<DenominationDetails>? denominationDetails;

  CreateSuspensePaymentPayload(
      {this.menuId, this.id, this.branch, this.denominationDetails});

  CreateSuspensePaymentPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
    branch = json['branch'];
    if (json['denomination_details'] != null) {
      denominationDetails = <DenominationDetails>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new DenominationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    data['branch'] = this.branch;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DenominationDetails {
  late String sNo;
  String? paymentMethod;
  String? paymentProvider;
  double? paidAmount;

  DenominationDetails(
      {this.paymentMethod, this.paymentProvider, this.paidAmount,required this.sNo,});

  DenominationDetails.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    paymentMethod = json['payment_method'];
    paymentProvider = json['payment_provider'];
    paidAmount = json['paid_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
     data['s_no'] = this.sNo;
    data['payment_method'] = this.paymentMethod;
    data['payment_provider'] = this.paymentProvider;
    data['paid_amount'] = this.paidAmount;
    return data;
  }
}



class CreateSuspensePaymentResponse {
  int? id;
  String? paymentId;
  String? paymentDate;
  String? createdBy;
  String? branchName;
  int? suspenseDetails;
  int? branch;

  CreateSuspensePaymentResponse(
      {this.id,
      this.paymentId,
      this.paymentDate,
      this.createdBy,
      this.branchName,
      this.suspenseDetails,
      this.branch});

  CreateSuspensePaymentResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    paymentDate = json['payment_date'];
    createdBy = json['created_by'];
    branchName = json['branch_name'];
    suspenseDetails = json['suspense_details'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['payment_date'] = this.paymentDate;
    data['created_by'] = this.createdBy;
    data['branch_name'] = this.branchName;
    data['suspense_details'] = this.suspenseDetails;
    data['branch'] = this.branch;
    return data;
  }
}




class SuspenseDetailsData {
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
  List<SuspenseItemDetails>? itemDetails;
  double? totalPaidAmount;
  List<PaymentDetails>? paymentDetails;
  double? remainingAmount;

  SuspenseDetailsData(
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
      this.itemDetails,
      this.totalPaidAmount,
      this.paymentDetails,
      this.remainingAmount});

  SuspenseDetailsData.fromJson(Map<String, dynamic> json) {
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
    if (json['item_details'] != null) {
      itemDetails = <SuspenseItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new SuspenseItemDetails.fromJson(v));
      });
    }
    totalPaidAmount = json['total_paid_amount'];
    if (json['payment_details'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['payment_details'].forEach((v) {
        paymentDetails!.add(new PaymentDetails.fromJson(v));
      });
    }
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
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    data['total_paid_amount'] = this.totalPaidAmount;
    if (this.paymentDetails != null) {
      data['payment_details'] =
          this.paymentDetails!.map((v) => v.toJson()).toList();
    }
    data['remaining_amount'] = this.remainingAmount;
    return data;
  }
}

class SuspenseItemDetails {
  int? id;
  double? metalWeight;
  double? metalAmount;
  double? totalAmount;
  int? suspenseDetails;
  int? metalDetails;
  int? itemDetails;
  int? subItemDetails;
  String? metalDetailsName;
  String? itemDetailsName;
  String? subItemDetailsName;

  SuspenseItemDetails(
      {this.id,
      this.metalWeight,
      this.metalAmount,
      this.totalAmount,
      this.suspenseDetails,
      this.metalDetails,
      this.itemDetails,
      this.subItemDetails,
      this.metalDetailsName,
      this.itemDetailsName,
      this.subItemDetailsName});

  SuspenseItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metalWeight = json['metal_weight'];
    metalAmount = json['metal_amount'];
    totalAmount = json['total_amount'];
    suspenseDetails = json['suspense_details'];
    metalDetails = json['metal_details'];
    itemDetails = json['item_details'];
    subItemDetails = json['sub_item_details'];
    metalDetailsName = json['metal_details_name'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal_weight'] = this.metalWeight;
    data['metal_amount'] = this.metalAmount;
    data['total_amount'] = this.totalAmount;
    data['suspense_details'] = this.suspenseDetails;
    data['metal_details'] = this.metalDetails;
    data['item_details'] = this.itemDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['metal_details_name'] = this.metalDetailsName;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    return data;
  }
}

class PaymentDetails {
  int? id;
  String? paymentId;
  String? paymentDate;
  String? createdBy;
  int? suspenseDetails;
  double? paidAmount;
  List<SuspenseDenominationDetails>? denominationDetails;

  PaymentDetails(
      {this.id,
      this.paymentId,
      this.paymentDate,
      this.createdBy,
      this.suspenseDetails,
      this.paidAmount,
      this.denominationDetails});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    paymentDate = json['payment_date'];
    createdBy = json['created_by'];
    suspenseDetails = json['suspense_details'];
    paidAmount = json['paid_amount'];
    if (json['denomination_details'] != null) {
      denominationDetails = <SuspenseDenominationDetails>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new SuspenseDenominationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['payment_date'] = this.paymentDate;
    data['created_by'] = this.createdBy;
    data['suspense_details'] = this.suspenseDetails;
    data['paid_amount'] = this.paidAmount;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SuspenseDenominationDetails {
  int? id;
  String? paymentMethod;
  String? paymentProvider;
  double? paidAmount;
  String? remark;
  int? paymentDetails;

  SuspenseDenominationDetails(
      {this.id,
      this.paymentMethod,
      this.paymentProvider,
      this.paidAmount,
      this.remark,
      this.paymentDetails});

  SuspenseDenominationDetails.fromJson(Map<String, dynamic> json) {
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
