// ignore_for_file: unused_field, library_private_types_in_public_api, sized_box_for_whitespace

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'trip_selector.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentTab = 0;
  int _currentIndex = 0;

  final List<String> _banners = [
    'assets/images/banner1.png',
    'assets/images/banner1.png',
    'assets/images/banner1.png',
    'assets/images/banner1.png',
  ];

  @override
  Widget build(BuildContext context) {
    // Get device screen size
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logo.png', 
              height: screenWidth * 0.1, 
            ),
            const Icon(Icons.notifications, color: Colors.white),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), 
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "India’s Leading ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045, 
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: "Inter-City\n",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: screenWidth * 0.045, 
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: "One Way ",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: screenWidth * 0.045, 
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextSpan(
                      text: "Cab Service Provider",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045, 
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: screenWidth,
              height: screenHeight * 0.2,
              child: Stack(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: false,
                      viewportFraction: 1.0, 
                      aspectRatio: 3, 
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                    items: _banners.map((banner) {
                      return Container(
                        margin: EdgeInsets.all(screenWidth * 0.02), 
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: AssetImage(banner),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Positioned(
                    bottom: screenHeight * 0.05, 
                    left: screenWidth * 0.5 - (screenWidth * 0.02 * _banners.length / 2), 
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _banners.asMap().entries.map((entry) {
                        return Container(
                          width: screenWidth * 0.02, 
                          height: screenWidth * 0.02,
                          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentIndex == entry.key
                                ? Colors.green
                                : Colors.black,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            TripSelector(
              onTabChanged: (index) {
                setState(() {
                  _currentTab = index;
                });
              },
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Image.asset(
                'assets/images/bottom.png', 
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
