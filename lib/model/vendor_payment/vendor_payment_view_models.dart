class VendorPaymentListDataDetailsResponse {
  int? id;
  String? paymentId;
  String? paymentDate;
  double? paymentWeight;
  double? paymentAmount;
  double? openWeight;
  double? openAmount;
  String? remark;
  bool? isCanceled;
  int? vendorDetails;
  String? vendorDetailsName;
  List<PaymentDetails>? paymentDetails;
  List<WeightDetails>? weightDetails;

  VendorPaymentListDataDetailsResponse(
      {this.id,
      this.paymentId,
      this.paymentDate,
      this.paymentWeight,
      this.paymentAmount,
      this.remark,
      this.openWeight, this.openAmount,
      this.isCanceled,
      this.vendorDetails,
      this.vendorDetailsName,
      this.paymentDetails,
      this.weightDetails});

  VendorPaymentListDataDetailsResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentId = json['payment_id'];
    paymentDate = json['payment_date'];
    paymentWeight = json['payment_weight'];
    paymentAmount = json['payment_amount'];
    remark = json['remark'];
    openWeight = json['open_weight'];
    openAmount = json['open_amount'];
    isCanceled = json['is_canceled'];
    vendorDetails = json['vendor_details'];
    vendorDetailsName = json['vendor_details_name'];
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
    data['id'] = this.id;
    data['payment_id'] = this.paymentId;
    data['payment_date'] = this.paymentDate;
    data['payment_weight'] = this.paymentWeight;
    data['payment_amount'] = this.paymentAmount;
    data['remark'] = this.remark;
    data['open_weight'] = this.openWeight;
    data['open_amount'] = this.openAmount;
    data['is_canceled'] = this.isCanceled;
    data['vendor_details'] = this.vendorDetails;
    data['vendor_details_name'] = this.vendorDetailsName;
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
  int? id;
  String? paymentMethod;
  String? paymentProviders;
  double? amount;
  int? paymentDetails;
  String? remarks;
  String? refferedBy;
  double? pureWeight;
  double? metalRate;

  PaymentDetails(
      {this.id,
      this.paymentMethod,
      this.paymentProviders,
      this.amount,
      this.pureWeight, this.metalRate, 
      this.remarks, this.refferedBy,
      this.paymentDetails});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['payment_method'];
    paymentProviders = json['payment_providers'];
    amount = json['amount'];
    paymentDetails = json['payment_details'];
    remarks = json['remarks'];
    refferedBy = json['reffered_by'];
    pureWeight = json['pure_weight'];
    metalRate = json['metal_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    data['payment_providers'] = this.paymentProviders;
    data['amount'] = this.amount;
    data['payment_details'] = this.paymentDetails;
    data['remarks'] = this.remarks;
    data['reffered_by'] = this.refferedBy;
    data['pure_weight'] = this.pureWeight;
    data['metal_rate'] = this.metalRate;
    return data;
  }
}

class WeightDetails {
  int? id;
  double? metalWeight;
  double? touch;
  double? pureWeight;
  int? paymentDetails;
  String? remarks;
  String? refferedBy;

  WeightDetails(
      {this.id,
      this.metalWeight,
      this.touch,
      this.pureWeight,
      this.remarks, this.refferedBy,
      this.paymentDetails});

  WeightDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metalWeight = json['metal_weight'];
    touch = json['touch'];
    pureWeight = json['pure_weight'];
    paymentDetails = json['payment_details'];
    remarks = json['remarks'];
    refferedBy = json['reffered_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal_weight'] = this.metalWeight;
    data['touch'] = this.touch;
    data['pure_weight'] = this.pureWeight;
    data['payment_details'] = this.paymentDetails;
    data['remarks'] = this.remarks;
    data['reffered_by'] = this.refferedBy;
    return data;
  }
}
