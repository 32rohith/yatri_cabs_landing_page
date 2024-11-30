// airport_transfer_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

//tab for airport tab
final airporttabIndexProvider = StateProvider<int>((ref) => 0);

//from airport
final fromAirportPickUpCityProvider = StateProvider<String>((ref) => "");
final fromAirportPickUpDateProvider = StateProvider<String>((ref) => "");
final fromAirportPickUpTimeProvider = StateProvider<String>((ref) => "");

//to airport
final toAirportPickUpCityProvider = StateProvider<String>((ref) => "");
final toAirportPickUpDateProvider = StateProvider<DateTime?>((ref) => null);
final toAirportPickUpTimeProvider = StateProvider<String>((ref) => "");