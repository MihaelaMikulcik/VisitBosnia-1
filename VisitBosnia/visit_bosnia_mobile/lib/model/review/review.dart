import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';

import '../tourist_facility.dart';

class Review {
  int? id;
  String? text;
  int? rating;
  int? appUserId;
  int? idNavigationId;
  AppUser? appUser;
  TouristFacility? idNavigation;

  Review(
      {this.id,
      this.text,
      this.rating,
      this.appUserId,
      this.idNavigationId,
      this.appUser,
      this.idNavigation});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    rating = json['rating'];
    appUserId = json['appUserId'];
    idNavigationId = json['idNavigationId'];
    appUser =
        json['appUser'] != null ? new AppUser.fromJson(json['appUser']) : null;
    idNavigation = json['idNavigation'] != null
        ? new TouristFacility.fromJson(json['idNavigation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['rating'] = this.rating;
    data['appUserId'] = this.appUserId;
    data['idNavigationId'] = this.idNavigationId;
    if (this.appUser != null) {
      data['appUser'] = this.appUser!.toJson();
    }
    if (this.idNavigation != null) {
      data['idNavigation'] = this.idNavigation!.toJson();
    }
    return data;
  }
}
