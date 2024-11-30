// lib/screens/local_trip_form.dart

// ignore_for_file: use_build_context_synchronously

import 'package:application_1/providers/local_trip_provider.dart';  // Import providers file
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../components/cityfield.dart';
import '../../../components/my_textfield.dart';
import '../../../components/form_body.dart';

class LocalTripForm extends ConsumerWidget {
  const LocalTripForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FormBody(
        fields: [
          CityField(
            imageurl: "assets/images/pickup.png",
            labelText: "Pickup City",
            hintText: "Type City Name",
            controller: TextEditingController(
              text: ref.watch(localpickUpCityProvider),
            ),
            cityProvider: localpickUpCityProvider, 
            onClear: () {
              ref.read(localpickUpCityProvider.notifier).state = ""; 
            },
          ),

          CustomInputField(
            labelText: "Pickup Date",
            hintText: "DD-MM-YYYY",
            controller: TextEditingController(
              text: ref.watch(localpickUpDateProvider)?.toLocal().toString().split(' ')[0],
            ),
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
                ref.read(localpickUpDateProvider.notifier).state = date;
              }
            },
          ),
          CustomInputField(
            labelText: "Time",
            hintText: "HH:MM",
            controller: TextEditingController(
              text: ref.watch(localpickUpTimeProvider), 
            ),
            prefixImage: const AssetImage("assets/images/time.png"),
            readOnly: true,
            showClearButton: false,
            onTap: () async {
              final time = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (time != null) {
                ref.read(localpickUpTimeProvider.notifier).state = time.format(context);
              }
            },
          ),
        ],
      ),
    );
  }
}
