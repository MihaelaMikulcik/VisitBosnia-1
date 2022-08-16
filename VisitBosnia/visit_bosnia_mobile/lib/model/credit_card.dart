class CreditCard {
  String? expMonth;
  String? expYear;
  String? number;
  String? cvc;

  CreditCard({this.expMonth, this.expYear, this.number, this.cvc});

  CreditCard.fromJson(Map<String, dynamic> json) {
    expMonth = json['expMonth'];
    expYear = json['expYear'];
    number = json['number'];
    cvc = json['cvc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['expMonth'] = this.expMonth;
    data['expYear'] = this.expYear;
    data['number'] = this.number;
    data['cvc'] = this.cvc;
    return data;
  }
}
