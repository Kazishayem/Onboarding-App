// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:geolocator/geolocator.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'location_event.dart';
// // import 'location_state.dart';
// // import '../../models/location_model.dart';

// // class LocationBloc extends Bloc<LocationEvent, LocationState> {
// //   LocationBloc() : super(const LocationState()) {
// //     on<RequestLocationPermission>(_onRequestPermission);
// //     on<FetchCurrentLocation>(_onFetchLocation);
// //   }

// //   Future<void> _onRequestPermission(
// //       RequestLocationPermission event, Emitter<LocationState> emit) async {
// //     emit(state.copyWith(isLoading: true));

// //     final status = await Permission.location.request();

// //     if (status.isGranted) {
// //       emit(state.copyWith(permissionGranted: true, isLoading: false));
// //       add(FetchCurrentLocation());
// //     } else {
// //       emit(state.copyWith(
// //         isLoading: false,
// //         permissionGranted: false,
// //         error: 'Location permission denied',
// //       ));
// //     }
// //   }

// //   Future<void> _onFetchLocation(
// //       FetchCurrentLocation event, Emitter<LocationState> emit) async {
// //     emit(state.copyWith(isLoading: true));

// //     try {
// //       Position position = await Geolocator.getCurrentPosition(
// //         desiredAccuracy: LocationAccuracy.high,
// //       );

// //       final model = LocationModel(
// //         latitude: position.latitude,
// //         longitude: position.longitude,
// //       );

// //       emit(state.copyWith(location: model, isLoading: false));
// //     } catch (e) {
// //       emit(state.copyWith(error: e.toString(), isLoading: false));
// //     }
// //   }
// // }
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'location_event.dart';
// import 'location_state.dart';
// import '../../models/location_model.dart';

// class LocationBloc extends Bloc<LocationEvent, LocationState> {
//   LocationBloc() : super(const LocationState()) {
//     on<RequestLocationPermission>(_onRequestPermission);
//     on<FetchCurrentLocation>(_onFetchLocation);
//   }

//   /// 🔹 Step 1: Request Permission
//   Future<void> _onRequestPermission(
//     RequestLocationPermission event,
//     Emitter<LocationState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true, error: null));

//     final status = await Permission.location.request();

//     if (status.isGranted) {
//       emit(state.copyWith(permissionGranted: true, isLoading: false));
//       add(FetchCurrentLocation());
//     } else if (status.isPermanentlyDenied) {
//       await openAppSettings();
//       emit(
//         state.copyWith(
//           isLoading: false,
//           permissionGranted: false,
//           error:
//               'Permission permanently denied. Please enable it from settings.',
//         ),
//       );
//     } else {
//       emit(
//         state.copyWith(
//           isLoading: false,
//           permissionGranted: false,
//           error: 'Location permission denied by user.',
//         ),
//       );
//     }
//   }

//   /// 🔹 Step 2: Fetch Current Location
//   Future<void> _onFetchLocation(
//     FetchCurrentLocation event,
//     Emitter<LocationState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true, error: null));

//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         emit(
//           state.copyWith(
//             isLoading: false,
//             error: 'Location services are disabled. Please enable them.',
//           ),
//         );
//         return;
//       }

//       Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );

//       final model = LocationModel(
//         latitude: position.latitude,
//         longitude: position.longitude,
//       );

//       emit(state.copyWith(location: model, isLoading: false));
//     } catch (e) {
//       emit(
//         state.copyWith(
//           error: 'Failed to get current location: $e',
//           isLoading: false,
//         ),
//       );
//     }
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'location_event.dart';
import 'location_state.dart';
import '../../models/location_model.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(const LocationState()) {
    on<RequestLocationPermission>(_onRequestPermission);
    on<FetchCurrentLocation>(_onFetchLocation);
  }

  Future<void> _onRequestPermission(
      RequestLocationPermission event, Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoading: true, error: null));

    final status = await Permission.location.request();

    if (status.isGranted) {
      emit(state.copyWith(permissionGranted: true, isLoading: false));
      add(FetchCurrentLocation());
    } else if (status.isPermanentlyDenied) {
      // 🚫 ইউজার permanently deny করেছে — settings খুলে দিতে পারি
      emit(state.copyWith(
        isLoading: false,
        permissionGranted: false,
        error:
            'Location permission permanently denied. Please enable it from Settings.',
      ));
      await openAppSettings();
    } else {
      emit(state.copyWith(
        isLoading: false,
        permissionGranted: false,
        error: 'Location permission denied by user',
      ));
    }
  }

  Future<void> _onFetchLocation(
      FetchCurrentLocation event, Emitter<LocationState> emit) async {
    emit(state.copyWith(isLoading: true));

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final model = LocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
      );

      emit(state.copyWith(location: model, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }
}
