import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';
import 'package:visit_bosnia_mobile/model/attractions/attraction.dart';
import 'package:visit_bosnia_mobile/model/events/event_search_object.dart';
import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery.dart';
import 'package:visit_bosnia_mobile/model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';
import 'package:visit_bosnia_mobile/pages/attraction_details.dart';
import 'package:visit_bosnia_mobile/pages/event_details.dart';
import 'package:visit_bosnia_mobile/pages/event_details2.dart';
import 'package:visit_bosnia_mobile/providers/attraction_provider.dart';
import 'package:visit_bosnia_mobile/providers/event_provider.dart';
import 'package:visit_bosnia_mobile/providers/tourist_facility_gallery_provider.dart';

import '../components/navigation_drawer.dart';
import '../model/attractions/attraction_search_object.dart';
import '../model/events/event.dart';
import '../utils/util.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homepage";

  Homepage({Key? key, required this.user}) : super(key: key);
  AppUser user;

  @override
  State<Homepage> createState() => _HomepageState(user);
}

class _HomepageState extends State<Homepage> {
  _HomepageState(this.user);
  late EventProvider _eventProvider;
  late AttractionProvider _attractionProvider;
  late TouristFacilityGalleryProvider _touristFacilityGalleryProvider;

  AppUser user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventProvider = context.read<EventProvider>();
    _attractionProvider = context.read<AttractionProvider>();
    _touristFacilityGalleryProvider =
        context.read<TouristFacilityGalleryProvider>();
  }

  Future<List<Event>> loadEvents() async {
    var search = EventSearchObject(
        includeAgency: true,
        includeAgencyMember: true,
        includeIdNavigation: true);
    var events = await _eventProvider.get(search.toJson());
    return events;
  }

  Future<List<Attraction>> loadAttractions() async {
    var search = AttractionSearchObject(includeIdNavigation: true);
    var attractions = await _attractionProvider.get(search.toJson());
    return attractions;
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
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Column(children: [
              SizedBox(
                width: double.infinity,
                child: Text("Attractions",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Container(
                height: 220,
                child: _buildAttractions(),
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "View all",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 102, 101, 101)),
                        ),
                        Icon(Icons.arrow_forward,
                            color: Color.fromARGB(255, 102, 101, 101))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Text("Events",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 10),
              Container(
                height: 220,
                child: _buildEvents(),
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0, right: 10.0),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "View all",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 102, 101, 101)),
                        ),
                        Icon(Icons.arrow_forward,
                            color: Color.fromARGB(255, 102, 101, 101))
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _eventCard(Event event) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventDetails2(event)));
      },
      child: Container(
        height: 220,
        width: 150,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(20)),
        child: Text(event.idNavigation!.name!),
      ),
    );
  }

  Widget _attractionCard(Attraction attraction) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AttractionDetails(attraction)));
      },
      child: Container(
        height: 220,
        width: 150,
        margin: EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
            color: Colors.amber, borderRadius: BorderRadius.circular(20)),
        child: Text(attraction.idNavigation!.name!),
      ),
    );
  }

  _buildAttractions() {
    return FutureBuilder<List<Attraction>>(
        future: loadAttractions(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Attraction>> snapshot) {
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
              return ListView(
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                children:
                    snapshot.data!.map((e) => _attractionCard(e)).toList(),
              );
            }
          }
        });
  }

  _buildEvents() {
    return FutureBuilder<List<Event>>(
        future: loadEvents(),
        builder: (BuildContext context, AsyncSnapshot<List<Event>> snapshot) {
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
              return ListView(
                scrollDirection: Axis.horizontal,
                physics: ScrollPhysics(),
                children: snapshot.data!.map((e) => _eventCard(e)).toList(),
              );
            }
          }
        });
  }
}
