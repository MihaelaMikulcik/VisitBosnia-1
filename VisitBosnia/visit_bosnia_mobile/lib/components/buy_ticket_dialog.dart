import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../model/events/event.dart';

class BuyTicketDialog extends StatefulWidget {
  BuyTicketDialog(this.event, {Key? key}) : super(key: key);
  Event event;
  @override
  State<BuyTicketDialog> createState() => _BuyTicketDialogState(event);
}

class _BuyTicketDialogState extends State<BuyTicketDialog> {
  int _count = 0;
  double _price = 0;
  Event event;
  _BuyTicketDialogState(this.event);

  void incrementCount() {
    setState(() => _count++);
    setState(() {
      _price += event.pricePerPerson!;
    });
  }

  void decrementCount() {
    if (_count < 1) return;
    setState(() => _count--);
    setState(() {
      _price -= event.pricePerPerson!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20.0),
          color: Color.fromARGB(64, 102, 101, 99),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    // flex: 1,
                    child: Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: const Text("People",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: decrementCount,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 56, 54, 54))),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(Icons.remove),
                                    ))),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: const Color.fromARGB(
                                            255, 56, 54, 54))),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                  child: Text("$_count",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                )),
                            InkWell(
                                onTap: incrementCount,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 56, 54, 54))),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(Icons.add),
                                    )))
                          ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    // flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Text("Price",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.only(left: 20),
                      child: Align(
                          alignment: Alignment.center,
                          child: Text("${_price.toString()} KM",
                              style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 211, 75, 70),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 40,
                width: 120,
                child: Center(
                    child: Text(
                  "Buy",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))),
          ),
        )
      ],
    );
  }
}
