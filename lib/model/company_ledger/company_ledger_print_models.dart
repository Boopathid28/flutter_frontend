class PrintCompanyLedgerDetails {
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
  int? expenses;
  int? subExpenses;
  String? expenseName;
  String? subExpenseName;
  String? paymentMethodName;
  String? paymentProviderName;
  String? expensesTypeName;
  String? classificationName;

  PrintCompanyLedgerDetails(
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
      this.expenses,
      this.subExpenses,
      this.expenseName,
      this.subExpenseName,
      this.paymentMethodName,
      this.paymentProviderName,
      this.expensesTypeName,
      this.classificationName});

  PrintCompanyLedgerDetails.fromJson(Map<String, dynamic> json) {
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
    expenses = json['expenses'];
    subExpenses = json['sub_expenses'];
    expenseName = json['expense_name'];
    subExpenseName = json['sub_expense_name'];
    paymentMethodName = json['payment_method_name'];
    paymentProviderName = json['payment_provider_name'];
    expensesTypeName = json['expenses_type_name'];
    classificationName = json['classification_name'];
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
    data['expenses'] = this.expenses;
    data['sub_expenses'] = this.subExpenses;
    data['expense_name'] = this.expenseName;
    data['sub_expense_name'] = this.subExpenseName;
    data['payment_method_name'] = this.paymentMethodName;
    data['payment_provider_name'] = this.paymentProviderName;
    data['expenses_type_name'] = this.expensesTypeName;
    data['classification_name'] = this.classificationName;
    return data;
  }
}
