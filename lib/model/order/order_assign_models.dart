class OrderItemtableList {
  int? menuId;
  int? id;

  OrderItemtableList({this.menuId, this.id});

  OrderItemtableList.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    return data;
  }
}



class OrderItemtableListData {
  int? id;
  double? grossWeight;
  double? netWeight;
  int? pieces;
  String? gender;
  String? measurementType;
  String? priority;
  String? measurementValue;
  String? issuedDate;
  String? receivedDate;
  String? dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  int? totalStonePieces;
  int? totalDiamondPieces;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? orderDetails;
  int? subItemDetails;
  String? vendorDetails;
  String? itemDetailsName;
  String? subItemDetailsName;
  String? metalName;
  String? purityName;
  String? orderId;
  String? customerName;
  int? sNo;

  OrderItemtableListData(
      {this.id,
      this.grossWeight,
      this.netWeight,
      this.pieces,
      this.gender,
      this.measurementType,
      this.priority,
      this.measurementValue,
      this.issuedDate,
      this.receivedDate,
      this.dueDate,
      this.isIssued,
      this.isReceived,
      this.remarks,
      this.totalStonePieces,
      this.totalDiamondPieces,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.orderDetails,
      this.subItemDetails,
      this.vendorDetails,
      this.itemDetailsName,
      this.subItemDetailsName,
      this.metalName,
      this.purityName,
      this.orderId,
      this.customerName,
      this.sNo});

  OrderItemtableListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossWeight = json['gross_weight'];
    netWeight = json['net_weight'];
    pieces = json['pieces'];
    gender = json['gender'];
    measurementType = json['measurement_type'];
    priority = json['priority'];
    measurementValue = json['measurement_value'].toString();
    issuedDate = json['issued_date'];
    receivedDate = json['received_date'];
    dueDate = json['due_date'];
    isIssued = json['is_issued'];
    isReceived = json['is_received'];
    remarks = json['remarks'];
    totalStonePieces = json['total_stone_pieces'];
    totalDiamondPieces = json['total_diamond_pieces'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    orderDetails = json['order_details'];
    subItemDetails = json['sub_item_details'];
    vendorDetails = json['vendor_details'];
    itemDetailsName = json['item_details_name'];
    subItemDetailsName = json['sub_item_details_name'];
    metalName = json['metal_name'];
    purityName = json['purity_name'];
    orderId = json['order_id'];
    customerName = json['customer_name'];
    sNo = json['s.no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['pieces'] = this.pieces;
    data['gender'] = this.gender;
    data['measurement_type'] = this.measurementType;
    data['priority'] = this.priority;
    data['measurement_value'] = this.measurementValue;
    data['issued_date'] = this.issuedDate;
    data['received_date'] = this.receivedDate;
    data['due_date'] = this.dueDate;
    data['is_issued'] = this.isIssued;
    data['is_received'] = this.isReceived;
    data['remarks'] = this.remarks;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['order_details'] = this.orderDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['vendor_details'] = this.vendorDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['sub_item_details_name'] = this.subItemDetailsName;
    data['metal_name'] = this.metalName;
    data['purity_name'] = this.purityName;
    data['order_id'] = this.orderId;
    data['customer_name'] = this.customerName;
    data['s.no'] = this.sNo;
    return data;
  }
}





class AssignVendorPayload {
  int? menuId;
  List<OrderItemDetails>? orderItemDetails;

  AssignVendorPayload({this.menuId, this.orderItemDetails});

  AssignVendorPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    if (json['order_item_details'] != null) {
      orderItemDetails = <OrderItemDetails>[];
      json['order_item_details'].forEach((v) {
        orderItemDetails!.add(new OrderItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    if (this.orderItemDetails != null) {
      data['order_item_details'] =
          this.orderItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItemDetails {
  //  late String sNo;
  int? id;
  int? vendorDetails;
  String? dueDate;

  OrderItemDetails({this.id, this.vendorDetails, this.dueDate});

  OrderItemDetails.fromJson(Map<String, dynamic> json) {
      // sNo = json['s_no'];
    id = json['id'];
    vendorDetails = json['vendor_details'];
    dueDate = json['due_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    //  data['s_no'] = this.sNo;
    data['id'] = this.id;
    data['vendor_details'] = this.vendorDetails;
    data['due_date'] = this.dueDate;
    return data;
  }
}







class AssignVendorResponse {
  int? id;
  double? grossWeight;
  double? netWeight;
  int? pieces;
  String? gender;
  String? measurementType;
  String? priority;
  String? measurementValue;
  String? issuedDate;
  String? receivedDate;
  String? dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  int? totalStonePieces;
  int? totalDiamondPieces;
  String? createdAt;
  String? createdBy;
  String? modifiedBy;
  int? orderDetails;
  int? subItemDetails;
  int? vendorDetails;

  AssignVendorResponse(
      {this.id,
      this.grossWeight,
      this.netWeight,
      this.pieces,
      this.gender,
      this.measurementType,
      this.priority,
      this.measurementValue,
      this.issuedDate,
      this.receivedDate,
      this.dueDate,
      this.isIssued,
      this.isReceived,
      this.remarks,
      this.totalStonePieces,
      this.totalDiamondPieces,
      this.createdAt,
      this.createdBy,
      this.modifiedBy,
      this.orderDetails,
      this.subItemDetails,
      this.vendorDetails});

  AssignVendorResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossWeight = json['gross_weight'];
    netWeight = json['net_weight'];
    pieces = json['pieces'];
    gender = json['gender'];
    measurementType = json['measurement_type'];
    priority = json['priority'];
    measurementValue = json['measurement_value'].toString();
    issuedDate = json['issued_date'];
    receivedDate = json['received_date'];
    dueDate = json['due_date'];
    isIssued = json['is_issued'];
    isReceived = json['is_received'];
    remarks = json['remarks'];
    totalStonePieces = json['total_stone_pieces'];
    totalDiamondPieces = json['total_diamond_pieces'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    orderDetails = json['order_details'];
    subItemDetails = json['sub_item_details'];
    vendorDetails = json['vendor_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gross_weight'] = this.grossWeight;
    data['net_weight'] = this.netWeight;
    data['pieces'] = this.pieces;
    data['gender'] = this.gender;
    data['measurement_type'] = this.measurementType;
    data['priority'] = this.priority;
    data['measurement_value'] = this.measurementValue;
    data['issued_date'] = this.issuedDate;
    data['received_date'] = this.receivedDate;
    data['due_date'] = this.dueDate;
    data['is_issued'] = this.isIssued;
    data['is_received'] = this.isReceived;
    data['remarks'] = this.remarks;
    data['total_stone_pieces'] = this.totalStonePieces;
    data['total_diamond_pieces'] = this.totalDiamondPieces;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_by'] = this.modifiedBy;
    data['order_details'] = this.orderDetails;
    data['sub_item_details'] = this.subItemDetails;
    data['vendor_details'] = this.vendorDetails;
    return data;
  }
}

