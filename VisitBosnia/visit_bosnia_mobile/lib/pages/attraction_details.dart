import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class AttractionDetails extends StatefulWidget {
  const AttractionDetails({Key? key}) : super(key: key);

  @override
  State<AttractionDetails> createState() => _AttractionDetailsState();
}

class _AttractionDetailsState extends State<AttractionDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 200,
        width: 500,
        child: FlutterMap(
          options: MapOptions(
            center: LatLng(43.859675, 18.4312194444),
            zoom: 18.0,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayerOptions(markers: [
              Marker(
                  point: LatLng(43.859675, 18.4312194444),
                  builder: (context) => Icon(
                        Icons.pin_drop,
                        size: 40,
                        color: Color.fromARGB(255, 240, 76, 64),
                      ))
            ])
          ],
          // nonRotatedChildren: [
          //   AttributionWidget.defaultWidget(
          //     source: 'OpenStreetMap contributors',
          //     onSourceTapped: null,
          //   ),
          // ],
        ),
      ),
    ));
  }
}
