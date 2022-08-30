// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:visit_bosnia_mobile/components/tourist_facility_info.dart';
// import 'package:visit_bosnia_mobile/model/attractions/attraction.dart';

// import '../components/review_facility.dart';

// class AttractionDetails extends StatefulWidget {
//   AttractionDetails(this.attraction, {Key? key}) : super(key: key);
//   Attraction attraction;
//   @override
//   State<AttractionDetails> createState() => _AttractionDetailsState(attraction);
// }

// class _AttractionDetailsState extends State<AttractionDetails> {
//   _AttractionDetailsState(this.attraction);
//   Attraction attraction;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Column(
//         children: [
//           TouristFacilityInfo(attraction.idNavigation!),
//           Padding(
//             padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: double.infinity,
//                   child: Text("Location",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 150,
//                   width: MediaQuery.of(context).size.width,
//                   child: FlutterMap(
//                     options: MapOptions(
//                       center: LatLng(attraction.geoLat!, attraction.geoLong!),
//                       zoom: 16.0,
//                       maxZoom: 18.0,
//                     ),
//                     layers: [
//                       TileLayerOptions(
//                         urlTemplate:
//                             "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//                         userAgentPackageName: 'com.example.app',
//                       ),
//                       MarkerLayerOptions(markers: [
//                         Marker(
//                             point:
//                                 LatLng(attraction.geoLat!, attraction.geoLong!),
//                             builder: (context) => Icon(
//                                   Icons.location_on,
//                                   size: 40,
//                                   color: Color.fromARGB(255, 240, 76, 64),
//                                 ))
//                       ])
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           ReviewFacility(attraction.idNavigation!),
//         ],
//       ),
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:http/http.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/components/tourist_facility_info.dart';
import 'package:visit_bosnia_mobile/model/attractions/attraction.dart';
import 'package:visit_bosnia_mobile/providers/attraction_provider.dart';

import '../components/review_facility.dart';

class AttractionDetails extends StatefulWidget {
  AttractionDetails(this.attractionId, {Key? key}) : super(key: key);
  int attractionId;
  @override
  State<AttractionDetails> createState() =>
      _AttractionDetailsState(attractionId);
}

class _AttractionDetailsState extends State<AttractionDetails> {
  _AttractionDetailsState(this.attractionId);
  int attractionId;

  // late Attraction attraction;
  late AttractionProvider _attractionProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _attractionProvider = context.read<AttractionProvider>();
    // GetData(attractionId);
  }

  Future<Attraction?> GetData(int attractionId) async {
    try {
      var temp = await _attractionProvider.getById(attractionId);
      return temp;
      // attraction = temp;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: FutureBuilder<Attraction?>(
      future: GetData(attractionId),
      builder: (BuildContext context, AsyncSnapshot<Attraction?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            // color: Color.fromRGBO(29, 76, 120, 1),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: CircularProgressIndicator(
                    // color: Colors.white,
                    )),
          );
        } else {
          if (snapshot.hasData) {
            return Column(
              children: [
                TouristFacilityInfo(snapshot.data!.idNavigation!),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Text("Location",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: FlutterMap(
                          options: MapOptions(
                            center: LatLng(snapshot.data!.geoLat!,
                                snapshot.data!.geoLong!),
                            zoom: 16.0,
                            maxZoom: 18.0,
                          ),
                          layers: [
                            TileLayerOptions(
                              urlTemplate:
                                  "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                              userAgentPackageName: 'com.example.app',
                            ),
                            MarkerLayerOptions(markers: [
                              Marker(
                                  point: LatLng(snapshot.data!.geoLat!,
                                      snapshot.data!.geoLong!),
                                  builder: (context) => Icon(
                                        Icons.location_on,
                                        size: 40,
                                        color: Color.fromARGB(255, 240, 76, 64),
                                      ))
                            ])
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ReviewFacility(snapshot.data!.idNavigation!),
              ],
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child: Text("Something went wrong...")),
            );
          }
        }
      },
    )));
  }
}
