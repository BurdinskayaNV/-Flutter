// api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class NasaApi {
  //static const String _baseUrl = 'https://api.nasa.gov/mars-photos/api/v1/rovers/opportunity/photos';
  //static const String _apiKey = 'eQnprvXukgfNomTanZiHT1DqLApcABzFjI350dyZ';
  static const String _baseUrl = 'https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos';
  static const String _apiKey = 'eQnprvXukgfNomTanZiHT1DqLApcABzFjI350dyZ';

  static Future<List<Map<String, dynamic>>> getMarsPhotos(int sol) async {
    try {
      final url = '$_baseUrl?sol=$sol&api_key=$_apiKey';
      print('Request URL: $url');
      
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['photos'].isEmpty) {
          throw Exception('No photos available for sol $sol');
        }

        return (data['photos'] as List).map<Map<String, dynamic>>((photo) {
          return {
            'url': _ensureHttps(photo['img_src']),
            'title': photo['camera']['full_name'],
            'date': photo['earth_date'],
            'media_type': 'image'
          };
        }).toList();
      } else {
        throw Exception('Request failed: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API error: $e');
    }
  }

  static String _ensureHttps(String url) {
    return url.startsWith('http://') 
      ? url.replaceFirst('http://', 'https://')
      : url;
  }
}