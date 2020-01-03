
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardFrontView extends StatelessWidget {

  final String cardNumber;
  final String cardHolderName;
  final String cardExpiry;

  String _formattedCardNumber;
  String _formattedExpiryDate;

  CardFrontView(
      {Key key, this.cardNumber, this.cardHolderName, this.cardExpiry})
      : super(key: key) {
    _formattedCardNumber = this.cardNumber.padRight(16, '*');
    _formattedCardNumber = _formattedCardNumber.replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)} ");
    _formattedExpiryDate =
        this.cardExpiry.replaceAllMapped(RegExp(r".{2}"), (match) => "${match.group(0)}/");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 300,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
       elevation: 8,
        margin: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
               child: Image.asset('assets/images/vissa.jpg')
              ),
              SizedBox(
                height: 32,
              ),

              Text(
                _formattedCardNumber,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily:'Robot',
                  wordSpacing: 2,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w500 ,
                  shadows:[Shadow(color: Colors.black,
                      offset: Offset(2, 1))]
              ),
              ),
              SizedBox(
                height: 32,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Card Holder'),
                      Text(cardHolderName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          letterSpacing: 2,
                            fontSize: 20,
                            fontWeight:FontWeight.w500 ),),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Expiry'),
                      Text(
                        _formattedExpiryDate,
                        style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 20,
                            fontWeight:FontWeight.w500 ),


                      ),
                    ],
                  ),
                ],

              ),

            ],
          ),
        ),
      ),
    );
  }
}
