import 'package:http/http.dart' as http;
import 'dart:convert';


const GOOGLE_api_key = 'AIzaSyDskZPJRTcd9q8A9WfkXQeGtk4W8nQOgbY';

class LoactionHelper {
  static String locationpreviewimg({
    required double latitude,
    required double longitude,
  }) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:%7C$latitude,$longitude&key=$GOOGLE_api_key';
  }

  static Future<String> getplaceaddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_api_key';
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
