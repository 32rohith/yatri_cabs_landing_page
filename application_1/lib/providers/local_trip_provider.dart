// local_trip_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider for pick-up city
final localpickUpCityProvider = StateProvider<String>((ref) => "");

// Provider for pick-up date
final localpickUpDateProvider = StateProvider<DateTime?>((ref) => null);

// Provider for pick-up time
final localpickUpTimeProvider = StateProvider<String>((ref) => "");
