class Event {
  int? agencyId;
  int? agencyMemberId;
  String? date;
  int? fromTime;
  int? toTime;
  String? placeOfDeparture;
  int? pricePerPerson;
  int? maxNumberOfParticipants;
  String? agency;
  String? agencyMember;
  int? id;
  String? name;
  String? description;
  int? cityId;
  int? categoryId;
  String? categoryName;
  String? cityName;
  String? city;
  String? category;

  Event(
      {this.agencyId,
      this.agencyMemberId,
      this.date,
      this.fromTime,
      this.toTime,
      this.placeOfDeparture,
      this.pricePerPerson,
      this.maxNumberOfParticipants,
      this.agency,
      this.agencyMember,
      this.id,
      this.name,
      this.description,
      this.cityId,
      this.categoryId,
      this.categoryName,
      this.cityName,
      this.city,
      this.category});

  Event.fromJson(Map<String, dynamic> json) {
    agencyId = json['agencyId'];
    agencyMemberId = json['agencyMemberId'];
    date = json['date'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    placeOfDeparture = json['placeOfDeparture'];
    pricePerPerson = json['pricePerPerson'];
    maxNumberOfParticipants = json['maxNumberOfParticipants'];
    agency = json['agency'];
    agencyMember = json['agencyMember'];
    id = json['id'];
    name = json['name'];
    description = json['description'];
    cityId = json['cityId'];
    categoryId = json['categoryId'];
    categoryName = json['categoryName'];
    cityName = json['cityName'];
    city = json['city'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['agencyId'] = this.agencyId;
    data['agencyMemberId'] = this.agencyMemberId;
    data['date'] = this.date;
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    data['placeOfDeparture'] = this.placeOfDeparture;
    data['pricePerPerson'] = this.pricePerPerson;
    data['maxNumberOfParticipants'] = this.maxNumberOfParticipants;
    data['agency'] = this.agency;
    data['agencyMember'] = this.agencyMember;
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['cityId'] = this.cityId;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['cityName'] = this.cityName;
    data['city'] = this.city;
    data['category'] = this.category;
    return data;
  }
}
