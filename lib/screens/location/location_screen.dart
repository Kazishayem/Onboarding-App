import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onboarding_app/models/location_model.dart';
import 'package:onboarding_app/blocs/location/location_bloc.dart';
import 'package:onboarding_app/blocs/location/location_event.dart';
import 'package:onboarding_app/blocs/location/location_state.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationBloc()..add(RequestLocationPermission()),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Selected Location"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color.fromARGB(255, 99, 52, 166), Color(0xff000000)],
            ),
          ),
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              // 🔄 Loading state
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              }

              // ❌ Error / Denied state
              if (state.error != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Colors.redAccent,
                        size: 50,
                      ),
                      const SizedBox(height: 15),
                      Text(
                        state.error!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LocationBloc>().add(
                            RequestLocationPermission(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(180, 50),
                        ),
                        child: const Text(
                          "Try Again",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                );
              }

              // ✅ Permission granted + location fetched
              if (state.permissionGranted && state.location != null) {
                final loc = state.location!;
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.white,
                          size: 70,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Latitude: ${loc.latitude.toStringAsFixed(4)}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "Longitude: ${loc.longitude.toStringAsFixed(4)}",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (loc.address != null && loc.address!.isNotEmpty) ...[
                          const SizedBox(height: 15),
                          Text(
                            loc.address!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                        const SizedBox(height: 50),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(context, '/home');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minimumSize: const Size(double.infinity, 55),
                          ),
                          child: const Text(
                            "Back to Home",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // 🔹 Default UI (no permission requested yet)
              return Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<LocationBloc>().add(
                      RequestLocationPermission(),
                    );
                  },
                  icon: const Icon(Icons.my_location, color: Colors.white),
                  label: const Text("Request Location"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(200, 55),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
