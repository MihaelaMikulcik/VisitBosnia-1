import 'package:visit_bosnia_mobile/model/id_navigation.dart';

class TouristFacilityGallery {
  int? id;
  String? imageType;
  bool? thumbnail;
  String? image;
  int? touristFacilityId;
  IdNavigation? touristFacility;

  TouristFacilityGallery(
      {this.id,
      this.imageType,
      this.thumbnail,
      this.image,
      this.touristFacilityId,
      this.touristFacility});

  TouristFacilityGallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageType = json['imageType'];
    thumbnail = json['thumbnail'];
    image = json['image'];
    touristFacilityId = json['touristFacilityId'];
    // touristFacility = json['touristFacility'];
    touristFacility = json['idNavigation'] != null
        ? new IdNavigation.fromJson(json['idNavigation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['imageType'] = this.imageType;
    data['thumbnail'] = this.thumbnail;
    data['image'] = this.image;
    data['touristFacilityId'] = this.touristFacilityId;
    // data['touristFacility'] = this.touristFacility;
    if (this.touristFacility != null) {
      data['idNavigation'] = this.touristFacility!.toJson();
    }
    return data;
  }
}
