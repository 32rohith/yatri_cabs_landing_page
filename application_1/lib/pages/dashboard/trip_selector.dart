// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'trip_form.dart';

class TripSelector extends StatefulWidget {
  final Function(int) onTabChanged;

  const TripSelector({super.key, required this.onTabChanged});

  @override
  _TripSelectorState createState() => _TripSelectorState();
}

class _TripSelectorState extends State<TripSelector> {
  int selectedTab = 0;

  final List<String> _tabs = ['Outstation Trip', 'Local Trip', 'Airport Transfer'];
  final List<String> _tabIcons = [
    'assets/images/outstation.png', 
    'assets/images/local.png', 
    'assets/images/airport.png', 
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, 
      children: [
        // Tab Selector
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: List.generate(_tabs.length, (index) {
            return Expanded( 
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0), 
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTab = index;
                    });
                    widget.onTabChanged(index);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0), 
                    decoration: BoxDecoration(
                      color: selectedTab == index ? Colors.green : Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        // Tab Icon
                        ColorFiltered(
                          colorFilter: selectedTab == index
                              ? const ColorFilter.mode(Colors.white, BlendMode.srcIn) 
                              : const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                          child: Image.asset(
                            _tabIcons[index],
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Text(
                          _tabs[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: selectedTab == index ? Colors.white : Colors.black,
                            fontSize: 14, 
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 2),
        
        TripForm(selectedTab: selectedTab),
      ],
    );
  }
}
