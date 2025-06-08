class FetchAllMetalDailySaleReportListPayload {
  String? fromDate;
  String? toDate;
  int? page;
  int? itemsPerPage;
  int? menuId;

  FetchAllMetalDailySaleReportListPayload(
      {this.fromDate, this.toDate, this.page, this.itemsPerPage, this.menuId});

  FetchAllMetalDailySaleReportListPayload.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    toDate = json['to_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    return data;
  }
}

class AllMetalDailySaleReportListData {
  String? billNo;
  String? billDate;
  String? customer;
  String? tag;
  String? metalName;
  String? purityName;
  String? itemName;
  String? subItemName;
  String? pc;
  String? wt;
  String? total;
  String? gst;
  String? discountAmount;
  String? roundoffAmount;
  String? sales;
  String? oldWeight;
  String? oldAmount;
  String? cashAmount;
  String? cardAmount;
  String? bankAmount;
  String? phonePay;
  String? advanceAmount;
  String? chitAmount;
  String? suspenseAmount;
  String? totalPaid;
  String? excess;
  String? balance;
  String? Check;

  AllMetalDailySaleReportListData(
      {this.billNo,
      this.billDate,
      this.customer,
      this.tag,
      this.metalName,
      this.purityName,
      this.itemName,
      this.subItemName,
      this.pc,
      this.wt,
      this.total,
      this.gst,
      this.discountAmount,
      this.roundoffAmount,
      this.sales,
      this.oldWeight,
      this.oldAmount,
      this.cashAmount,
      this.cardAmount,
      this.bankAmount,
      this.phonePay,
      this.advanceAmount,
      this.chitAmount,
      this.suspenseAmount,
      this.totalPaid,
      this.excess,
      this.Check,
      this.balance});

  AllMetalDailySaleReportListData.fromJson(Map<String, dynamic> json) {
    billNo = json['bill_no'];
    billDate = json['bill_date'];
    customer = json['customer'];
    tag = json['tag'];
    metalName = json['metal_name'];
    purityName = json['purity_name'];
    itemName = json['item_name'];
    subItemName = json['sub_item_name'];
    pc = json['pc'].toString();
    wt = json['wt'].toString();
    total = json['total'].toString();
    gst = json['gst'].toString();
    discountAmount = json['discount_amount'].toString();
    roundoffAmount = json['roundoff_amount'].toString();
    sales = json['sales'].toString();
    oldWeight = json['old_weight'].toString();
    oldAmount = json['old_amount'].toString();
    cashAmount = json['cash_amount'].toString();
    cardAmount = json['card_amount'].toString();
    bankAmount = json['bank_amount'].toString();
    phonePay = json['phone_pay'].toString();
    advanceAmount = json['advance_amount'].toString();
    chitAmount = json['chit_amount'].toString();
    suspenseAmount = json['suspense_amount'].toString();
    totalPaid = json['total_paid'].toString();
    excess = json['excess'].toString();
    balance = json['balance'].toString();
    Check = json['cheque_amount'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bill_no'] = this.billNo;
    data['bill_date'] = this.billDate;
    data['customer'] = this.customer;
    data['tag'] = this.tag;
    data['metal_name'] = this.metalName;
    data['purity_name'] = this.purityName;
    data['item_name'] = this.itemName;
    data['sub_item_name'] = this.subItemName;
    data['pc'] = this.pc;
    data['wt'] = this.wt;
    data['total'] = this.total;
    data['gst'] = this.gst;
    data['discount_amount'] = this.discountAmount;
    data['roundoff_amount'] = this.roundoffAmount;
    data['sales'] = this.sales;
    data['old_weight'] = this.oldWeight;
    data['old_amount'] = this.oldAmount;
    data['cash_amount'] = this.cashAmount;
    data['card_amount'] = this.cardAmount;
    data['bank_amount'] = this.bankAmount;
    data['phone_pay'] = this.phonePay;
    data['advance_amount'] = this.advanceAmount;
    data['chit_amount'] = this.chitAmount;
    data['suspense_amount'] = this.suspenseAmount;
    data['total_paid'] = this.totalPaid;
    data['excess'] = this.excess;
    data['balance'] = this.balance;
    data['cheque_amount'] = this.Check;
    return data;
  }
}
