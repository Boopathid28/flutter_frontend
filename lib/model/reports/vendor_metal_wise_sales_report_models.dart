class VendorMetalWiseSalesReport {
  String? vendorName;
  List<Data>? data;
  num? sNo;

  VendorMetalWiseSalesReport({this.vendorName, this.data, this.sNo});

  VendorMetalWiseSalesReport.fromJson(Map<String, dynamic> json) {
    vendorName = json['vendor_name'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vendor_name'] = vendorName;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['s_no'] = sNo;
    return data;
  }
}

class Data {
  String? metalName;
  num? totalPieces;
  num? totalGrossweight;
  num? totalAmount;

  Data(
      {this.metalName,
      this.totalPieces,
      this.totalGrossweight,
      this.totalAmount});

  Data.fromJson(Map<String, dynamic> json) {
    metalName = json['metal_name'];
    totalPieces = json['total_pieces'];
    totalGrossweight = json['total_grossweight'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['metal_name'] = metalName;
    data['total_pieces'] = totalPieces;
    data['total_grossweight'] = totalGrossweight;
    data['total_amount'] = totalAmount;
    return data;
  }
}



class VendorMetalWiseSalesReportPayload {
  String? menuId;
  String? vendor;
  dynamic fromDate;
  dynamic toDate;
  String? branch;
  num? page;
  num? itemsPerPage;

  VendorMetalWiseSalesReportPayload(
      {this.menuId,
      this.vendor,
      this.fromDate,
      this.toDate,
      this.branch,
      this.page,
      this.itemsPerPage});

  VendorMetalWiseSalesReportPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    vendor = json['vendor'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    branch = json['branch'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['vendor'] = vendor;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['branch'] = branch;
    data['page'] = page;
    data['items_per_page'] = itemsPerPage;
    return data;
  }
}
