// import 'dart:html';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visit_bosnia_mobile/components/buy_ticket_dialog.dart';
import 'package:visit_bosnia_mobile/model/events/event.dart';
import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery.dart';
import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';
import 'package:visit_bosnia_mobile/providers/event_provider.dart';
import 'package:visit_bosnia_mobile/providers/tourist_facility_gallery_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../components/tourist_facility_info.dart';

class EventDetails2 extends StatefulWidget {
  EventDetails2(this.event, {Key? key}) : super(key: key);
  Event event;

  @override
  State<EventDetails2> createState() => _EventDetails2State(event);
}

class _EventDetails2State extends State<EventDetails2> {
  Event event;
  _EventDetails2State(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        TouristFacilityInfo(event.idNavigation!),
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            children: [
              buildDetailRow("Tourist agency", event.agency!.name!),
              buildDetailRow("Tourist guide",
                  "${event.agencyMember!.appUser!.firstName!} ${event.agencyMember!.appUser!.lastName!}"),
              buildDetailRow("Duration", "${getDuration()} hours"),
              buildDetailRow("Date", formatStringDate(event.date!)),
              buildDetailRow("Time", timeToString(event.fromTime!)),
              buildDetailRow("Price", "${event.pricePerPerson.toString()} KM"),
              const SizedBox(height: 20),
              btnBuyTicket(),
              buildReviews(),
            ],
          ),
        )
      ]),
    ));
  }

  String getDuration() {
    var duration = event.toTime! - event.fromTime!;
    var d = Duration(minutes: duration);
    List<String> parts = d.toString().split(':');
    if (parts[1] != '00') {
      int satiInt = int.parse(parts[0]) + 1;
      return '${parts[0]} - $satiInt';
    } else {
      return parts[0];
    }
  }

  Widget buildReviews() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(children: const [
        Text(
          "Reviews ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        Icon(
          Icons.reviews_outlined,
          size: 30,
        ),
        Text("2 reviews",
            style: TextStyle(
                color: Color.fromARGB(255, 92, 91, 91),
                fontWeight: FontWeight.bold,
                fontSize: 18))
      ]),
    );
  }

  Widget btnBuyTicket() {
    return InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                  contentPadding: EdgeInsets.all(0),
                  title: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(event.idNavigation!.name!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22))),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            formatStringDate(event.date!),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 19),
                          ),
                          const Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  content: BuyTicketDialog(event)),
              barrierDismissible: true);
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 211, 75, 70),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text("Buy a ticket",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ));
  }

  Widget buildDetailRow(String title, String value) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.35,
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.only(left: 20),
            child: Text(value, style: const TextStyle(fontSize: 18)),
          ),
        ),
        const SizedBox(height: 30)
      ],
    );
  }
}
