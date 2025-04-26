// photo_model.dart # Модели данных Photo
import 'camera_model.dart';
import 'rover_model.dart';

class Photo {
  final int id;
  final int sol;
  final Camera camera;
  final String imgSrc;
  final String earthDate;
  final Rover rover;

  Photo({
    required this.id,
    required this.sol,
    required this.camera,
    required this.imgSrc,
    required this.earthDate,
    required this.rover,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      sol: json['sol'],
      camera: Camera.fromJson(json['camera']),
      imgSrc: json['img_src'],
      earthDate: json['earth_date'],
      rover: Rover.fromJson(json['rover']),
    );
  }
}