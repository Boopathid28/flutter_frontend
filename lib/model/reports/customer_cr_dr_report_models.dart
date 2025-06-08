class FetchCustomerCRDRListPayload {
  String? fromDate;
  int? menuId;
  int? page;
  int? itemsPerPage;

  FetchCustomerCRDRListPayload(
      {this.fromDate, this.menuId, this.page, this.itemsPerPage});

  FetchCustomerCRDRListPayload.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    menuId = json['menu_id'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['menu_id'] = this.menuId;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}



class CustomerCRDRListData {
  int? id;
  String? customer;
  String? mobile;
  String? dr;
  String? cr;

  CustomerCRDRListData({this.id, this.customer, this.mobile, this.dr, this.cr});

  CustomerCRDRListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'];
    mobile = json['mobile'];
    dr = json['dr'].toString();
    cr = json['cr'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer'] = this.customer;
    data['mobile'] = this.mobile;
    data['dr'] = this.dr;
    data['cr'] = this.cr;
    return data;
  }
}
