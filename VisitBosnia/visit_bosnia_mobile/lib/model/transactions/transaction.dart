import 'package:visit_bosnia_mobile/model/eventOrder/event_order.dart';

class Transaction {
  int? id;
  int? eventOrderId;
  String? date;
  String? status;
  EventOrder? eventOrder;

  Transaction(
      {this.id, this.eventOrderId, this.date, this.status, this.eventOrder});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventOrderId = json['eventOrderId'];
    date = json['date'];
    status = json['status'];
    eventOrder = json['eventOrder'] != null
        ? new EventOrder.fromJson(json['eventOrder'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventOrderId'] = this.eventOrderId;
    data['date'] = this.date;
    data['status'] = this.status;
    if (this.eventOrder != null) {
      data['eventOrder'] = this.eventOrder!.toJson();
    }
    return data;
  }
}
