class FetchBillRepaymentReportListPayload {
  String? fromDate;
  int? page;
  int? itemsPerPage;
  int? menuId;

  FetchBillRepaymentReportListPayload(
      {this.fromDate, this.page, this.itemsPerPage, this.menuId});

  FetchBillRepaymentReportListPayload.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    return data;
  }
}




class BillRepaymentReportListData {
  String? sNo;
  String? bill;
  String? paymentDate;
  String? customer;
  String? mobile;
  String? received;
  String? ogWeight;
  String? ogAmount;
  String? cash;
  String? card;
  String? bank;
  String? upi;
  String? cheque;
  String? advance;
  String? chit;
  String? suspense;

  BillRepaymentReportListData(
      {this.bill,
      this.sNo,
      this.paymentDate,
      this.customer,
      this.mobile,
      this.received,
      this.ogWeight,
      this.ogAmount,
      this.cash,
      this.card,
      this.bank,
      this.upi,
      this.cheque,
      this.advance,
      this.chit,
      this.suspense});

  BillRepaymentReportListData.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'].toString();
    bill = json['bill'];
    paymentDate = json['payment_date'];
    customer = json['customer'];
    mobile = json['mobile'];
    received = json['received'].toString();
    ogWeight = json['og_weight'].toString();
    ogAmount = json['og_amount'].toString();
    cash = json['cash'].toString();
    card = json['card'].toString();
    bank = json['bank'].toString();
    upi = json['upi'].toString();
    cheque = json['cheque'].toString();
    advance = json['advance'].toString();
    chit = json['chit'].toString();
    suspense = json['suspense'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['bill'] = this.bill;
    data['payment_date'] = this.paymentDate;
    data['customer'] = this.customer;
    data['mobile'] = this.mobile;
    data['received'] = this.received;
    data['og_weight'] = this.ogWeight;
    data['og_amount'] = this.ogAmount;
    data['cash'] = this.cash;
    data['card'] = this.card;
    data['bank'] = this.bank;
    data['upi'] = this.upi;
    data['cheque'] = this.cheque;
    data['advance'] = this.advance;
    data['chit'] = this.chit;
    data['suspense'] = this.suspense;
    return data;
  }
}
