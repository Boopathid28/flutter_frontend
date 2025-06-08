class FetchDailyReportListPayload {
  int? menuId;
  int? page;
  int? itemsPerPage;
  String? fromDate;

  FetchDailyReportListPayload(
      {this.menuId, this.page, this.itemsPerPage, this.fromDate});

  FetchDailyReportListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    fromDate = json['from_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['from_date'] = this.fromDate;
    return data;
  }
}



class DailyReportListData {
  String? refernceId;
  String? customerVendorName;
  String? amount;
  String? tagNumber;
  String? purityName;
  String? metalName;
  String? grossWeight;
  String? netWeight;
  String? pieces;
  String? itemName;
  String? subItemName;
  String? diamondAmount;
  String? stoneAmount;
  String? reduceWeight;
  String? type;
  String? exchangeAmount;
  String? totalAdvanceAmount;
  String? totalAdvanceWeight;
  String? totalChitAmount;
  String? totalChitWeight;
  String? totalOldGoldAmount;
  String? totalOldGoldWeight;
  String? vendorCharges;
  String? pureWeight;
  String? paymentReffrenceNumber;
  String? cashAmount;
  String? cardAmount;
  String? bankAmount;
  String? upiAmount;
  String? vendorcharges;
  String? expanceType;
  String? suspenseweight;
  String? suspenseAmount;
  String? makingCharge;
  String? wastagePercent;

  DailyReportListData(
      {this.refernceId,
      this.customerVendorName,
      this.amount,
      this.tagNumber,
      this.purityName,
      this.metalName,
      this.grossWeight,
      this.netWeight,
      this.pieces,
      this.itemName,
      this.subItemName,
      this.diamondAmount,
      this.stoneAmount,
      this.reduceWeight,
      this.type,
      this.exchangeAmount,
      this.totalAdvanceAmount,
      this.totalAdvanceWeight,
      this.totalChitAmount,
      this.totalChitWeight,
      this.totalOldGoldAmount,
      this.totalOldGoldWeight,
      this.vendorCharges,
      this.pureWeight,
      this.paymentReffrenceNumber,
      this.cashAmount,
      this.cardAmount,
      this.bankAmount,
      this.vendorcharges,
      this.expanceType,
      this.suspenseweight,
      this.suspenseAmount,
      this.makingCharge,
      this.wastagePercent,
      this.upiAmount});

  DailyReportListData.fromJson(Map<String, dynamic> json) {
    refernceId = json['refernce_id'];
    customerVendorName = json['customer_vendor_name'];
    amount = json['amount'].toString();
    tagNumber = json['tag_number'];
    purityName = json['purity_name'];
    metalName = json['metal_name'];
    grossWeight = json['gross_weight'].toString();
    netWeight = json['net_weight'].toString();
    pieces = json['pieces'].toString();
    itemName = json['item_name'];
    subItemName = json['sub_item_name'];
    diamondAmount = json['diamond_amount'].toString();
    stoneAmount = json['stone_amount'].toString();
    reduceWeight = json['reduce_weight'].toString();
    type = json['type'];
    exchangeAmount = json['exchange_amount'].toString();
    totalAdvanceAmount = json['total_advance_amount'].toString();
    totalAdvanceWeight = json['total_advance_weight'].toString();
    totalChitAmount = json['total_chit_amount'].toString();
    totalChitWeight = json['total_chit_weight'].toString();
    totalOldGoldAmount = json['total_old_gold_amount'].toString();
    totalOldGoldWeight = json['total_old_gold_weight'].toString();
    vendorCharges = json['vendor_charges'].toString();
    pureWeight = json['pure_weight'].toString();
    paymentReffrenceNumber = json['payment_reffrence_number'];
    cashAmount = json['cash_amount'].toString();
    cardAmount = json['card_amount'].toString();
    bankAmount = json['bank_amount'].toString();
    upiAmount = json['upi_amount'].toString();
    vendorcharges = json['vendor_charges'].toString();
    expanceType = json['expense_type'].toString();
    suspenseAmount = json['total_suspense_amount'].toString();
    suspenseweight = json['total_suspense_weight'].toString();
    makingCharge = json['making_charge'].toString();
    wastagePercent = json['wastage_percent'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refernce_id'] = this.refernceId;
    data['customer_vendor_name'] = this.customerVendorName;
    data['amount'] = this.amount;
    data['tag_number'] = this.tagNumber;
    data['purity_name'] = this.purityName;
    data['metal_name'] = this.metalName;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['pieces'] = this.pieces;
    data['item_name'] = this.itemName;
    data['sub_item_name'] = this.subItemName;
    data['diamond_amount'] = this.diamondAmount;
    data['stone_amount'] = this.stoneAmount;
    data['reduce_weight'] = this.reduceWeight;
    data['type'] = this.type;
    data['exchange_amount'] = this.exchangeAmount;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['total_advance_weight'] = this.totalAdvanceWeight;
    data['total_chit_amount'] = this.totalChitAmount;
    data['total_chit_weight'] = this.totalChitWeight;
    data['total_old_gold_amount'] = this.totalOldGoldAmount;
    data['total_old_gold_weight'] = this.totalOldGoldWeight;
    data['vendor_charges'] = this.vendorCharges;
    data['pure_weight'] = this.pureWeight;
    data['payment_reffrence_number'] = this.paymentReffrenceNumber;
    data['cash_amount'] = this.cashAmount;
    data['card_amount'] = this.cardAmount;
    data['bank_amount'] = this.bankAmount;
    data['upi_amount'] = this.upiAmount;
    data['vendor_charges'] = this.vendorcharges;
    data['expense_type'] = this.expanceType;
    data['total_suspense_amount'] = this.suspenseAmount;
    data['total_suspense_weight'] = this.suspenseweight;
    data['making_charge'] = this.makingCharge;
    data['wastage_percent'] = this.wastagePercent;
    return data;
  }
}
