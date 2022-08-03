import 'city/city.dart';

class Agency {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? responsiblePerson;
  String? address;
  int? cityId;
  City? city;

  Agency(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.responsiblePerson,
      this.address,
      this.cityId,
      this.city});

  Agency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    responsiblePerson = json['responsiblePerson'];
    address = json['address'];
    cityId = json['cityId'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['responsiblePerson'] = this.responsiblePerson;
    data['address'] = this.address;
    data['cityId'] = this.cityId;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}
