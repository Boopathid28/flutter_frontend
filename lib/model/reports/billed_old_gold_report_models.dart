class BilledOldGoldReportPayload {
  String? menuId;
  dynamic fromDate;
  dynamic toDate;
  String? customer;
  String? search;
  num? page;
  num? itemsPerPage;
  String? branch;

  BilledOldGoldReportPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.customer,
      this.search,
      this.page,
      this.itemsPerPage,
      this.branch});

  BilledOldGoldReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    customer = json['customer'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['customer'] = this.customer;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}
