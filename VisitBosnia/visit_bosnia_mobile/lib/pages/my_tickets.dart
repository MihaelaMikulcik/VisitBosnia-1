// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/eventOrder/event_order.dart';
import 'package:visit_bosnia_mobile/model/transactions/transaction.dart';
import 'package:visit_bosnia_mobile/model/transactions/transaction_search_object.dart';
import 'package:visit_bosnia_mobile/pages/event_details2.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
import 'package:visit_bosnia_mobile/providers/tourist_facility_gallery_provider.dart';
import 'package:visit_bosnia_mobile/providers/transaction_provider.dart';
import 'package:visit_bosnia_mobile/utils/util.dart';

import '../components/navigation_drawer.dart';
import '../model/touristFacilityGallery/tourist_facility_gallery.dart';
import '../model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';

class MyTickets extends StatefulWidget {
  const MyTickets({Key? key}) : super(key: key);
  static const String routeName = "/myTickets";
  @override
  State<MyTickets> createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
  late TransactionProvider _transactionProvider;
  late TouristFacilityGalleryProvider _touristFacilityGalleryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _transactionProvider = context.read<TransactionProvider>();
    _touristFacilityGalleryProvider =
        context.read<TouristFacilityGalleryProvider>();
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

  Future<List<Transaction>?> GetData() async {
    try {
      List<Transaction> transactions;
      var search = TransactionSearchObject(
          appUserId: AppUserProvider.userData.id,
          status: "succeeded",
          includeEventOrder: true);
      transactions = await _transactionProvider.get(search.toJson());
      return transactions;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: _buildTicketsList()),
          ]),
        ));
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(top: 25.0, left: 25.0),
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
                "My tickets ",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Icon(CupertinoIcons.ticket, size: 30)
            ],
          ),
          Expanded(
              child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Tickets for your events",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
          ))
        ],
      ),
    );
  }

  Widget _buildImage(int facilityId) {
    return FutureBuilder<String?>(
        future: getImage(facilityId),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong...'),
              );
            } else {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
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

  Widget _buildEventText(EventOrder eventOrder) {
    NumberFormat formatter = NumberFormat();
    formatter.minimumFractionDigits = 2;
    formatter.maximumFractionDigits = 2;
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              eventOrder.event!.idNavigation!.name!.length > 25
                  ? eventOrder.event!.idNavigation!.name!.substring(0, 25)
                  : eventOrder.event!.idNavigation!.name!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                formatStringDate(eventOrder.event!.date!, 'EEE, MMM d') +
                    ', ' +
                    timeToString(eventOrder.event!.fromTime!),
                style: TextStyle(fontSize: 18),
              ),
              Icon(Icons.access_time)
            ],
          ),
          Row(
            children: [
              Text(
                '${formatter.format(eventOrder.price!)} BAM, ${eventOrder.quantity!}x',
                style: TextStyle(fontSize: 18),
              ),
              Icon(Icons.person)
            ],
          )
        ],
      ),
    );
  }

  Widget _ticketWidget(Transaction transaction) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                EventDetails2(transaction.eventOrder!.event!.id!)));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(offset: Offset(0, 10), blurRadius: 10, color: Colors.grey)
          ],
        ),
        height: 220,
        child: Column(children: [
          Expanded(
            child: _buildImage(transaction.eventOrder!.eventId!),
          ),
          Expanded(child: _buildEventText(transaction.eventOrder!))
        ]),
      ),
    );
  }

  Widget _buildTicketsList() {
    return FutureBuilder<List<Transaction>?>(
        future: GetData(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Transaction>?> snapshot) {
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
              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        padding: EdgeInsets.only(bottom: 20),
                        height: 90,
                        width: 90,
                        child: Image.asset("assets/images/no_ticket.png")),
                    Text('No tickets yet...', style: TextStyle(fontSize: 17)),
                  ],
                );
              } else {
                return ListView(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  children:
                      snapshot.data!.map((e) => _ticketWidget(e)).toList(),
                );
              }
            }
          }
        });
  }
}
