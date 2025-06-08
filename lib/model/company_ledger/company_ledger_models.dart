class FetchCompanyLedgerListPayload {
  int? menuId;
  String? search;
  String? branch;
  bool? status;
   String? fromDate;
  String? toDate;
  String? expensesType;
 
  FetchCompanyLedgerListPayload(
      {this.menuId, this.search, this.branch, this.status,  this.fromDate,
      this.toDate, this.expensesType});
 
  FetchCompanyLedgerListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    search = json['search'];
    branch = json['branch'];
      fromDate = json['from_date'];
    toDate = json['to_date'];
    status = json['status'];
    expensesType = json['expenses_type'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['search'] = this.search;
       data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['branch'] = this.branch;
    data['status'] = this.status;
    data['expenses_type'] = this.expensesType;
    return data;
  }
}




class CompanyLedgerListData {
  int? id;
  String? expenseId;
  String? classification;
  String? expensesType;
  String? paymentMethod;
  String? paymentProvider;
  String? remarks;
  double? amount;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? expenses;
  int? subExpenses;
  int? branch;
  String? expensesName;
  String? subExpensesName;
  int? sNo;

  CompanyLedgerListData(
      {this.id,
      this.expenseId,
      this.classification,
      this.expensesType,
      this.paymentMethod,
      this.paymentProvider,
      this.remarks,
      this.amount,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.expenses,
      this.subExpenses,
      this.branch,
      this.expensesName,
      this.subExpensesName,
      this.sNo});

  CompanyLedgerListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseId = json['expense_id'];
    classification = json['classification'];
    expensesType = json['expenses_type'];
    paymentMethod = json['payment_method'];
    paymentProvider = json['payment_provider'];
    remarks = json['remarks'];
    amount = json['amount'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    expenses = json['expenses'];
    subExpenses = json['sub_expenses'];
    branch = json['branch'];
    expensesName = json['expenses_name'];
    subExpensesName = json['sub_expenses_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expense_id'] = this.expenseId;
    data['classification'] = this.classification;
    data['expenses_type'] = this.expensesType;
    data['payment_method'] = this.paymentMethod;
    data['payment_provider'] = this.paymentProvider;
    data['remarks'] = this.remarks;
    data['amount'] = this.amount;
    data['is_canceled'] = this.isCanceled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['expenses'] = this.expenses;
    data['sub_expenses'] = this.subExpenses;
    data['branch'] = this.branch;
    data['expenses_name'] = this.expensesName;
    data['sub_expenses_name'] = this.subExpensesName;
    data['s_no'] = this.sNo;
    return data;
  }
}




class CreateCompanyLedgerPayload {
  String? classification;
  String? expensesType;
  String? expenses;
  String? subExpenses;
  String? paymentMethod;
  String? paymentProvider;
  String? remarks;
  String? branch;
  int? menuId;
  String? amount;

  CreateCompanyLedgerPayload(
      {this.classification,
      this.expensesType,
      this.expenses,
      this.subExpenses,
      this.paymentMethod,
      this.paymentProvider,
      this.remarks,
      this.branch,
      this.menuId,
      this.amount});

  CreateCompanyLedgerPayload.fromJson(Map<String, dynamic> json) {
    classification = json['classification'];
    expensesType = json['expenses_type'];
    expenses = json['expenses'];
    subExpenses = json['sub_expenses'];
    paymentMethod = json['payment_method'];
    paymentProvider = json['payment_provider'];
    remarks = json['remarks'];
    branch = json['branch'];
    menuId = json['menu_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classification'] = this.classification;
    data['expenses_type'] = this.expensesType;
    data['expenses'] = this.expenses;
    data['sub_expenses'] = this.subExpenses;
    data['payment_method'] = this.paymentMethod;
    data['payment_provider'] = this.paymentProvider;
    data['remarks'] = this.remarks;
    data['branch'] = this.branch;
    data['menu_id'] = this.menuId;
    data['amount'] = this.amount;
    return data;
  }
}




class CreateCompanyLedgerResponse {
  int? id;
  String? expenseId;
  String? classification;
  String? expensesType;
  String? paymentMethod;
  String? paymentProvider;
  String? remarks;
  double? amount;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? expenses;
  int? subExpenses;
  int? branch;

  CreateCompanyLedgerResponse(
      {this.id,
      this.expenseId,
      this.classification,
      this.expensesType,
      this.paymentMethod,
      this.paymentProvider,
      this.remarks,
      this.amount,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.expenses,
      this.subExpenses,
      this.branch});

  CreateCompanyLedgerResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseId = json['expense_id'];
    classification = json['classification'];
    expensesType = json['expenses_type'];
    paymentMethod = json['payment_method'];
    paymentProvider = json['payment_provider'];
    remarks = json['remarks'];
    amount = json['amount'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    expenses = json['expenses'];
    subExpenses = json['sub_expenses'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expense_id'] = this.expenseId;
    data['classification'] = this.classification;
    data['expenses_type'] = this.expensesType;
    data['payment_method'] = this.paymentMethod;
    data['payment_provider'] = this.paymentProvider;
    data['remarks'] = this.remarks;
    data['amount'] = this.amount;
    data['is_canceled'] = this.isCanceled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['expenses'] = this.expenses;
    data['sub_expenses'] = this.subExpenses;
    data['branch'] = this.branch;
    return data;
  }
}

