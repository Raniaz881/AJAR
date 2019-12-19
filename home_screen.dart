import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:home_page/apartment.dart';
import 'package:home_page/apartment_carousel.dart';
import 'package:home_page/office_carousel.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  

  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 120.0),
              child: Text(
                'Welcome To Ajar',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40.0),
            ApartmentsCarousel(),
            SizedBox(height: 20.0),
            OfficeCarousel(),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFFB2DFDB),
        height: 50,

        items: <Widget>[
          Icon(Icons.home, size: 30, color: Color(0xFF354241),),
          Icon(Icons.chat_bubble_outline, size: 30,  color: Color(0xFF354241
          ),),
          Icon(Icons.payment, size: 30, color: Color(0xFF354241
          ),),
          Icon(Icons.insert_drive_file, size: 30, color: Color(0xFF354241
          ),),
        ],
        animationDuration: Duration(
          milliseconds: 250
        ),

        onTap: (index) {
          debugPrint("Current Index is $index");
          //Handle button tap
        },
      ),

    );

  }
}

