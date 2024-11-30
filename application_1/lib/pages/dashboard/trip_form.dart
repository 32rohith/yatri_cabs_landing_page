import 'package:flutter/material.dart';

import 'airport_transfer.dart/airport.dart';
import 'local_trip/local.dart';
import 'outstation_trip.dart/outstation.dart';

class TripForm extends StatelessWidget {
  final int selectedTab;

  const TripForm({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    Widget child;
    switch (selectedTab) {
      case 0:
        child = const OutstationTripForm();
        break;
      case 1:
        child = const LocalTripForm();
        break;
      case 2:
        child = const AirportTransferForm();
        break;
      default:
        child = const SizedBox();
    }

    return Flexible( 
      fit: FlexFit.loose,
      child: child,
    );
  }
}
