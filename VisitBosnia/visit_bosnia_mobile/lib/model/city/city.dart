class City {
  int? id;
  String? name;
  String? county;
  String? zipCode;
  String? image;

  City({this.id, this.name, this.county, this.zipCode});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    county = json['county'];
    zipCode = json['zipCode'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['county'] = this.county;
    data['zipCode'] = this.zipCode;
    data['image'] = this.image;
    return data;
  }
}
