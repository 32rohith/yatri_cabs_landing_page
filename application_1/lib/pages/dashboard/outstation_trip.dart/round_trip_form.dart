// ignore_for_file: unused_local_variable, library_private_types_in_public_api, use_build_context_synchronously

import 'package:application_1/providers/outstation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;

import '../../../components/cityfield.dart';
import '../../../components/my_textfield.dart';
import '../../../components/form_body.dart';

/// Round-Trip Trip Form
class RoundTripForm extends ConsumerStatefulWidget {
  const RoundTripForm({super.key});

  @override
  _RoundTripFormState createState() => _RoundTripFormState();
}

class _RoundTripFormState extends ConsumerState<RoundTripForm> {
  late TextEditingController pickUpCityController;
  late TextEditingController dropCityController;
  late TextEditingController timeController;

  @override
  void initState() {
    super.initState();
    pickUpCityController = TextEditingController();
    dropCityController = TextEditingController();
    timeController = TextEditingController();
  }

  @override
  void dispose() {
    pickUpCityController.dispose();
    dropCityController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600; 

    final pickUpCity = ref.watch(roundtripOutpickUpCityProvider);
    final dropCity = ref.watch(roundtripOutdropCityProvider);
    final fromDate = ref.watch(roundtripOutfromDateProvider);
    final toDate = ref.watch(roundtripOuttoDateProvider);

    final formattedFromDate = fromDate != null ? intl.DateFormat('dd-MM-yyyy').format(fromDate) : '';
    final formattedToDate = toDate != null ? intl.DateFormat('dd-MM-yyyy').format(toDate) : '';

    return FormBody(
      fields: [
        // Pick-Up City Field
        CityField(
          imageurl: "assets/images/pickup.png",
          labelText: "Pickup City",
          hintText: "Type City Name",
          controller: pickUpCityController, 
          cityProvider: roundtripOutpickUpCityProvider, 
          onClear: () {
            ref.read(roundtripOutpickUpCityProvider.notifier).state = ""; 
            pickUpCityController.clear(); 
          },
        ),

        // Drop City Field
        CityField(
          imageurl: "assets/images/drop.png",
          labelText: "Destination",
          hintText: "Type City Name",
          controller: dropCityController, 
          cityProvider: roundtripOutdropCityProvider,
          onClear: () {
            ref.read(roundtripOutdropCityProvider.notifier).state = ""; 
            dropCityController.clear(); 
          },
        ),

        // Pick-Up Time Field
        CustomInputField(
          labelText: "Time",
          hintText: "HH:MM",
          prefixImage: const AssetImage("assets/images/time.png"),
          controller: timeController,
          readOnly: true,
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (time != null) {
              timeController.text = time.format(context);
              ref.read(roundtripOutpickUpTimeProvider.notifier).state = time.format(context);
            }
          },
        ),

        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFD5F2C8),
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: () async {
              final selectedDateRange = await showDateRangePicker(
                context: context,
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: Colors.green,
                      buttonTheme: const ButtonThemeData(
                        textTheme: ButtonTextTheme.primary,
                        buttonColor: Colors.green,
                      ),
                    ),
                    child: child!,
                  );
                },
                initialDateRange: DateTimeRange(
                  start: fromDate ?? DateTime.now(),
                  end: toDate ?? DateTime.now().add(const Duration(days: 1)),
                ),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
          
              if (selectedDateRange != null) {
                ref.read(roundtripOutfromDateProvider.notifier).state = selectedDateRange.start;
                ref.read(roundtripOuttoDateProvider.notifier).state = selectedDateRange.end;
              }
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: isSmallScreen
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.center,
                  children: [
                    _buildDateColumn(
                      label: "From Date",
                      date: formattedFromDate.isEmpty ? "DD-MM-YYYY" : formattedFromDate,
                      isSmallScreen: isSmallScreen,
                    ),
                    if (!isSmallScreen) const SizedBox(width: 50.0), 
                    IconButton(
                      icon: Image.asset("assets/images/calendar.png", width: isSmallScreen ? 24.0 : 30.0),
                      onPressed: () async {
                        final selectedDateRange = await showDateRangePicker(
                          context: context,
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                primaryColor: Colors.green,
                                buttonTheme: const ButtonThemeData(
                                  textTheme: ButtonTextTheme.primary,
                                  buttonColor: Colors.green,
                                ),
                              ),
                              child: child!,
                            );
                          },
                          initialDateRange: DateTimeRange(
                            start: fromDate ?? DateTime.now(),
                            end: toDate ?? DateTime.now().add(const Duration(days: 1)),
                          ),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
          
                        if (selectedDateRange != null) {
                          ref.read(roundtripOutfromDateProvider.notifier).state = selectedDateRange.start;
                          ref.read(roundtripOuttoDateProvider.notifier).state = selectedDateRange.end;
                        }
                      },
                    ),
                    if (!isSmallScreen) const SizedBox(width: 50.0),
                    _buildDateColumn(
                      label: "To Date",
                      date: formattedToDate.isEmpty ? "DD-MM-YYYY" : formattedToDate,
                      isSmallScreen: isSmallScreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateColumn({
    required String label,
    required String date,
    required bool isSmallScreen,
  }) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isSmallScreen ? 14.0 : 16.0,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          date,
          style: TextStyle(
            fontSize: isSmallScreen ? 12.0 : 14.0,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  void resetFields() {
    ref.read(roundtripOutpickUpCityProvider.notifier).state = "";
    ref.read(roundtripOutdropCityProvider.notifier).state = "";
    ref.read(roundtripOutfromDateProvider.notifier).state = null;
    ref.read(roundtripOuttoDateProvider.notifier).state = null;
    timeController.clear();
  }
}
