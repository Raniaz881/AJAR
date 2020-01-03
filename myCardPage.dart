import 'dart:math';

import 'package:ajar_app/payment/card_back.dart';
import 'package:ajar_app/payment/card_front.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyCardPage extends StatefulWidget {
  @override
  _MyCardPageState createState() => _MyCardPageState();
}

class _MyCardPageState extends State<MyCardPage>
    with SingleTickerProviderStateMixin {
  double _rotationFactor = 0;
  AnimationController _flipAnimationController;
  Animation<double> _flipAnimation;
  TextEditingController _cardHolderNameController,
      _cardNumberController,
      _cvvController,
      _cardExpiryController;

  FocusNode _cvvFocus;
  String _cardNumber = '';

  String _cardHolderName = '';
  String _cardExpiry = '';
  String _cvvNumber = '';

  _MyCardPageState() {
    _cardNumberController = TextEditingController();
    _cardHolderNameController = TextEditingController();
    _cvvController = TextEditingController();

    _cardExpiryController = TextEditingController();
    _cvvFocus = FocusNode();

    _cardNumberController.addListener(onCardNumberChange);
    _cardHolderNameController.addListener(() {
      _cardHolderName = _cardHolderNameController.text;
      setState(() {});
    });

    _cardNumberController.addListener(() {
      _cardNumber = _cardNumberController.text;
      setState(() {});
    });
    _cvvController.addListener(() {
      _cvvNumber = _cvvController.text;
      setState(() {});
    });
    _cardExpiryController.addListener(() {
      _cardExpiry = _cardExpiryController.text;
      setState(() {});
    });

    _cvvFocus.addListener(() {
      _cvvFocus.hasFocus
          ? _flipAnimationController.forward()
          : _flipAnimationController.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    _flipAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );
    _flipAnimation =
        Tween<double>(begin: 0, end: 1).animate(_flipAnimationController)
          ..addListener(() {
            setState(() {});
          });
    // _flipAnimationController.forward();
  }

  void onCardNumberChange() {
    _cardNumber = _cardNumberController.text;
    setState(() {});
  }

  Widget floatingBar() => Ink(
        decoration: ShapeDecoration(
          shape: StadiumBorder(),
        ),
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          icon: Icon(
            FontAwesomeIcons.amazonPay,
            color: Colors.white,
          ),
          label: Text(
            "Continue",
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        backgroundColor: Color(0xFF3B8079),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(pi * _flipAnimation.value),
                origin: Offset(MediaQuery.of(context).size.width / 2, 0),
                child: _flipAnimation.value < 0.5
                    ? CardFrontView(
                        cardNumber: _cardNumber,
                        cardHolderName: _cardHolderName,
                        cardExpiry: _cardExpiry,
                      )
                    : CardBackView(
                        cvvNumber: _cvvNumber,
                      )),
            Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.all(16),
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Material(
                    
                    child: Column(
                      children: <Widget>[
                        //Slider(
                        //  onChanged: (double value){
                        //    setState(() {
                        //    _rotationFactor = value;
//
                        //  });
                        // },
                        //  value: _rotationFactor,
                        //  ),
                        TextField(
                          decoration:
                              InputDecoration(hintText: 'Card Holder Name'),
                          controller: _cardHolderNameController,
                          maxLength: 10,
                        ),
                        TextField(
                          decoration: InputDecoration(hintText: 'Card Number'),
                          controller: _cardNumberController,
                          maxLength: 16,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: TextField(
                                decoration:
                                    InputDecoration(hintText: 'Expiry Date'),
                                controller: _cardExpiryController,
                                maxLength: 6,
                              ),
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Expanded(
                              flex: 1,

                              child: TextField(
                                controller: _cvvController,
                                focusNode: _cvvFocus,
                                maxLength: 3,
                                decoration: InputDecoration(
                                    counterText: '', hintText: 'CVV'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButton<String>(
                          value: dropdownValue,
                          icon: Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          underline: Container(
                            height: 2,
                            width: 80,
                            color: Colors.deepPurpleAccent,

                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              dropdownValue = newValue;
                            });
                          },
                          items: <String>['One', 'Two', 'Three', 'Four']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
