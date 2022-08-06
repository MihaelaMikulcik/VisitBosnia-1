import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visit_bosnia_mobile/model/id_navigation.dart';
import 'package:visit_bosnia_mobile/providers/tourist_facility_provider.dart';

import '../model/touristFacilityGallery/tourist_facility_gallery_search_object.dart';
import '../providers/tourist_facility_gallery_provider.dart';

class TouristFacilityInfo extends StatefulWidget {
  TouristFacilityInfo(this.touristFacility, {Key? key}) : super(key: key);
  IdNavigation touristFacility;

  @override
  State<TouristFacilityInfo> createState() =>
      _TouristFacilityInfoState(touristFacility);
}

class _TouristFacilityInfoState extends State<TouristFacilityInfo> {
  late TouristFacilityGalleryProvider _touristFacilityGalleryProvider;
  late TouristFacilityProvider _touristFacilityProvider;
  IdNavigation touristFacility;
  _TouristFacilityInfoState(this.touristFacility);
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
    _touristFacilityProvider = context.read<TouristFacilityProvider>();
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
        TouristFacilityGallerySearchObject(facilityId: touristFacility.id);
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
    return Column(children: [
      _buildCarouselSlider(context),
      const SizedBox(height: 10),
      buildIndicator(),
      Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    touristFacility.name!,
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
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )
                  ])
                ],
              ),
              Row(
                children: [
                  Text(
                    // "Višegrad",
                    touristFacility.city!.name!,
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
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold))),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Text(
                    touristFacility.description!,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ))
    ]);
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
