// ignore_for_file: use_build_context_synchronously

import 'package:application_1/components/cityfield.dart';
import 'package:application_1/providers/outstation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../components/my_textfield.dart';
import '../../../components/form_body.dart';

class OneWayForm extends ConsumerWidget {
  const OneWayForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController pickUpController = TextEditingController();
    final  TextEditingController dropOffController = TextEditingController();

    return FormBody(
      fields: [
        // Pick-Up City Field
        CityField(
          imageurl: "assets/images/pickup.png",
          labelText: "Pick-Up City",
          hintText: "Type City Name",
          controller: pickUpController, 
          cityProvider: onewayOutpickUpCityProvider,
          onClear: () {
            pickUpController.clear(); 
            ref.read(onewayOutpickUpCityProvider.notifier).state = ""; 
          },
        ),

        // Drop City Field
        CityField(
          imageurl: "assets/images/drop.png",
          labelText: "Drop City",
          hintText: "Type City Name",
          controller: dropOffController, 
          cityProvider: onewayOutdropCityProvider,
          onClear: () {
            dropOffController.clear(); 
            ref.read(onewayOutdropCityProvider.notifier).state = ""; 
          },
        ),

        // Pick-Up Date Field
        CustomInputField(
          labelText: "Pick-Up Date",
          hintText: "DD-MM-YYYY",
          prefixImage: const AssetImage("assets/images/calendar.png"),
          controller: TextEditingController(
            text: ref.watch(onewayOutpickUpDateProvider)?.toLocal().toString().split(' ')[0],
          ),
          readOnly: true,
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2101),
            );
            if (date != null) {
              ref.read(onewayOutpickUpDateProvider.notifier).state = date;
            }
          },
        ),

        // Pick-Up Time Field
        CustomInputField(
          labelText: "Pick-Up Time",
          hintText: "HH:MM",
          prefixImage: const AssetImage("assets/images/clock.png"),
          controller: TextEditingController(
            text: ref.watch(onewayOutpickUpTimeProvider),
          ),
          readOnly: true,
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              ref.read(onewayOutpickUpTimeProvider.notifier).state = time.format(context);
            }
          },
        ),
      ],
    );
  }
}
