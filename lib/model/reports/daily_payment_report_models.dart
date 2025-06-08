class DailyPaymentReportPayload {
  int? menuId;
  String? fromDate;
  int? page;
  int? itemsPerPage;

  DailyPaymentReportPayload(
      {this.menuId, this.fromDate, this.page, this.itemsPerPage});

  DailyPaymentReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class DailyPaymentReportListData {
  String? reffrenceInvoiceNumber;
  String? paymentReffrenceNumber;
  String? transactionModule;
  String? transactionType;
  String? transactionDate;
  String? customerVendor;
  double? cashAmount;
  double? cardAmount;
  double? bankAmount;
  double? upiAmount;
  double? totalAmount;
  int? sNo;

  DailyPaymentReportListData(
      {this.reffrenceInvoiceNumber,
      this.paymentReffrenceNumber,
      this.transactionModule,
      this.transactionType,
      this.transactionDate,
      this.customerVendor,
      this.cashAmount,
      this.cardAmount,
      this.bankAmount,
      this.upiAmount,
      this.totalAmount,
      this.sNo});

  DailyPaymentReportListData.fromJson(Map<String, dynamic> json) {
    reffrenceInvoiceNumber = json['reffrence_invoice_number'];
    paymentReffrenceNumber = json['payment_reffrence_number'];
    transactionModule = json['transaction_module'];
    transactionType = json['transaction_type'];
    transactionDate = json['transaction_date'];
    customerVendor = json['customer_vendor'];
    cashAmount = json['cash_amount'];
    cardAmount = json['card_amount'];
    bankAmount = json['bank_amount'];
    upiAmount = json['upi_amount'];
    totalAmount = json['total_amount'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reffrence_invoice_number'] = this.reffrenceInvoiceNumber;
    data['payment_reffrence_number'] = this.paymentReffrenceNumber;
    data['transaction_module'] = this.transactionModule;
    data['transaction_type'] = this.transactionType;
    data['transaction_date'] = this.transactionDate;
    data['customer_vendor'] = this.customerVendor;
    data['cash_amount'] = this.cashAmount;
    data['card_amount'] = this.cardAmount;
    data['bank_amount'] = this.bankAmount;
    data['upi_amount'] = this.upiAmount;
    data['total_amount'] = this.totalAmount;
    data['s_no'] = this.sNo;
    return data;
  }
}
