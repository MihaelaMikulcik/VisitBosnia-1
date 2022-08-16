import '../credit_card.dart';

class TransactionInsertRequest {
  int? eventId;
  int? appUserId;
  String? description;
  int? quantity;
  double? price;
  late CreditCard creditCard;

  TransactionInsertRequest({
    this.eventId,
    this.appUserId,
    this.quantity,
    this.price,
    this.description,
    required this.creditCard,
  });

  TransactionInsertRequest.fromJson(Map<String, dynamic> json) {
    eventId = json['eventId'];
    appUserId = json['appUserId'];
    quantity = json['quantity'];
    price = json['price'];
    description = json['description'];
    creditCard = json['creditCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventId'] = this.eventId;
    data['appUserId'] = this.appUserId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['description'] = this.description;
    data['creditCard'] = this.creditCard.toJson();
    return data;
  }
}
