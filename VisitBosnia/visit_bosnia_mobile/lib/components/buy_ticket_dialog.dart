import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';
import 'package:visit_bosnia_mobile/model/credit_card.dart';
import 'package:visit_bosnia_mobile/model/transactions/transaction.dart';
import 'package:visit_bosnia_mobile/model/transactions/transaction_insert_request.dart';
import 'package:visit_bosnia_mobile/providers/appuser_provider.dart';
import 'package:visit_bosnia_mobile/providers/transaction_provider.dart';

import '../model/events/event.dart';

class BuyTicketDialog extends StatefulWidget {
  BuyTicketDialog(this.event, {Key? key}) : super(key: key);
  Event event;
  @override
  State<BuyTicketDialog> createState() => _BuyTicketDialogState(event);
}

class _BuyTicketDialogState extends State<BuyTicketDialog> {
  _BuyTicketDialogState(this.event);
  int _count = 0;
  double _price = 0;
  Event event;

  late AppUserProvider _appUserProvider;
  late TransactionProvider _transactionProvider;

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  final TextEditingController _mmyyController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _showError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _appUserProvider = context.read<AppUserProvider>();
    _transactionProvider = context.read<TransactionProvider>();
  }

  void incrementCount() {
    setState(() {
      _count++;
      _price += event.pricePerPerson!;
    });
    if (_count > 0) {
      setState(() => _showError = false);
    }
  }

  void decrementCount() {
    if (_count < 1) return;
    setState(() {
      _count--;
      _price -= event.pricePerPerson!;
    });
    if (_count == 0) {
      setState(() => _showError = true);
    }
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
        Visibility(
          visible: _showError,
          child: Text(
            "Please select the number of people!",
            style: TextStyle(color: Colors.red),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: () {
              if (_count != 0) {
                _showPaymentModal();
              } else {
                setState(() {
                  _showError = true;
                });
              }
            },
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

  _showPaymentModal() {
    Navigator.pop(context);
    showModalBottomSheet(
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              "Create payment",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          ),
                          Image(
                            image: AssetImage("assets/images/payment.png"),
                            height: 40,
                            width: 40,
                          ),
                        ],
                      ),
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Icon(Icons.close))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        _count.toString() + "x",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      Text(
                        ", " + _price.toString() + " KM",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _txtCreditCard(),
                          Row(
                            children: [_txtMMYY(), _txtCVC()],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  MaterialButton(
                    onPressed: () {
                      _makePayment(context);
                    },
                    color: Color.fromARGB(255, 211, 75, 70),
                    child: Text(
                      "Pay now",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    minWidth: MediaQuery.of(context).size.width,
                    height: 40,
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> _makePayment(context) async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      try {
        var mmyy = _mmyyController.text.split('/');
        CreditCard card = CreditCard(
            cvc: _cvcController.text,
            number: _cardNumberController.text,
            expMonth: mmyy[0],
            expYear: mmyy[1]);
        var request = TransactionInsertRequest(
            creditCard: card,
            eventId: event.id,
            quantity: _count,
            price: _price,
            description: event.idNavigation!.name,
            appUserId: _appUserProvider.userData.id);
        var response = await _transactionProvider.ProcessTransaction(request);
        if (response != null) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Container(
                height: 40,
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                    ),
                    Text(
                      " Successfully paid!",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ],
                ),
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Color.fromARGB(255, 3, 131, 78)));
        }
      } catch (e) {
        _showErrorMessage(context, e.toString());
      }
    }
  }

  _showErrorMessage(context, String message) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
        height: 40,
        child: Row(
          children: [
            Icon(
              Icons.error,
              color: Colors.white,
            ),
            Text(" Payment failed!",
                style: TextStyle(color: Colors.white, fontSize: 19)),
          ],
        ),
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Color.fromARGB(255, 179, 45, 40),
    ));
  }

  Widget _txtCreditCard() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return "";
        }
        return null;
      },
      controller: _cardNumberController,
      keyboardType: TextInputType.number,
      inputFormatters: [CreditCardNumberInputFormatter()],
      decoration: const InputDecoration(
          suffixIcon: Icon(Icons.credit_card),
          contentPadding:
              EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
          hintText: "Card number",
          errorStyle: TextStyle(height: 0),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }

  Widget _txtMMYY() {
    return Flexible(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          }
          return null;
        },
        keyboardType: TextInputType.number,
        inputFormatters: [CreditCardExpirationDateFormatter()],
        controller: _mmyyController,
        decoration: const InputDecoration(
            contentPadding:
                EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            hintText: "MM/YY",
            errorStyle: TextStyle(height: 0),
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
    );
  }

  Widget _txtCVC() {
    return Flexible(
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "";
          }
          return null;
        },
        keyboardType: TextInputType.number,
        inputFormatters: [CreditCardCvcInputFormatter()],
        controller: _cvcController,
        decoration: const InputDecoration(
            contentPadding:
                EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
            hintText: "CVC",
            errorStyle: TextStyle(height: 0),
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
      ),
    );
  }
}
