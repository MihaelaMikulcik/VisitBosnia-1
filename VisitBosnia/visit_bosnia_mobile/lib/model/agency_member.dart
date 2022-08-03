import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';

import 'agency.dart';

class AgencyMember {
  int? id;
  int? appUserId;
  int? agencyId;
  Agency? agency;
  AppUser? appUser;

  AgencyMember(
      {this.id, this.appUserId, this.agencyId, this.agency, this.appUser});

  AgencyMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appUserId = json['appUserId'];
    agencyId = json['agencyId'];
    agency =
        json['agency'] != null ? new Agency.fromJson(json['agency']) : null;
    appUser =
        json['appUser'] != null ? new AppUser.fromJson(json['appUser']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appUserId'] = this.appUserId;
    data['agencyId'] = this.agencyId;
    if (this.agency != null) {
      data['agency'] = this.agency!.toJson();
    }
    if (this.appUser != null) {
      data['appUser'] = this.appUser!.toJson();
    }
    return data;
  }
}
