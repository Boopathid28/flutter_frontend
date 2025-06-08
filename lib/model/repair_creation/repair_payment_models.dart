import 'package:ausales_application/model/payment/advance_payment_model.dart';
import 'package:ausales_application/model/payment/denomination_payment_model.dart';

class FetchRepairPaymentPayload {
  String? id;
  int? menuId;
  String? branch;
  List<PaymentDenominationItemModel>? paymentDenominationDetails;
  List<AdvancePaymentItemModel>? advanceDetails;

  FetchRepairPaymentPayload(
      {this.id,
      this.menuId,
      this.branch,
      this.paymentDenominationDetails,
      this.advanceDetails});

  FetchRepairPaymentPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    branch = json['branch'];
    if (json['payment_denomination_details'] != null) {
      paymentDenominationDetails = <PaymentDenominationItemModel>[];
      json['payment_denomination_details'].forEach((v) {
        paymentDenominationDetails!
            .add(new PaymentDenominationItemModel.fromJson(v));
      });
    }
    if (json['advance_details'] != null) {
      advanceDetails = <AdvancePaymentItemModel>[];
      json['advance_details'].forEach((v) {
        advanceDetails!.add(new AdvancePaymentItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    if (this.paymentDenominationDetails != null) {
      data['payment_denomination_details'] =
          this.paymentDenominationDetails!.map((v) => v.toJson()).toList();
    }
    if (this.advanceDetails != null) {
      data['advance_details'] =
          this.advanceDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
