import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';
import 'package:visit_bosnia_mobile/model/events/event.dart';

class EventOrder {
  int? id;
  int? eventId;
  int? appUserId;
  int? quantity;
  int? price;
  AppUser? appUser;
  Event? event;

  EventOrder(
      {this.id,
      this.eventId,
      this.appUserId,
      this.quantity,
      this.price,
      this.appUser,
      this.event});

  EventOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventId = json['eventId'];
    appUserId = json['appUserId'];
    quantity = json['quantity'];
    price = json['price'];
    appUser =
        json['appUser'] != null ? new AppUser.fromJson(json['appUser']) : null;
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['eventId'] = this.eventId;
    data['appUserId'] = this.appUserId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    if (this.appUser != null) {
      data['appUser'] = this.appUser!.toJson();
    }
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    return data;
  }
}
