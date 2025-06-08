class FetchDayBookListPayload {
  int? menuId;
  String? fromDate;
  int? page;
  int? itemsPerPage;
  String? metal;
  String? paymentProvider;
  String? paymentMethod;

  FetchDayBookListPayload(
      {this.menuId,
      this.fromDate,
      this.page,
      this.itemsPerPage,
      this.metal,
      this.paymentProvider,
      this.paymentMethod});

  FetchDayBookListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    metal = json['metal'];
    paymentProvider = json['payment_provider'];
    paymentMethod = json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['metal'] = this.metal;
    data['payment_provider'] = this.paymentProvider;
    data['payment_method'] = this.paymentMethod;
    return data;
  }
}
