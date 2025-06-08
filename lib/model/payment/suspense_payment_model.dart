class SuspensePaymentItemModel {
  String? id;
  String? metalDetails;
  String? metalName;
  String? itemDetails;
  String? itemDetailsName;
  String? subItemDetails;
  String? subItemDetailsName;
  double? metalWeight;
  double? metalAmount;
  double? totalAmount;

  SuspensePaymentItemModel(
      {this.id,
      this.metalDetails,
      this.metalName,
      this.itemDetails,
      this.itemDetailsName,
      this.subItemDetails,
      this.subItemDetailsName,
      this.metalWeight,
      this.metalAmount,
      this.totalAmount});

  SuspensePaymentItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = this.id;
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


class SuspensePaymentCreatePayloadModel {
  int? menuId;
  String? customerDetails;
  String? branch;
  List<SuspensePaymentItemModel>? itemDetails;

  SuspensePaymentCreatePayloadModel(
      {this.menuId, this.customerDetails, this.branch, this.itemDetails});

  SuspensePaymentCreatePayloadModel.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    if (json['item_details'] != null) {
      itemDetails = <SuspensePaymentItemModel>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new SuspensePaymentItemModel.fromJson(v));
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

class CreateSuspensePaymentResponse {
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

  CreateSuspensePaymentResponse(
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

  CreateSuspensePaymentResponse.fromJson(Map<String, dynamic> json) {
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

class SuspenseRetrieveDetails {
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

  SuspenseRetrieveDetails(
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

  SuspenseRetrieveDetails.fromJson(Map<String, dynamic> json) {
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


class SuspenseFetchParticularsDetails {
  String? id;
  String? suspenseId;
  String? totalAmount;

  SuspenseFetchParticularsDetails(
      {this.id, this.suspenseId, this.totalAmount});

  SuspenseFetchParticularsDetails.fromJson(Map<String, dynamic> json) {
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