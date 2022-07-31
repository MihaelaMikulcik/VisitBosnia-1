// import 'dart:html';
// import 'dart:html';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visit_bosnia_mobile/components/buy_ticket_dialog.dart';
import 'package:visit_bosnia_mobile/model/events/event.dart';
import 'package:visit_bosnia_mobile/providers/event_provicer.dart';

class EventDetails extends StatefulWidget {
  EventDetails(this.event, {Key? key}) : super(key: key);
  Event event;

  @override
  State<EventDetails> createState() => _EventDetailsState(event);
}

class _EventDetailsState extends State<EventDetails> {
  // late EventProvider _eventProvider;
  Event event;
  _EventDetailsState(this.event);
  int activeIndex = 0;
  dynamic response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        CarouselSlider(
          options: CarouselOptions(
              height: 300.0,
              viewportFraction: 1,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index)),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0))),
                    child: Text(
                      'text $i',
                      style: TextStyle(fontSize: 16.0),
                    ));
              },
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        buildIndicator(),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                  event.name!,
                  // "Višegrad, Andrićgrad and Drvengrad tour",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                )),
                Column(children: [
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
            SizedBox(height: 5),
            Row(
              children: [
                Text(
                  "Višegrad",
                  style: TextStyle(fontSize: 20),
                ),
                Icon(Icons.location_on)
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.only(top: 10.0),
                // color: Colors.red,
                child: Text(
                  "Description",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                padding: EdgeInsets.only(top: 10.0, bottom: 20.0),
                // color: Colors.red,
                child: Text(
                  event.description!,
                  // "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            buildDetailRow("Tourist agency", "Meet Bosnia Tours"),
            buildDetailRow("Tourist guide", "Adnan Hodzic"),
            buildDetailRow("Duration", "7-8 hours"),
            buildDetailRow("Date", event.date!),
            buildDetailRow("Time", "${event.fromTime.toString()} AM"),
            buildDetailRow("Price", "${event.pricePerPerson.toString()} KM"),
            SizedBox(height: 20),
            btnBuyTicket(),
            buildReviews()
          ]),
        )
      ]),
    ));
  }

  Widget buildReviews() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(children: [
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
                          child: Text(event.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22))),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            event.date.toString(),
                            style: TextStyle(color: Colors.grey, fontSize: 19),
                          ),
                          Icon(
                            Icons.access_time,
                            color: Colors.grey,
                          )
                        ],
                      ),
                      SizedBox(height: 10),
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
            color: Color.fromARGB(255, 211, 75, 70),
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
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(left: 20),
            child: Text(value, style: TextStyle(fontSize: 18)),
          ),
        ),
        SizedBox(height: 30)
      ],
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: 5,
        effect: const ScrollingDotsEffect(
            dotWidth: 10,
            dotHeight: 10,
            dotColor: Colors.grey,
            activeDotColor: Colors.blueGrey),
      );
}
