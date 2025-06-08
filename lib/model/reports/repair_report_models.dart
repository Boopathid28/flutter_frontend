class FetchRepairReportListDataPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? customer;
  int? page;
  int? itemsPerPage;
  String? branch;

  FetchRepairReportListDataPayload(
      {this.menuId,
      this.fromDate,
      this.toDate,
      this.customer,
      this.page,
      this.itemsPerPage,
      this.branch});

  FetchRepairReportListDataPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    customer = json['customer'];
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
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['branch'] = this.branch;
    return data;
  }
}


class RepairReportListData {
  String? customerName;
  String? itemName;
  String? grossWeight;
  int? pieces;
  String? repairType;
  String? vendorName;
  String? vendorCharges;
  String? customerCharges;
  int? sNo;

  RepairReportListData(
      {this.customerName,
      this.itemName,
      this.grossWeight,
      this.pieces,
      this.repairType,
      this.vendorName,
      this.vendorCharges,
      this.customerCharges,
      this.sNo});

  RepairReportListData.fromJson(Map<String, dynamic> json) {
    customerName = json['customer_name'];
    itemName = json['item_name'];
    grossWeight = json['gross_weight'].toString();
    pieces = json['pieces'];
    repairType = json['repair_type'];
    vendorName = json['vendor_name'];
    vendorCharges = json['vendor_charges'].toString();
    customerCharges = json['customer_charges'].toString();
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_name'] = this.customerName;
    data['item_name'] = this.itemName;
    data['gross_weight'] = this.grossWeight;
    data['pieces'] = this.pieces;
    data['repair_type'] = this.repairType;
    data['vendor_name'] = this.vendorName;
    data['vendor_charges'] = this.vendorCharges;
    data['customer_charges'] = this.customerCharges;
    data['s_no'] = this.sNo;
    return data;
  }
}
