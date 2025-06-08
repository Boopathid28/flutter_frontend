class AdvancePaymentItemModel {
  int? advanceDetails;
  String? advanceDetailsNo;
  double? redeemWeight;
  double? redeemMetalRate;
  double? redeemMetalValue;
  double? redeemAmount;
  double? totalAmount;

  AdvancePaymentItemModel(
      {this.advanceDetails,
      this.advanceDetailsNo,
      this.redeemWeight,
      this.redeemMetalRate,
      this.redeemMetalValue,
      this.redeemAmount,
      this.totalAmount});

  AdvancePaymentItemModel.fromJson(Map<String, dynamic> json) {
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
