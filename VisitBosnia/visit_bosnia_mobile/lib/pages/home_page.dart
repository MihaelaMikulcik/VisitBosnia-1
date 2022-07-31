import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/appUser/app_user.dart';
import 'package:visit_bosnia_mobile/pages/event_details.dart';
import 'package:visit_bosnia_mobile/providers/event_provicer.dart';

import '../components/navigation_drawer.dart';
import '../model/events/event.dart';

class Homepage extends StatefulWidget {
  static const String routeName = "/homepage";

  Homepage({Key? key, required this.user}) : super(key: key);
  AppUser user;

  @override
  State<Homepage> createState() => _HomepageState(user);
}

class _HomepageState extends State<Homepage> {
  _HomepageState(this.user);
  EventProvider? _eventProvider = null;
  AppUser user;
  List<Event> events = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _eventProvider = context.read<EventProvider>();
    loadData();
  }

  Future loadData() async {
    var tempData = await _eventProvider?.get();
    setState(() {
      events = tempData!;
    });
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
              Row(
                children: [
                  Text("Events",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 220,
                child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 6 / 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15),
                    scrollDirection: Axis.horizontal,
                    children: _buildEventCardList()),
              ),
              SizedBox(
                width: double.infinity,
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
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

  List<Widget> _buildEventCardList() {
    if (events.length == 0) {
      return [Text("Loadind...")];
    }
    List<Widget> list = events
        .map((x) => InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => EventDetails(x)));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
                height: 220,
                width: 200,
                child: Text(x.name ?? ""),
              ),
            ))
        .cast<Widget>()
        .toList();
    return list;
  }
}
