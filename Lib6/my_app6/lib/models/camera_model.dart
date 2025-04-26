// camera_model.dart # Модели данных Camera
class Camera {
  final int id;
  final String name;
  final int roverId;
  final String fullName;

  Camera({
    required this.id,
    required this.name,
    required this.roverId,
    required this.fullName,
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      id: json['id'],
      name: json['name'],
      roverId: json['rover_id'],
      fullName: json['full_name'],
    );
  }
}