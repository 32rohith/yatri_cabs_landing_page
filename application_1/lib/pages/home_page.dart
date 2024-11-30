// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

import 'account_page.dart';
import 'dashboard/dashboard_page.dart';
import 'more_page.dart';
import 'my_trip_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const MyTripPage(),
    const AccountPage(),
    const MorePage(), // More page
  ];

  // Define image paths for nav icons
  final List<String> _navIcons = [
    'assets/images/home.png',
    'assets/images/mytrip.png',
    'assets/images/account.png',
    'assets/images/more.png',
  ];

  final List<String> _navLabels = [
    'Dashboard',
    'My Trip',
    'Account',
    'More',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double iconSize = screenWidth * 0.06;

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.2),
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.green,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: List.generate(
            _navIcons.length,
            (index) => BottomNavigationBarItem(
              icon: Image.asset(
                _navIcons[index],
                color: _selectedIndex == index ? Colors.black : Colors.white,
                width: iconSize,
                height: iconSize,
              ),
              label: _navLabels[index],
            ),
          ),
        ),
      ),
    );
  }
}
