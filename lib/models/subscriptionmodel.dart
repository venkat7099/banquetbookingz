class subscription {
  int? statusCode;
  bool? success;
  List<String>? messages;
  List<Data>? data;

  subscription({this.statusCode, this.success, this.messages, this.data});

  subscription.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    messages = json['messages'].cast<String>();
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['success'] = this.success;
    data['messages'] = this.messages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  int? annualPricing;
  int? quaterlyPricing;
  int? monthlyPricing;

  Data(
      {this.id,
      this.name,
      this.annualPricing,
      this.quaterlyPricing,
      this.monthlyPricing});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['Name'];
    annualPricing = json['AnnualPricing'];
    quaterlyPricing = json['QuaterlyPricing'];
    monthlyPricing = json['MonthlyPricing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Name'] = this.name;
    data['AnnualPricing'] = this.annualPricing;
    data['QuaterlyPricing'] = this.quaterlyPricing;
    data['MonthlyPricing'] = this.monthlyPricing;
    return data;
  }
}
