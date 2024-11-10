// class subscription {
//   int? statusCode;
//   bool? success;
//   List<String>? messages;
//   List<Data>? data;

//   subscription({this.statusCode, this.success, this.messages, this.data});

//   subscription.fromJson(Map<String, dynamic> json) {
//     statusCode = json['statusCode'];
//     success = json['success'];
//     messages = json['messages'].cast<String>();
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['statusCode'] = this.statusCode;
//     data['success'] = this.success;
//     data['messages'] = this.messages;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   int? id;
//   String? name;
//   int? annualPricing;
//   int? quaterlyPricing;
//   int? monthlyPricing;

//   Data(
//       {this.id,
//       this.name,
//       this.annualPricing,
//       this.quaterlyPricing,
//       this.monthlyPricing});

//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['Name'];
//     annualPricing = json['AnnualPricing'];
//     quaterlyPricing = json['QuaterlyPricing'];
//     monthlyPricing = json['MonthlyPricing'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['Name'] = this.name;
//     data['AnnualPricing'] = this.annualPricing;
//     data['QuaterlyPricing'] = this.quaterlyPricing;
//     data['MonthlyPricing'] = this.monthlyPricing;
//     return data;
//   }
// }

class subscription {
  int? statusCode;
  bool? success;
  List<String>? messages;
  List<Data>? data;

  subscription({this.statusCode, this.success, this.messages, this.data});

  subscription.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    success = json['success'];
    // Ensure 'messages' is not null before casting
    if (json['messages'] != null) {
      messages = List<String>.from(json['messages']);
    }
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['success'] = success;
    data['messages'] = messages;
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

  Data({
    this.id,
    this.name,
    this.annualPricing,
    this.quaterlyPricing,
    this.monthlyPricing,
  });

  // Factory constructor to create a Data instance from a JSON map
  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      name: json['name'], // Adjusted the JSON key to lowercase 'name'
      annualPricing: json[
          'annualPricing'], // Adjusted the JSON key to lowercase 'annualPricing'
      quaterlyPricing: json[
          'quaterlyPricing'], // Adjusted the JSON key to lowercase 'quaterlyPricing'
      monthlyPricing: json[
          'monthlyPricing'], // Adjusted the JSON key to lowercase 'monthlyPricing'
    );
  }

  // Method to convert a Data instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name, // Adjusted the JSON key to lowercase 'name'
      'annualPricing':
          annualPricing, // Adjusted the JSON key to lowercase 'annualPricing'
      'quaterlyPricing':
          quaterlyPricing, // Adjusted the JSON key to lowercase 'quaterlyPricing'
      'monthlyPricing':
          monthlyPricing, // Adjusted the JSON key to lowercase 'monthlyPricing'
    };
  }
}
