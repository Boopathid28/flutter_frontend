class FetchExpenseAccoutListPayload {
  int? menuId;
  String? search;

  FetchExpenseAccoutListPayload({this.menuId, this.search});

  FetchExpenseAccoutListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['search'] = this.search;
    return data;
  }
}



class ExpenseAccoutListData {
  int? id;
  String? expensesName;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? sNo;

  ExpenseAccoutListData(
      {this.id,
      this.expensesName,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.sNo});

  ExpenseAccoutListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expensesName = json['expenses_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expenses_name'] = this.expensesName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['s_no'] = this.sNo;
    return data;
  }
}




class CreateExpenseAccountPayload {
  String? expensesName;
  int? menuId;

  CreateExpenseAccountPayload({this.expensesName, this.menuId});

  CreateExpenseAccountPayload.fromJson(Map<String, dynamic> json) {
    expensesName = json['expenses_name'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expenses_name'] = this.expensesName;
    data['menu_id'] = this.menuId;
    return data;
  }
}



class CreateExpenseAccountResponse {
  int? id;
  String? expensesName;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  CreateExpenseAccountResponse(
      {this.id,
      this.expensesName,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  CreateExpenseAccountResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expensesName = json['expenses_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expenses_name'] = this.expensesName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}



class UpdateExpenseAccountpayload {
  String? expensesName;
  int? menuId;
  int? id;

  UpdateExpenseAccountpayload({this.expensesName, this.menuId, this.id});

  UpdateExpenseAccountpayload.fromJson(Map<String, dynamic> json) {
    expensesName = json['expenses_name'];
    menuId = json['menu_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expenses_name'] = this.expensesName;
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    return data;
  }
}
