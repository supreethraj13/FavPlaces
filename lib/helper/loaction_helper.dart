import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// DO NOT load the key here as a global variable.
// final String? GOOGLE_api_key = dotenv.env['GOOGLEapi_key'];  <-- REMOVE THIS LINE

class LoactionHelper {
  static String locationpreviewimg({
    required double latitude,
    required double longitude,
  }) {
    // Load the key *inside* the method
    final String? GOOGLE_api_key = dotenv.env['GOOGLEapi_key'];

    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:%7C$latitude,$longitude&key=$GOOGLE_api_key';
  }

  static Future<String> getplaceaddress(double lat, double lng) async {
    // Load the key *inside* the method
    final String? GOOGLE_api_key = dotenv.env['GOOGLEapi_key'];

    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_api_key';
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}