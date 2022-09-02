import '../agency.dart';
import '../agency_member.dart';
import '../tourist_facility.dart';

class Event {
  int? id;
  int? agencyId;
  String? date;
  int? fromTime;
  int? toTime;
  String? placeOfDeparture;
  double? pricePerPerson;
  int? maxNumberOfParticipants;
  int? agencyMemberId;
  Agency? agency;
  AgencyMember? agencyMember;
  TouristFacility? idNavigation;

  Event(
      {this.id,
      this.agencyId,
      this.date,
      this.fromTime,
      this.toTime,
      this.placeOfDeparture,
      this.pricePerPerson,
      this.maxNumberOfParticipants,
      this.agencyMemberId,
      this.agency,
      this.agencyMember,
      this.idNavigation});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    agencyId = json['agencyId'];
    date = json['date'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    placeOfDeparture = json['placeOfDeparture'];
    pricePerPerson = json['pricePerPerson'];
    maxNumberOfParticipants = json['maxNumberOfParticipants'];
    agencyMemberId = json['agencyMemberId'];
    agency =
        json['agency'] != null ? new Agency.fromJson(json['agency']) : null;
    agencyMember = json['agencyMember'] != null
        ? new AgencyMember.fromJson(json['agencyMember'])
        : null;
    idNavigation = json['idNavigation'] != null
        ? new TouristFacility.fromJson(json['idNavigation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['agencyId'] = this.agencyId;
    data['date'] = this.date;
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    data['placeOfDeparture'] = this.placeOfDeparture;
    data['pricePerPerson'] = this.pricePerPerson;
    data['maxNumberOfParticipants'] = this.maxNumberOfParticipants;
    data['agencyMemberId'] = this.agencyMemberId;
    if (this.agency != null) {
      data['agency'] = this.agency!.toJson();
    }
    if (this.agencyMember != null) {
      data['agencyMember'] = this.agencyMember!.toJson();
    }
    if (this.idNavigation != null) {
      data['idNavigation'] = this.idNavigation!.toJson();
    }
    return data;
  }
}
