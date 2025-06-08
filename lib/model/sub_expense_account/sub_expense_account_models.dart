class FetchSubExpenseAccountListPayload {
  int? menuId;
  String? search;

  FetchSubExpenseAccountListPayload({this.menuId, this.search});

  FetchSubExpenseAccountListPayload.fromJson(Map<String, dynamic> json) {
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

class SubExpenseAccountListData {
  int? id;
  String? subExpensesName;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? expenses;
  String? expensesName;
  int? sNo;

  SubExpenseAccountListData(
      {this.id,
      this.subExpensesName,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.expenses,
      this.expensesName,
      this.sNo});

  SubExpenseAccountListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subExpensesName = json['sub_expenses_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    expenses = json['expenses'];
    expensesName = json['expenses_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_expenses_name'] = this.subExpensesName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['expenses'] = this.expenses;
    data['expenses_name'] = this.expensesName;
    data['s_no'] = this.sNo;
    return data;
  }
}



class CreateSubExpenseAccountPayload {
  String? expenses;
  String? subExpensesName;
  int? menuId;

  CreateSubExpenseAccountPayload(
      {this.expenses, this.subExpensesName, this.menuId});

  CreateSubExpenseAccountPayload.fromJson(Map<String, dynamic> json) {
    expenses = json['expenses'];
    subExpensesName = json['sub_expenses_name'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expenses'] = this.expenses;
    data['sub_expenses_name'] = this.subExpensesName;
    data['menu_id'] = this.menuId;
    return data;
  }
}



class CreateSubExpenseAccountResponse {
  int? id;
  String? subExpensesName;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? expenses;

  CreateSubExpenseAccountResponse(
      {this.id,
      this.subExpensesName,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.expenses});

  CreateSubExpenseAccountResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subExpensesName = json['sub_expenses_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    expenses = json['expenses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sub_expenses_name'] = this.subExpensesName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['expenses'] = this.expenses;
    return data;
  }
}



class UpdateSubExpenseAccountPayload {
  String? expenses;
  String? subExpensesName;
  int? menuId;
  int? id;

  UpdateSubExpenseAccountPayload(
      {this.expenses, this.subExpensesName, this.menuId, this.id});

  UpdateSubExpenseAccountPayload.fromJson(Map<String, dynamic> json) {
    expenses = json['expenses'];
    subExpensesName = json['sub_expenses_name'];
    menuId = json['menu_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expenses'] = this.expenses;
    data['sub_expenses_name'] = this.subExpensesName;
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    return data;
  }
}
