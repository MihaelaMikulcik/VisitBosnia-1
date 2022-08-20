import 'package:visit_bosnia_mobile/model/tourist_facility.dart';

class Attraction {
  int? id;
  double? geoLong;
  double? geoLat;
  TouristFacility? idNavigation;

  Attraction({this.id, this.geoLong, this.geoLat, this.idNavigation});

  Attraction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    geoLong = json['geoLong'];
    geoLat = json['geoLat'];
    idNavigation = json['idNavigation'] != null
        ? new TouristFacility.fromJson(json['idNavigation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['geoLong'] = this.geoLong;
    data['geoLat'] = this.geoLat;
    if (this.idNavigation != null) {
      data['idNavigation'] = this.idNavigation!.toJson();
    }
    return data;
  }
}
