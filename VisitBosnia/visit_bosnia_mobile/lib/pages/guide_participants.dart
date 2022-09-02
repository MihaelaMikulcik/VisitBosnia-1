// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/eventOrder/event_order.dart';
import 'package:visit_bosnia_mobile/model/eventOrder/event_order_search_object.dart';
import 'package:visit_bosnia_mobile/providers/event_order_provider.dart';
import 'package:visit_bosnia_mobile/providers/event_provider.dart';
import 'package:visit_bosnia_mobile/providers/tourist_facility_gallery_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../model/events/event.dart';
import '../model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';

class GuideParticipants extends StatefulWidget {
  GuideParticipants(this.event, {Key? key}) : super(key: key);
  Event event;

  @override
  State<GuideParticipants> createState() => _GuideParticipantsState(event);
}

class _GuideParticipantsState extends State<GuideParticipants> {
  _GuideParticipantsState(this.event);
  Event event;

  late TouristFacilityGalleryProvider _touristFacilityGalleryProvider;
  late EventOrderProvider _eventOrderProvider;
  late EventProvider _eventProvider;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _touristFacilityGalleryProvider =
        context.read<TouristFacilityGalleryProvider>();
    _eventOrderProvider = context.read<EventOrderProvider>();
    _eventProvider = context.read<EventProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        _builImage(),
        _buildHeader(),
        Expanded(child: _buildParticipantsList())
      ],
    ));
  }

  Future<List<EventOrder>?> GetEventOrders() async {
    try {
      List<EventOrder> eventOrders;
      EventOrderSearchObject search = EventOrderSearchObject(
          includeAppUser: true,
          eventId: event.id,
          agencyMemberId: event.agencyMemberId);
      eventOrders = await _eventOrderProvider.get(search.toJson());
      return eventOrders;
    } catch (e) {
      return null;
    }
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

  Widget _buildParticipants(int eventId) {
    return FutureBuilder(
        future: getNumberOfParticipants(eventId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${snapshot.data.toString()} participants",
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 94, 89, 89)),
                ),
                Icon(Icons.person)
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  "loading...",
                  style: TextStyle(
                      fontSize: 17, color: Color.fromARGB(255, 94, 89, 89)),
                ),
                Icon(Icons.person)
              ],
            );
          }
        });
  }

  Widget _eventOrderWidget(EventOrder eventOrder) {
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
      height: 80,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 217, 217, 217),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 2),
              blurRadius: 2,
              color: Color.fromARGB(255, 63, 62, 62))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: eventOrder.appUser!.image! == ""
                  ? const AssetImage("assets/images/user3.jpg")
                  : imageFromBase64String(eventOrder.appUser!.image!).image,
              radius: 30,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "${eventOrder.appUser!.firstName!} ${eventOrder.appUser!.lastName!}",
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("${eventOrder.quantity!}x",
                            style: TextStyle(
                              fontSize: 18,
                            )),
                      ),
                      Icon(Icons.person)
                    ],
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantsList() {
    return FutureBuilder<List<EventOrder>?>(
        future: GetEventOrders(),
        builder:
            (BuildContext context, AsyncSnapshot<List<EventOrder>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
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
                  children:
                      snapshot.data!.map((e) => _eventOrderWidget(e)).toList(),
                );
              } else {
                return const Center(
                  child: Text('No participants for this event yet...'),
                );
              }
            }
          }
        });
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
      child: Column(children: [
        Row(
          children: [
            Expanded(
              child: Text(
                event.idNavigation!.name!,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ),
            Column(
              children: [
                Text(
                  formatStringDate(event.date!, "yMd"),
                  style: TextStyle(
                      fontSize: 16, color: Color.fromARGB(255, 87, 85, 85)),
                ),
                Text(getTime(event.date!),
                    style: TextStyle(
                        fontSize: 16, color: Color.fromARGB(255, 87, 85, 85))),
              ],
            )
          ],
        ),
        SizedBox(
          height: 5,
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Participants list",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        _buildParticipants(event.id!),
      ]),
    );
  }

  Widget _builImage() {
    return FutureBuilder<String?>(
        future: getImage(event.id!),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.grey,
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Container(
              height: 200,
              color: Color.fromARGB(255, 161, 160, 160),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Something went wrong...",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            );
          } else if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            return SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Image.memory(
                base64Decode(snapshot.data!),
                fit: BoxFit.cover,
              ),
            );
          } else {
            return Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: FractionalOffset.center,
                  image: AssetImage("assets/images/location.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            );
          }
        });
  }
}
