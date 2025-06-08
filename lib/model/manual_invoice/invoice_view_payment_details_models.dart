class RetrievePaymentDetailListData {
  int? id;
  String? paymentId;
  String? paymentDate;
  String? createdBy;
  int? billingDetails;
  String? customerName;
  String? customerMobile;
  double? oldBalance;
  double? oldPaidAmount;
  List<DenominationDetails>? denominationDetails;
  double? denominationAmount;
  double? exchangeAmount;
  double? advanceAmount;
  double? chitAmount;
  double? suspenseAmount;
  double? paidAmount;
  double? totalAmount;

  RetrievePaymentDetailListData(
      {this.id,
      this.paymentId,
      this.paymentDate,
      this.createdBy,
      this.billingDetails,
      this.customerName, 
      this.customerMobile,
      this.oldBalance,
      this.oldPaidAmount,
      this.denominationDetails,
      this.denominationAmount,
      this.exchangeAmount,
      this.advanceAmount,
      this.chitAmount,
      this.suspenseAmount,
      this.paidAmount,
      this.totalAmount});

  RetrievePaymentDetailListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    paymentDate = json['payment_date'];
    createdBy = json['created_by'];
    billingDetails = json['billing_details'];
    customerName = json['customer_name'];
    customerMobile = json['customer_mobile'];
    oldBalance = json['old_balance'];
    oldPaidAmount = json['old_paid_amount'];
    if (json['denomination_details'] != null) {
      denominationDetails = <DenominationDetails>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new DenominationDetails.fromJson(v));
      });
    }
    denominationAmount = json['denomination_amount'];
    exchangeAmount = json['exchange_amount'];
    advanceAmount = json['advance_amount'];
    chitAmount = json['chit_amount'];
    suspenseAmount = json['suspense_amount'];
    paidAmount = json['paid_amount'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['payment_date'] = this.paymentDate;
    data['created_by'] = this.createdBy;
    data['billing_details'] = this.billingDetails;
    data['customer_name'] = this.customerName;
    data['customer_mobile'] = this.customerMobile;
    data['old_balance'] = this.oldBalance;
    data['old_paid_amount'] = this.oldPaidAmount;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    data['denomination_amount'] = this.denominationAmount;
    data['exchange_amount'] = this.exchangeAmount;
    data['advance_amount'] = this.advanceAmount;
    data['chit_amount'] = this.chitAmount;
    data['suspense_amount'] = this.suspenseAmount;
    data['paid_amount'] = this.paidAmount;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class DenominationDetails {
  int? id;
  String? paymentMethod;
  String? paymentProvider;
  double? paidAmount;
  String? remarks;
  int? paymentDetails;

  DenominationDetails(
      {this.id,
      this.paymentMethod,
      this.paymentProvider,
      this.paidAmount,
      this.remarks,
      this.paymentDetails});

  DenominationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['payment_method'];
    paymentProvider = json['payment_provider'];
    paidAmount = json['paid_amount'];
    remarks = json['remarks'];
    paymentDetails = json['payment_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    data['payment_provider'] = this.paymentProvider;
    data['paid_amount'] = this.paidAmount;
    data['remarks'] = this.remarks;
    data['payment_details'] = this.paymentDetails;
    return data;
  }
}
