// airport_transfer_form.dart
import 'package:application_1/components/form_body.dart';
import 'package:application_1/providers/airport_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'from_airport.dart';
import 'to_airport.dart';

class AirportTransferForm extends ConsumerWidget {
  const AirportTransferForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(airporttabIndexProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FormBody(
        fields: [ Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              _buildTabBar(ref, tabIndex),
              const SizedBox(height: 16.0),
              SingleChildScrollView(  
                child: tabIndex == 0
                    ? const ToAirportForm() // To Airport form
                    : const FromAirportForm(), // From Airport form
              ),
            ],
          ),
        ),
        ],
      ),
    );
  }

  Widget _buildTabBar(WidgetRef ref, int tabIndex) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTab(
            label: "To the Airport",
            isSelected: tabIndex == 0,
            onTap: () => ref.read(airporttabIndexProvider.notifier).state = 0,
          ),
          const SizedBox(width: 8.0),
          _buildTab(
            label: "From the Airport",
            isSelected: tabIndex == 1,
            onTap: () => ref.read(airporttabIndexProvider.notifier).state = 1,
          ),
        ],
    );
  }

  Widget _buildTab({required String label, required bool isSelected, required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            decoration: BoxDecoration(
              color: isSelected ? Colors.green : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green, width: 2.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
