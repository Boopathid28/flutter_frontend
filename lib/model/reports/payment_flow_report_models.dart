class PepaymentFlowReportListPayload {
  String? fromDate;
  int? page;
  int? itemsPerPage;
  int? menuId;

  PepaymentFlowReportListPayload(
      {this.fromDate, this.page, this.itemsPerPage, this.menuId});

  PepaymentFlowReportListPayload.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    return data;
  }
}




class PaymentFlowReportListData {
	String? type;
	String? open;
	String? In;
	String? out;
	String? close;
	int? sNo;

	PaymentFlowReportListData({this.type, this.open, this.In, this.out, this.close, this.sNo});

	PaymentFlowReportListData.fromJson(Map<String, dynamic> json) {
		type = json['type'];
		open = json['open'].toString();
		In = json['in'].toString();
		out = json['out'].toString();
		close = json['close'].toString();
		sNo = json['s_no'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['type'] = this.type;
		data['open'] = this.open;
		data['in'] = this.In;
		data['out'] = this.out;
		data['close'] = this.close;
		data['s_no'] = this.sNo;
		return data;
	}
}
