import '../appUser/app_user.dart';
import 'role.dart';

class AppUserRole {
  int? id;
  int? appUserId;
  int? roleId;
  AppUser? appUser;
  Role? role;

  AppUserRole({this.id, this.appUserId, this.appUser, this.role, this.roleId});

  AppUserRole.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appUserId = json['appUserId'];
    roleId = json['roleId'];
    appUser =
        json['appUser'] != null ? new AppUser.fromJson(json['appUser']) : null;
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['appUserId'] = this.appUserId;
    data['roleId'] = this.roleId;
    if (this.appUser != null) {
      data['appUser'] = this.appUser!.toJson();
    }
    if (this.role != null) {
      data['role'] = this.role!.toJson();
    }
    return data;
  }
}
