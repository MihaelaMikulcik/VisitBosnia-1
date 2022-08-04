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
import 'package:visit_bosnia_mobile/providers/tourist_facility_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../providers/tourist_facility_gallery_provider.dart';

class EventDetails extends StatefulWidget {
  EventDetails(this.event, {Key? key}) : super(key: key);
  Event event;

  @override
  State<EventDetails> createState() => _EventDetailsState(event);
}

class _EventDetailsState extends State<EventDetails> {
  Event event;
  _EventDetailsState(this.event);
  late TouristFacilityGalleryProvider _touristFacilityGalleryProvider;

  int activeIndex = 0;
  static dynamic gallery;
  bool hasImages = false;
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _touristFacilityGalleryProvider =
        context.read<TouristFacilityGalleryProvider>();
    LoadEventImages();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gallery = [];
  }

  void LoadEventImages() async {
    TouristFacilityGallerySearchObject search =
        TouristFacilityGallerySearchObject(facilityId: event.idNavigation!.id);
    try {
      loading = true;
      var tempImages =
          await _touristFacilityGalleryProvider.get(search.toJson());
      loading = false;
      if (tempImages.isEmpty) {
        setState(() => hasImages = false);
        return;
      }
      setState(() {
        hasImages = true;
        gallery = tempImages;
      });
    } catch (e) {
      hasImages = false;
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        _buildCarouselSlider(context),
        const SizedBox(height: 10),
        buildIndicator(),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  event.idNavigation!.name!,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
                Column(children: const [
                  Icon(
                    Icons.star,
                    color: Color.fromARGB(255, 245, 173, 40),
                    size: 45.0,
                  ),
                  Text(
                    "4,0",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ])
              ],
            ),
            Row(
              children: [
                Text(
                  // "Višegrad",
                  event.idNavigation!.city!.name!,
                  style: const TextStyle(fontSize: 20),
                ),
                const Icon(Icons.location_on)
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
                width: double.infinity,
                child: Text("Description",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Text(
                  event.idNavigation!.description!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
            buildDetailRow("Tourist agency", event.agency!.name!),
            buildDetailRow("Tourist guide",
                "${event.agencyMember!.appUser!.firstName!} ${event.agencyMember!.appUser!.lastName!}"),
            buildDetailRow("Duration", "${getDuration()} hours"),
            buildDetailRow("Date", formatStringDate(event.date!)),
            buildDetailRow("Time", timeToString(event.fromTime!)),
            buildDetailRow("Price", "${event.pricePerPerson.toString()} KM"),
            const SizedBox(height: 20),
            btnBuyTicket(),
            buildReviews()
          ]),
        )
      ]),
    ));
  }

  String getDuration() {
    // var duration = event.toTime! - event.fromTime!;
    // return timeToString(duration);

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

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: gallery != null ? gallery.length : 0,
        effect: const ScrollingDotsEffect(
            dotWidth: 10,
            dotHeight: 10,
            dotColor: Colors.grey,
            activeDotColor: Colors.blueGrey),
      );

  _buildCarouselSlider(BuildContext context) {
    if (loading) {
      return Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 197, 194, 194),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    } else if (!hasImages && gallery?.length == 0) {
      return Container(
        height: 300,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 197, 194, 194),
        ),
        child: const Center(
            child: Text("There are no currently available pictures...")),
      );
    } else {
      return CarouselSlider(
          options: CarouselOptions(
              autoPlay: gallery.length > 1 ? true : false,
              autoPlayCurve: Curves.easeInBack,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              height: 300.0,
              viewportFraction: 1,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index)),
          items: gallery
              .map((i) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0))),
                    child: Image.memory(base64Decode(i.image!),
                        fit: BoxFit.cover, gaplessPlayback: true),
                  );
                });
              })
              .toList()
              .cast<Widget>());
    }
  }
}
