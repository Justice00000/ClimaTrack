# **CLIMATRACK - A Weather Tracking App**

## **Table of Contents**
1. [Introduction](#introduction)  
2. [Features](#features)  
3. [Technologies Used](#technologies-used)  
4. [Setup and Installation](#setup-and-installation)  
5. [Usage](#usage)  
6. [File Structure](#file-structure)  

---

## **Introduction**
**CLIMATRACK** is a mobile application built with Flutter that allows users to:  

- Search for real-time weather updates by city name.  
- View weather details, such as temperature and weather description.  
- Favorite cities for quick access to their weather data.  
- Enjoy a smooth user interface with animations.  

The app integrates with an external weather API to fetch accurate weather data and uses state management for a responsive experience.  

---

## **Features**
- **Search Weather by City**: Retrieve weather details for any city in the world.  
- **Favorites Management**: Save and view a list of favorite cities with their respective weather updates.  
- **Error Handling**: Displays error messages for invalid or unavailable cities.  
- **Responsive Design**: Works seamlessly on both emulators and physical devices.  
- **Animations**: Fade-in effects for weather results and error messages.  

---

## **Technologies Used**
1. **Framework**: [Flutter](https://flutter.dev/)  
2. **Programming Language**: Dart  
3. **Weather API**: OpenWeatherMap API (or your chosen weather API)  
4. **Development Tools**:
   - Visual Studio Code
   - Android Studio/Emulator or a physical device  
5. **Version Control**: [Git](https://git-scm.com/) and [GitHub](https://github.com/)

---

## **Setup and Installation**
Follow these steps to set up and run the app on your local environment.

### **Prerequisites**
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed.  
- [Dart](https://dart.dev/get-dart) installed (comes with Flutter).  
- Android Studio or any other IDE supporting Flutter.  
- Weather API key from [OpenWeatherMap](https://openweathermap.org/).  

### **Installation**
1. Clone the repository:  
   ```bash
   git clone https://github.com/Justice00000/climatrack.git
   cd climatrack

## Installation

### Install dependencies:
```bash
flutter pub get

---

## Add Your API Key
  1. Navigate to `lib/services/weather_service.dart`.
  2. Replace `<YOUR_API_KEY>` with your OpenWeatherMap API key.


## Run the App
To launch the app on an emulator or physical device, execute the following command:

```bash
  flutter run

# Usage
1. Open the app on your emulator or device.
2. Enter a city name in the search bar and press the search icon.
3. View the weather details, including:
   - **City name**
   - **Temperature (in °C)**
   - **Weather description**
4. Tap the heart icon to favorite/unfavorite the city's weather.
5. Scroll down to view your list of favorite cities.
6. Tap the remove icon to delete a city from your favorites.



---

## File Structure
Here’s an overview of the key files and their responsibilities:

```bash
lib/
├── models/
│   └── weather_model.dart      # Defines the Weather data structure
├── services/
│   └── weather_service.dart    # Handles API requests to fetch weather data
├── screens/
│   └── home_screen.dart        # UI and logic for the home screen
├── widgets/
│   └── weather_widget.dart     # Reusable widget for displaying weather data
├── main.dart                   # App entry point
