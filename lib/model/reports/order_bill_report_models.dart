class FetchOrderBillReportListDataPayload {
  int? menuId;
  String? fromDate;
  String? customer;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchOrderBillReportListDataPayload(
      {this.menuId,
      this.fromDate,
      this.customer,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchOrderBillReportListDataPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    customer = json['customer'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['customer'] = this.customer;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}


class OrderBillReportListData {
  String? billId;
  String? customerName;
  double? weight;
  double? totalAmount;
  String? tagNo;
  String? item;
  String? advanceTotalAmount;
  String? chitTotalAmount;
  String? billingCashAmount;
  String? billingCardAmount;
  String? billingBankAmount;
  String? billingUpiAmount;
  String? oldAmount;
  String? oldWeight;
  int? sNo;

  OrderBillReportListData(
      {this.billId,
      this.customerName,
      this.weight,
      this.totalAmount,
      this.tagNo,
      this.item,
      this.advanceTotalAmount,
      this.chitTotalAmount,
      this.billingCashAmount,
      this.billingCardAmount,
      this.billingBankAmount,
      this.billingUpiAmount,
      this.oldAmount,
      this.oldWeight,
      this.sNo});

  OrderBillReportListData.fromJson(Map<String, dynamic> json) {
    billId = json['bill_id'];
    customerName = json['customer_name'];
    weight = json['weight'];
    totalAmount = json['total_amount'];
    tagNo = json['tag_no'];
    item = json['item'];
    advanceTotalAmount = json['advance_total_amount'].toString();
    chitTotalAmount = json['chit_total_amount'].toString();
    billingCashAmount = json['billing_cash_amount'].toString();
    billingCardAmount = json['billing_card_amount'].toString();
    billingBankAmount = json['billing_bank_amount'].toString();
    billingUpiAmount = json['billing_upi_amount'].toString();
    oldAmount = json['old_amount'].toString();
    oldWeight = json['old_weight'].toString();
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bill_id'] = this.billId;
    data['customer_name'] = this.customerName;
    data['weight'] = this.weight;
    data['total_amount'] = this.totalAmount;
    data['tag_no'] = this.tagNo;
    data['item'] = this.item;
    data['advance_total_amount'] = this.advanceTotalAmount;
    data['chit_total_amount'] = this.chitTotalAmount;
    data['billing_cash_amount'] = this.billingCashAmount;
    data['billing_card_amount'] = this.billingCardAmount;
    data['billing_bank_amount'] = this.billingBankAmount;
    data['billing_upi_amount'] = this.billingUpiAmount;
    data['old_amount'] = this.oldAmount;
    data['old_weight'] = this.oldWeight;
    data['s_no'] = this.sNo;
    return data;
  }
}
