// ignore_for_file: use_build_context_synchronously

import 'package:application_1/providers/airport_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/cityfield.dart'; 
import '../../../components/my_textfield.dart';

/// To Airport Form
class ToAirportForm extends ConsumerWidget {
  const ToAirportForm({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Pick-Up Airport
        CityField(
          imageurl: "assets/images/pickup.png",
          labelText: "Pickup City",
          hintText: "Type City Name",
          controller: TextEditingController(text: ref.watch(toAirportPickUpCityProvider)),
          cityProvider: toAirportPickUpCityProvider,  
          onClear: () {
            ref.read(toAirportPickUpCityProvider.notifier).state = "";  
          },
        ),
        
        // Pick-Up Date Field
        CustomInputField(
          labelText: "Pickup Date",
          hintText: "DD-MM-YYYY",
          controller: TextEditingController(text: ref.watch(toAirportPickUpDateProvider)?.toLocal().toString().split(' ')[0]),
          prefixImage: const AssetImage("assets/images/calendar.png"),
          readOnly: true,
          showClearButton: false,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (date != null) {
              ref.read(toAirportPickUpDateProvider.notifier).state = date; 
            }
          },
        ),
        
        // Pick-Up Time Field
        CustomInputField(
          labelText: "Time",
          hintText: "HH:MM",
          controller: TextEditingController(text: ref.watch(toAirportPickUpTimeProvider)),
          prefixImage: const AssetImage("assets/images/clock.png"),
          readOnly: true,
          showClearButton: false,
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              ref.read(toAirportPickUpTimeProvider.notifier).state = time.format(context);  
            }
          },
        ),
      ],
    );
  }
}
