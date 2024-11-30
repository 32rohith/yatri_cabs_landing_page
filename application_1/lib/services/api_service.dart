// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';

class CityApiService {
  static const String _baseUrl = 'http://api.geonames.org/searchJSON';

  static Future<List<String>> fetchCitySuggestions(String query) async {
    if (query.isEmpty) return [];

    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?q=$query&maxRows=10&username=32rohith19'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> cities = data['geonames'];

        List<String> cityNames = [];
        for (var city in cities) {
          cityNames.add(city['name']);
        }

        return cityNames;
      } else {
        throw Exception('Failed to load city suggestions');
      }
    } catch (e) {
      print('Error fetching cities: $e');
      return [];
    }
  }
}
