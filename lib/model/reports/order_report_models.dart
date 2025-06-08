class FetchOrderReportListPayload {
  int? menuId;
  String? fromDate;
  String? customer;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchOrderReportListPayload(
      {this.menuId,
      this.fromDate,
      this.customer,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchOrderReportListPayload.fromJson(Map<String, dynamic> json) {
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



class OrderReportListData {
  String? orderId;
  String? customerName;
  String? weight;
  String? totalAmount;
  String? advanceCash;
  String? advanceBank;
  String? advanceUpi;
  String? advanceCard;
  String? totalAdvance;
  String? oldAmount;
  String? oldWeight;
  int? sNo;

  OrderReportListData(
      {this.orderId,
      this.customerName,
      this.weight,
      this.totalAmount,
      this.advanceCash,
      this.advanceBank,
      this.advanceUpi,
      this.advanceCard,
      this.totalAdvance,
      this.oldAmount,
      this.oldWeight,
      this.sNo});

  OrderReportListData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    customerName = json['customer_name'];
    weight = json['weight'].toString();
    totalAmount = json['total_amount'].toString();
    advanceCash = json['advance_cash'].toString();
    advanceBank = json['advance_bank'].toString();
    advanceUpi = json['advance_upi'].toString();
    advanceCard = json['advance_card'].toString();
    totalAdvance = json['total_advance'].toString();
    oldAmount = json['old_amount'].toString();
    oldWeight = json['old_weight'].toString();
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['customer_name'] = this.customerName;
    data['weight'] = this.weight;
    data['total_amount'] = this.totalAmount;
    data['advance_cash'] = this.advanceCash;
    data['advance_bank'] = this.advanceBank;
    data['advance_upi'] = this.advanceUpi;
    data['advance_card'] = this.advanceCard;
    data['total_advance'] = this.totalAdvance;
    data['old_amount'] = this.oldAmount;
    data['old_weight'] = this.oldWeight;
    data['s_no'] = this.sNo;
    return data;
  }
}
