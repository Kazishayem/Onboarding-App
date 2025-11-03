
Onboarding App

project Screenshots 

All screenshots are stored in the assets/Screenshots/{images} directory.

Features
1. Onboarding Screens
- 3 onboarding screens following the given design:
•	Sync with nature’s rhythm  
•	Effortless automatic syncing  
•	Relax and unwind  
- Skip button to bypass onboarding  
- Smooth screen navigation  

2. Location Access
- Request location permission
- Fetch current device location
- Display selected location on UI  

3. Alarm & Notifications
- Set alarms using time picker
- Display alarm list with time & date
- Built with flutter_local_notifications + timezone



4. Architecture
- BLoC pattern
- Clean folder structure
- Services for alarms & location
- Reusable widgets  

Folder Structure
lib/
 ├─ blocs/
 │   └─ onboarding/
 │       ├─ onboarding_bloc.dart
 │       ├─ onboarding_event.dart
 │       └─ onboarding_state.dart
 ├─ models/
 │   └─ onboarding_page_model.dart
 ├─ screens/
 │   ├─ dashboard/
 │   │   └─ DashboardPage.dart
 │   ├─ HomePage/
 │   │   └─ home_screen.dart
 │   └─ onboarding/
 │       └─ onboarding_screen.dart
 ├─ services/
 │   ├─ alarm_service.dart
 │   └─ location_service.dart
 ├─ widgets/
 │   └─ alarm_tile.dart
 └─ main.dart
Package	Purpose
flutter_bloc------State management
equatable-----Immutable state comparison
geolocator-----Fetch device location
geocoding-----Convert coordinates to address
permission_handler------Request OS permissions
flutter_local_notifications-----Alarm notification handling
timezone------Accurate alarm scheduling
intl----Date formatting

Setup Instructions
1. Clone the repo:
git clone https://github.com/Kazishayem/Onboarding-App.git
cd Onboarding-App

2. Install dependencies:
flutter pub get

3. Run:
flutter run

Author
Kazi Sayem Mahamood
Email: kazishayem1234@gmail.com

