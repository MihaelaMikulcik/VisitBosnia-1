import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/events/event.dart';
import 'package:visit_bosnia_mobile/model/events/event_search_object.dart';
import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';
import 'package:visit_bosnia_mobile/pages/guide_participants.dart';
import 'package:visit_bosnia_mobile/providers/agency_member_provider.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
import 'package:visit_bosnia_mobile/providers/event_order_provider.dart';
import 'package:visit_bosnia_mobile/providers/event_provider.dart';
import 'package:visit_bosnia_mobile/providers/tourist_facility_gallery_provider.dart';

import '../components/navigation_drawer.dart';
import 'event_details2.dart';

class GuideEvents extends StatefulWidget {
  const GuideEvents({Key? key}) : super(key: key);

  @override
  State<GuideEvents> createState() => _GuideEventsState();
}

class _GuideEventsState extends State<GuideEvents> {
  late EventProvider _eventProvider;
  late AgencyMemberProvider _agencyMemberProvider;
  late TouristFacilityGalleryProvider _touristFacilityGalleryProvider;
  // late EventOrderProvider _eventOrderProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventProvider = context.read<EventProvider>();
    _agencyMemberProvider = context.read<AgencyMemberProvider>();
    _touristFacilityGalleryProvider =
        context.read<TouristFacilityGalleryProvider>();
    // _eventOrderProvider = context.read<EventOrderProvider>();
  }

  Future<String> getNumberOfParticipants(int eventId) async {
    try {
      var participantsNumber =
          await _eventProvider.GetNumberOfParticipants(eventId);
      return participantsNumber.toString();
    } catch (e) {
      return "error";
    }
  }

  Future<int?> GetAgencyMemberId(int appUserId) async {
    try {
      int agencyMemberId;
      var agenciesMembers = await _agencyMemberProvider
          .get({'appUserId': AppUserProvider.userData.id!});
      agencyMemberId = agenciesMembers.first.id!;
      return agencyMemberId;
    } catch (e) {
      return null;
    }
  }
  // Future<int> GetAgency(int appUserId) async {
  //   int agencyId;
  //   var agencies = await _agencyMemberProvider
  //       .get({'appUserId': AppUserProvider.userData.id!.toString()});
  //   agencyId = agencies.first.agencyId!;
  //   return agencyId;
  // }

  Future<List<Event>?> GetData() async {
    var memberId = await GetAgencyMemberId(AppUserProvider.userData.id!);
    try {
      if (memberId != null) {
        List<Event> transactions;
        var search = EventSearchObject(
            includeIdNavigation: true,
            includeAgency: true,
            includeAgencyMember: true,
            agencyMemberId: memberId);
        transactions = await _eventProvider.get(search.toJson());
        return transactions;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<String?> getImage(int facilityId) async {
    try {
      var search = TouristFacilityGallerySearchObject(
          facilityId: facilityId, isThumbnail: true);
      var image = await _touristFacilityGalleryProvider.get(search.toJson());
      if (image.isNotEmpty) {
        return image.first.image!;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(29, 76, 120, 1),
          ),
          drawer: NavigationDrawer(),
          body: SingleChildScrollView(
            child: Column(children: [
              _buildHeader(),
              Container(
                  height: MediaQuery.of(context).size.height * 0.81 -
                      AppBar().preferredSize.height,
                  child: _buildEventsList()),
            ]),
          )),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 25, left: 25),
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
            color: Colors.black54, blurRadius: 15.0, offset: Offset(0.0, 0.75))
      ], color: Colors.white),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "Hi, " + AppUserProvider.userData.firstName! + "!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              // Icon(CupertinoIcons.ticket, size: 30)
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "View your events",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildEventsList() {
    return FutureBuilder<List<Event>?>(
        future: GetData(),
        builder: (BuildContext context, AsyncSnapshot<List<Event>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return ListView(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  children: snapshot.data!.map((e) => _eventWidget(e)).toList(),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Container(
                    //   padding: EdgeInsets.only(bottom: 20),
                    //   height: 90,
                    //   width: 90,
                    //   // child: Image.asset("assets/images/no_ticket.png")
                    // ),
                    Text('No events yet...', style: TextStyle(fontSize: 17)),
                  ],
                );
              }
            }
          }
        });
  }

  Widget _buildEventText(Event event) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              event.idNavigation!.name!.length > 27
                  ? '${event.idNavigation!.name!.substring(0, 27)}...'
                  : event.idNavigation!.name!,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _buildParticipants(event.id!),
        ],
      ),
    );
  }

  Widget _buildParticipants(int eventId) {
    return FutureBuilder(
        future: getNumberOfParticipants(eventId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${snapshot.data} participants",
                  // "participants",
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 94, 89, 89)),
                ),
                Icon(Icons.person)
              ],
            );
          } else {
            return Text("loading...");
          }
        });
    // return Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children:[
    //           Text(
    //             "${getNumberOfParticipants(eventId).toString()} participants",
    //             // "participants",
    //             style: TextStyle(fontSize: 18),
    //           ),
    //           Icon(Icons.person)
    //         ],
    //       )
  }

  Widget _buildImage(int facilityId) {
    return FutureBuilder<String?>(
        future: getImage(facilityId),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
              // child: Text('Loading...'),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                // child: Text('${snapshot.error}'),
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.hasData) {
                return Container(
                    height: 130.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            alignment: FractionalOffset.center,
                            image: MemoryImage(
                              base64Decode(snapshot.data!),
                            )),
                        borderRadius: BorderRadius.circular(20)));
              } else {
                return Container(
                  height: 130.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: FractionalOffset.center,
                        image: AssetImage("assets/images/location.jpg"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(20)),
                );
              }
            }
          }
        });
  }

  Widget _eventWidget(Event event) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GuideParticipants(event)));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 10, 30, 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(offset: Offset(0, 10), blurRadius: 10, color: Colors.grey)
          ],
        ),
        height: 210,
        child: Column(children: [
          // Expanded(
          //   child: _buildImage(event.id!),
          // ),
          SizedBox(
            height: 130,
            child: _buildImage(event.id!),
          ),
          Expanded(child: _buildEventText(event))
        ]),
      ),
    );
  }
}
