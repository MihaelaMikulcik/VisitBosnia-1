// class AppUser {
//   String? firstName;
//   String? lastName;
//   String? email;
//   String? userName;

//   AppUser({this.firstName, this.lastName, this.email, this.userName});

//   AppUser.fromJson(Map<String, dynamic> json) {
//     firstName = json['firstName'] as String;
//     lastName = json['lastName'] as String;
//     email = json['email'] as String;
//     userName = json['userName'] as String;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['firstName'] = this.firstName;
//     data['lastName'] = this.lastName;
//     data['email'] = this.email;
//     data['userName'] = this.userName;
//     return data;
//   }
// }

class AppUser {
  int? id;
  String? firstName;
  String? lastName;
  String? userName;

  AppUser({this.id, this.firstName, this.lastName, this.userName});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['userName'] = this.userName;
    return data;
  }
}
