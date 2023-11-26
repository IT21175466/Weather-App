import 'dart:convert';
import 'package:http/http.dart' as http;

class CityImageRepo {
  final String apiKey = 'AIzaSyDWlxEQU9GMmFEmZwiT3OGVVxTyc984iNY';

  Future<String> getCityImage(String cityName) async {
    final apiUrl =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$cityName&inputtype=textquery&fields=photos&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final photoReference = json.decode(response.body)['candidates'][0]
          ['photos'][0]['photo_reference'];
      final imageUrl =
          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=1080&maxheight=1920&photoreference=$photoReference&key=$apiKey';

      return imageUrl;
    } else {
      throw Exception('Failed to load city image');
    }
  }
}
