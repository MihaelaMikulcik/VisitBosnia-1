// // import 'dart:html';
// import 'dart:convert';

// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:visit_bosnia_mobile/components/buy_ticket_dialog.dart';
// import 'package:visit_bosnia_mobile/model/events/event.dart';
// import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery.dart';
// import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';
// import 'package:visit_bosnia_mobile/providers/event_provider.dart';
// import 'package:visit_bosnia_mobile/providers/tourist_facility_gallery_provider.dart';
// import 'package:visit_bosnia_mobile/utils/util.dart';

// import '../components/review_facility.dart';
// import '../components/tourist_facility_info.dart';

// class EventDetails2 extends StatefulWidget {
//   EventDetails2(this.event, {Key? key}) : super(key: key);
//   Event event;

//   @override
//   State<EventDetails2> createState() => _EventDetails2State(event);
// }

// class _EventDetails2State extends State<EventDetails2> {
//   Event event;
//   _EventDetails2State(this.event);

//   @override
//   Widget build(BuildContext context) {
//     NumberFormat formatter = NumberFormat();
//     formatter.minimumFractionDigits = 2;
//     formatter.maximumFractionDigits = 2;

//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Column(children: [
//         TouristFacilityInfo(event.idNavigation!),
//         Padding(
//           padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
//           child: Column(
//             children: [
//               buildDetailRow("Tourist agency", event.agency!.name!),
//               buildDetailRow("Starting point", event.placeOfDeparture!),
//               // buildDetailRow("Tourist guide",
//               //     "${event.agencyMember!.appUser!.firstName!} ${event.agencyMember!.appUser!.lastName!}"),
//               buildDetailRow("Duration", getDuration()),
//               buildDetailRow(
//                   "Date", formatStringDate(event.date!, 'EEE, MMM d')),
//               buildDetailRow("Time", timeToString(event.fromTime!)),
//               buildDetailRow(
//                   "Price", "${formatter.format(event.pricePerPerson)} BAM"),
//               const SizedBox(height: 20),
//               btnBuyTicket(),
//             ],
//           ),
//         ),
//         ReviewFacility(event.idNavigation!),
//       ]),
//     ));
//   }

//   String getDuration() {
//     var duration = event.toTime! - event.fromTime!;
//     if (duration < 60) {
//       return '${duration} minutes';
//     }
//     var d = Duration(minutes: duration);
//     List<String> parts = d.toString().split(':');
//     if (parts[1] != '00') {
//       int satiInt = int.parse(parts[0]) + 1;
//       return '${parts[0]} - $satiInt hours';
//     } else {
//       return '${parts[0]} hours';
//     }
//   }

//   Widget btnBuyTicket() {
//     return InkWell(
//         onTap: () {
//           showDialog(
//               context: context,
//               builder: (_) => AlertDialog(
//                   contentPadding: EdgeInsets.all(0),
//                   title: Column(
//                     children: [
//                       Align(
//                           alignment: Alignment.centerLeft,
//                           child: Text(event.idNavigation!.name!,
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 22))),
//                       const SizedBox(height: 10),
//                       Row(
//                         children: [
//                           Text(
//                             formatStringDate(event.date!, 'EEE, MMM d'),
//                             style: const TextStyle(
//                                 color: Colors.grey, fontSize: 19),
//                           ),
//                           const Icon(
//                             Icons.access_time,
//                             color: Colors.grey,
//                           )
//                         ],
//                       ),
//                       const SizedBox(height: 10),
//                     ],
//                   ),
//                   content: BuyTicketDialog(event)),
//               barrierDismissible: true);
//         },
//         child: Container(
//           alignment: Alignment.center,
//           width: MediaQuery.of(context).size.width,
//           height: 50,
//           decoration: BoxDecoration(
//             color: const Color.fromARGB(255, 211, 75, 70),
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: const Text("Buy a ticket",
//               style: TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20)),
//         ));
//   }

//   Widget buildDetailRow(String title, String value) {
//     return Row(
//       children: <Widget>[
//         SizedBox(
//           width: MediaQuery.of(context).size.width * 0.35,
//           child: Text(
//             title,
//             style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Container(
//             padding: const EdgeInsets.only(left: 20),
//             child: Text(value, style: const TextStyle(fontSize: 18)),
//           ),
//         ),
//         const SizedBox(height: 30)
//       ],
//     );
//   }
// }

// import 'dart:html';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visit_bosnia_mobile/components/buy_ticket_dialog.dart';
import 'package:visit_bosnia_mobile/model/events/event.dart';
import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery.dart';
import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';
import 'package:visit_bosnia_mobile/providers/event_provider.dart';
import 'package:visit_bosnia_mobile/providers/tourist_facility_gallery_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../components/review_facility.dart';
import '../components/tourist_facility_info.dart';

class EventDetails2 extends StatefulWidget {
  EventDetails2(this.eventId, {Key? key}) : super(key: key);
  int eventId;

  @override
  State<EventDetails2> createState() => _EventDetails2State(eventId);
}

class _EventDetails2State extends State<EventDetails2> {
  _EventDetails2State(this.eventId);
  int eventId;
  late EventProvider _eventProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventProvider = context.read<EventProvider>();
    // GetData(attractionId);
  }

  Future<Event?> GetData(int attractionId) async {
    try {
      var temp = await _eventProvider.getById(attractionId);
      return temp;
      // attraction = temp;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat();
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;

    return Scaffold(
        body: SingleChildScrollView(
            child: FutureBuilder<Event?>(
                future: GetData(eventId),
                builder:
                    (BuildContext context, AsyncSnapshot<Event?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        // color: Color.fromRGBO(29, 76, 120, 1),
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: CircularProgressIndicator(
                                // color: Colors.white,
                                )));
                  } else {
                    if (snapshot.hasData) {
                      return Column(children: [
                        TouristFacilityInfo(snapshot.data!.idNavigation!),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Column(
                            children: [
                              buildDetailRow("Tourist agency",
                                  snapshot.data!.agency!.name!),
                              buildDetailRow("Starting point",
                                  snapshot.data!.placeOfDeparture!),
                              // buildDetailRow("Tourist guide",
                              //     "${event.agencyMember!.appUser!.firstName!} ${event.agencyMember!.appUser!.lastName!}"),
                              buildDetailRow(
                                  "Duration", getDuration(snapshot.data!)),
                              buildDetailRow(
                                  "Date",
                                  formatStringDate(
                                      snapshot.data!.date!, 'EEE, MMM d')),
                              buildDetailRow("Time",
                                  timeToString(snapshot.data!.fromTime!)),
                              buildDetailRow("Price",
                                  "${formatter.format(snapshot.data!.pricePerPerson)} BAM"),
                              const SizedBox(height: 20),
                              btnBuyTicket(snapshot.data!),
                            ],
                          ),
                        ),
                        ReviewFacility(snapshot.data!.idNavigation!),
                      ]);
                    } else {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: Text("Something went wrong...")),
                      );
                    }
                  }
                })));
  }

  String getDuration(Event event) {
    var duration = event.toTime! - event.fromTime!;
    if (duration < 60) {
      return '${duration} minutes';
    }
    var d = Duration(minutes: duration);
    List<String> parts = d.toString().split(':');
    if (parts[1] != '00') {
      int satiInt = int.parse(parts[0]) + 1;
      return '${parts[0]} - $satiInt hours';
    } else {
      return '${parts[0]} hours';
    }
  }

  Widget btnBuyTicket(Event event) {
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
                            formatStringDate(event.date!, 'EEE, MMM d'),
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
