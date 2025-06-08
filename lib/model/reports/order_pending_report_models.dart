class FetchOrderPendingReportListDataPayload {
  String? fromDate;
  String? toDate;
  int? page;
  int? itemsPerPage;
  int? menuId;
  String? branch;

  FetchOrderPendingReportListDataPayload(
      {this.fromDate,
      this.toDate,
      this.page,
      this.itemsPerPage,
      this.menuId,
      this.branch});

  FetchOrderPendingReportListDataPayload.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    toDate = json['to_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    return data;
  }
}



class OrderPendingReportListData {
  String? date;
  String? orderId;
  String? item;
  String? pieces;
  String? weight;
  String? dueDate;
  int? sNo;

  OrderPendingReportListData(
      {this.date,
      this.orderId,
      this.item,
      this.pieces,
      this.weight,
      this.dueDate,
      this.sNo});

  OrderPendingReportListData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    orderId = json['order_id'];
    item = json['item'];
    pieces = json['pieces'].toString();
    weight = json['weight'].toString();
    dueDate = json['due_date'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['order_id'] = this.orderId;
    data['item'] = this.item;
    data['pieces'] = this.pieces;
    data['weight'] = this.weight;
    data['due_date'] = this.dueDate;
    data['s_no'] = this.sNo;
    return data;
  } 
}
