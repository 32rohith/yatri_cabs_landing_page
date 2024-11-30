// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:application_1/providers/airport_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/cityfield.dart';
import '../../../components/my_textfield.dart';

/// From Airport Form
class FromAirportForm extends ConsumerStatefulWidget {
  const FromAirportForm({super.key});

  @override
  _FromAirportFormState createState() => _FromAirportFormState();
}

class _FromAirportFormState extends ConsumerState<FromAirportForm> {
  late TextEditingController pickUpCityController;
  late TextEditingController pickUpDateController;
  late TextEditingController pickUpTimeController;

  @override
  void initState() {
    super.initState();
    pickUpCityController = TextEditingController();
    pickUpDateController = TextEditingController();
    pickUpTimeController = TextEditingController();
  }

  @override
  void dispose() {
    pickUpCityController.dispose();
    pickUpDateController.dispose();
    pickUpTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Pick-Up City Field using CityField widget
        CityField(
          imageurl: "assets/images/pickup.png",
          labelText: "Pickup Airport",
          hintText: "Type City Name",
          controller: pickUpCityController,  
          cityProvider: fromAirportPickUpCityProvider,  
          onClear: () {
            ref.read(fromAirportPickUpCityProvider.notifier).state = "";  
            pickUpCityController.clear(); 
          },
        ),
        
        // Pick-Up Date Field
        CustomInputField(
          labelText: "Pickup Date",
          hintText: "DD-MM-YYYY",
          controller: pickUpDateController,  
          prefixImage: const AssetImage("assets/images/calendar.png"),
          readOnly: true,
          showClearButton: false,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
            if (date != null) {
              ref.read(fromAirportPickUpDateProvider.notifier).state =
                  "${date.day}/${date.month}/${date.year}";  
              pickUpDateController.text = "${date.day}/${date.month}/${date.year}";  
            }
          },
        ),
        
        // Pick-Up Time Field
        CustomInputField(
          labelText: "Time",
          hintText: "HH:MM",
          controller: pickUpTimeController,  
          prefixImage: const AssetImage("assets/images/clock.png"),
          readOnly: true,
          showClearButton: false,
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              ref.read(fromAirportPickUpTimeProvider.notifier).state = time.format(context);  
              pickUpTimeController.text = time.format(context); 
            }
          },
        ),
      ],
    );
  }
}
