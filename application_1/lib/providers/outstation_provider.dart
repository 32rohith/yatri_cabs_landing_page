import 'package:flutter_riverpod/flutter_riverpod.dart';

//tab index for outstation trip
final tabIndexProvider = StateProvider<int>((ref) => 0);


//one way
final onewayOutpickUpCityProvider = StateProvider<String>((ref) => "");
final onewayOutdropCityProvider = StateProvider<String>((ref) => "");
final onewayOutpickUpDateProvider = StateProvider<DateTime?>((ref) => null);
final onewayOutpickUpTimeProvider = StateProvider<String>((ref) => "");

//round trip
final roundtripOutpickUpCityProvider = StateProvider<String>((ref) => '');
final roundtripOutdropCityProvider = StateProvider<String>((ref) => '');
final roundtripOutfromDateProvider = StateProvider<DateTime?>((ref) => null);
final roundtripOuttoDateProvider = StateProvider<DateTime?>((ref) => null);
final roundtripOutpickUpTimeProvider = StateProvider<String>((ref) => '');
