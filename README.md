# Flutter Weather App

A multi-page Flutter application that displays real-time weather data using the OpenWeatherMap API.

## Features
- **Search:** Search for weather conditions in any city.
- **Real-time Data:** Displays temperature, humidity, wind speed, and weather icons.
- **Favorites:** Save your favorite cities for quick access using local storage.
- **Settings:** Toggle between Metric (°C) and Imperial (°F) units.
- **State Management:** Built using Provider.
## Getting Started

### Prerequisites
- Flutter SDK installed
- An API Key from OpenWeatherMap

### Setup
1. Clone the repository.
2. Navigate to the project directory.
3. Install dependencies:
   ```bash
   flutter pub get
   
   Add your API Key:
Go to lib/services/weather_service.dart
Replace 'c4b4e3fbdb3ebb656100407163fc750a' with your actual key

Run the app:
flutter run

Folder Structure
lib/models: Data models for API response.
lib/services: API handling logic.
lib/providers: State management logic.
lib/pages: UI Screens (Home, Details, Favorites, Settings).


