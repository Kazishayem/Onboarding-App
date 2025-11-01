import 'package:equatable/equatable.dart';
import '../../models/location_model.dart';

class LocationState extends Equatable {
  final bool isLoading;
  final bool permissionGranted;
  final LocationModel? location;
  final String? error;

  const LocationState({
    this.isLoading = false,
    this.permissionGranted = false,
    this.location,
    this.error,
  });

  LocationState copyWith({
    bool? isLoading,
    bool? permissionGranted,
    LocationModel? location,
    String? error,
  }) {
    return LocationState(
      isLoading: isLoading ?? this.isLoading,
      permissionGranted: permissionGranted ?? this.permissionGranted,
      location: location ?? this.location,
      error: error,
    );
  }

  @override
  List<Object?> get props => [isLoading, permissionGranted, location, error];
}
