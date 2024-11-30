import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/outstation_provider.dart';
import 'one_way_form.dart';
import 'round_trip_form.dart';

class OutstationTripForm extends ConsumerWidget {
  const OutstationTripForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabIndex = ref.watch(tabIndexProvider);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildTabBar(ref, tabIndex),
            const SizedBox(height: 16.0),
            if (tabIndex == 0) const OneWayForm() else const RoundTripForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(WidgetRef ref, int tabIndex) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildTab(
          label: "One-Way",
          isSelected: tabIndex == 0,
          onTap: () => ref.read(tabIndexProvider.notifier).state = 0,
        ),
        const SizedBox(width: 8.0),
        _buildTab(
          label: "Round Trip",
          isSelected: tabIndex == 1,
          onTap: () => ref.read(tabIndexProvider.notifier).state = 1,
        ),
      ],
    );
  }

  Widget _buildTab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 30.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green, width: 2.0),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.green,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
