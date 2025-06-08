class PaymentDenominationItemModel {
  String? id;
  String? paymentMethod;
  String? paymentMethodName;
  String? paymentProviderName;
  String? paymentProvider;
  String? remarks;
  double? paidAmount;

  PaymentDenominationItemModel(
      {this.id,
      this.paymentMethod,
      this.paymentMethodName,
      this.paymentProviderName,
      this.paymentProvider,
      this.remarks,
      this.paidAmount});

  PaymentDenominationItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['payment_method'];
    paymentMethodName = json['payment_method_name'];
    paymentProviderName = json['payment_provider_name'];
    paymentProvider = json['payment_provider'];
    remarks = json['remarks'];
    paidAmount = json['paid_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    data['payment_method_name'] = this.paymentMethodName;
    data['payment_provider_name'] = this.paymentProviderName;
    data['payment_provider'] = this.paymentProvider;
    data['remarks'] = this.remarks;
    data['paid_amount'] = this.paidAmount;
    return data;
  }
}
