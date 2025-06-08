class ChitSchemeListData {
  int? id;
  String? customerName;
  String? mobile;
  String? idMetal;
  String? schemeType;
  String? idPurity;
  String? accountName;
  String? schemeName;
  String? schemeAccNumber;
  String? classificationName;
  String? maturityDate;
  String? startDate;
  String? schemetypeName;
  String? totalInstallments;
  String? wastagebenefit;
  String? makingcharge;
  String? benefitBonus;
  String? amount;
  String? totalPaidAmount;
  String? totalMetalweight;
  String? entryType;
  String? statusName;
  String? status;
  String? branchName;
  String? noofGift;
  String? giftAmount;
  String? createdThrough;

  ChitSchemeListData(
      {this.id,
      this.customerName,
      this.mobile,
      this.idMetal,
      this.schemeType,
      this.idPurity,
      this.accountName,
      this.schemeName,
      this.schemeAccNumber,
      this.classificationName,
      this.maturityDate,
      this.startDate,
      this.schemetypeName,
      this.totalInstallments,
      this.wastagebenefit,
      this.makingcharge,
      this.benefitBonus,
      this.amount,
      this.totalPaidAmount,
      this.totalMetalweight,
      this.entryType,
      this.statusName,
      this.status,
      this.branchName,
      this.noofGift,
      this.giftAmount,
      this.createdThrough});

  ChitSchemeListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerName = json['customer_name'];
    mobile = json['mobile'];
    idMetal = json['id_metal'];
    schemeType = json['scheme_type'];
    idPurity = json['id_purity'];
    accountName = json['account_name'];
    schemeName = json['scheme_name'];
    schemeAccNumber = json['scheme_acc_number'];
    classificationName = json['classification_name'];
    maturityDate = json['maturity_date'];
    startDate = json['start_date'];
    schemetypeName = json['schemetype_name'];
    totalInstallments = json['total_installments'];
    wastagebenefit = json['wastagebenefit'];
    makingcharge = json['makingcharge'];
    benefitBonus = json['benefit_bonus'];
    amount = json['amount'];
    totalPaidAmount = json['total_paid_amount'].toString();
    totalMetalweight = json['total_metalweight'];
    entryType = json['entry_type'];
    statusName = json['status_name'];
    status = json['status'];
    branchName = json['branch_name'];
    noofGift = json['noof_gift'];
    giftAmount = json['gift_amount'];
    createdThrough = json['created_through'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_name'] = this.customerName;
    data['mobile'] = this.mobile;
    data['id_metal'] = this.idMetal;
    data['scheme_type'] = this.schemeType;
    data['id_purity'] = this.idPurity;
    data['account_name'] = this.accountName;
    data['scheme_name'] = this.schemeName;
    data['scheme_acc_number'] = this.schemeAccNumber;
    data['classification_name'] = this.classificationName;
    data['maturity_date'] = this.maturityDate;
    data['start_date'] = this.startDate;
    data['schemetype_name'] = this.schemetypeName;
    data['total_installments'] = this.totalInstallments;
    data['wastagebenefit'] = this.wastagebenefit;
    data['makingcharge'] = this.makingcharge;
    data['benefit_bonus'] = this.benefitBonus;
    data['amount'] = this.amount;
    data['total_paid_amount'] = this.totalPaidAmount;
    data['total_metalweight'] = this.totalMetalweight;
    data['entry_type'] = this.entryType;
    data['status_name'] = this.statusName;
    data['status'] = this.status;
    data['branch_name'] = this.branchName;
    data['noof_gift'] = this.noofGift;
    data['gift_amount'] = this.giftAmount;
    data['created_through'] = this.createdThrough;
    return data;
  }
}

class ChitPaymentDetails {
  double? totalAmount;
  double? benefitAmount;
  double? schemeWeight;
  double? balanceWeight;
  List<ChitPaymentDenominationParticulars>? denominationDetails;

  ChitPaymentDetails({this.totalAmount, this.denominationDetails, this.benefitAmount, this.schemeWeight, this.balanceWeight});

  ChitPaymentDetails.fromJson(Map<String, dynamic> json) {
    totalAmount = json['total_amount'];
    benefitAmount = json['benefit_amount'];
    schemeWeight = json['scheme_weight'];
    balanceWeight = json['balance_weight'];
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
    data['benefit_amount'] = this.benefitAmount;
    data['scheme_weight'] = this.schemeWeight;
    data['balance_weight'] = this.balanceWeight;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChitPaymentDenominationParticulars {
  String? schemeAccountNumber;
  double? schemeWeight;
  String? schemeType;
  double? schemeAmount;
  double? bonusAmount;

  ChitPaymentDenominationParticulars(
      {this.schemeAccountNumber,
      this.schemeWeight,
      this.schemeType,
      this.schemeAmount,
      this.bonusAmount,});

  ChitPaymentDenominationParticulars.fromJson(Map<String, dynamic> json) {
    schemeAccountNumber = json['scheme_account_number'];
    schemeWeight = json['scheme_weight'];
    schemeType = json['scheme_type'];
    schemeAmount = json['scheme_amount'];
    bonusAmount = json['bonus_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['scheme_account_number'] = this.schemeAccountNumber;
    data['scheme_weight'] = this.schemeWeight;
    data['scheme_type'] = this.schemeType;
    data['scheme_amount'] = this.schemeAmount;
    data['bonus_amount'] = this.bonusAmount;
    return data;
  }
}
