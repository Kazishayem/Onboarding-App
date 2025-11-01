import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final double latitude;
  final double longitude;
  final String? address;

  const LocationModel({
    required this.latitude,
    required this.longitude,
    this.address,
  });

  @override
  List<Object?> get props => [latitude, longitude, address];

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }

  @override
  String toString() =>
      'Lat: ${latitude.toStringAsFixed(4)}, Lng: ${longitude.toStringAsFixed(4)}';
}
// import 'package:equatable/equatable.dart';

// class LocationModel extends Equatable {
//   final double latitude;
//   final double longitude;

//   const LocationModel({
//     required this.latitude,
//     required this.longitude,
//   });

//   @override
//   List<Object> get props => [latitude, longitude];

//   @override
//   String toString() => 'Lat: $latitude, Lng: $longitude';
// }
