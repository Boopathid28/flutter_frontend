class FetchMetalRateMasterListPayload {
  int? menuId;
  int? page;
  int? itemsPerPage;
  String? fromDate;
  String? toDate;

  FetchMetalRateMasterListPayload({
    this.menuId,
    this.page,
    this.itemsPerPage,
    this.fromDate,
    this.toDate,
  });

  FetchMetalRateMasterListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    return data;
  }
}

class MetalRateMasterListData {
  String? date;
  List<Rates>? rates;
  int? sNo;

  MetalRateMasterListData({this.date, this.rates, this.sNo});

  MetalRateMasterListData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['rates'] != null) {
      rates = <Rates>[];
      json['rates'].forEach((v) {
        rates!.add(new Rates.fromJson(v));
      });
    }
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.rates != null) {
      data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    }
    data['s_no'] = this.sNo;
    return data;
  }
}

class Rates {
  int? id;
  int? metal;
  String? metalName;
  int? purity;
  String? purityName;
  String? displayName;
  double? rate;

  Rates(
      {this.id,
      this.metal,
      this.metalName,
      this.purity,
      this.purityName,
      this.displayName,
      this.rate});

  Rates.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metal = json['metal'];
    metalName = json['metal_name'];
    purity = json['purity'];
    purityName = json['purity_name'];
    displayName = json['display_name'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal'] = this.metal;
    data['metal_name'] = this.metalName;
    data['purity'] = this.purity;
    data['purity_name'] = this.purityName;
    data['display_name'] = this.displayName;
    data['rate'] = this.rate;
    return data;
  }
}

class CreateMetalRateMasterPayload {
  int? menuId;
  List<MetalRates>? metalRates;

  CreateMetalRateMasterPayload({this.menuId, this.metalRates});

  CreateMetalRateMasterPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    if (json['metal_rates'] != null) {
      metalRates = <MetalRates>[];
      json['metal_rates'].forEach((v) {
        metalRates!.add(new MetalRates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    if (this.metalRates != null) {
      data['metal_rates'] = this.metalRates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MetalRates {
  String? purity;
  String? rate;

  MetalRates({this.purity, this.rate});

  MetalRates.fromJson(Map<String, dynamic> json) {
    purity = json['purity'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purity'] = this.purity;
    data['rate'] = this.rate;
    return data;
  }
}

class MetalRateFormFieldModel {
  String? label;
  String? value;
  String? purity;

  MetalRateFormFieldModel({this.label, this.value, this.purity});

  MetalRateFormFieldModel.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
    purity = json['purity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['label'] = this.label;
    data['value'] = this.value;
    data['purity'] = this.purity;
    return data;
  }
}
