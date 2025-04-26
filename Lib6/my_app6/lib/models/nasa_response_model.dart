// nasa_response_model.dart
import 'photo_model.dart';

class NasaResponse {
  final List<Photo> photos;

  NasaResponse({required this.photos});

  factory NasaResponse.fromJson(Map<String, dynamic> json) {
    var photosJson = json['photos'] as List;
    List<Photo> photosList = photosJson.map((i) => Photo.fromJson(i)).toList();
    return NasaResponse(photos: photosList);
  }
}