# Social App

Welcome to the Social App repository! This Flutter app is designed to provide a comprehensive social networking experience, featuring Firebase authentication, Cloud Firestore for data storage, Firebase Storage for image storage, validation, shared preferences, icons, animations, and more.

#### [Video](https://www.linkedin.com/posts/mohamed-elhalawany-329314220_socail-app-a-flutter-app-made-using-activity-7113898662946091009-ub71?utm_source=share&utm_medium=member_desktop)

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Getting Started](#getting-started)
   - [Prerequisites](#prerequisites)
   - [Installation](#installation)
4. [Project Structure](#project-structure)
5. [Usage](#usage)
6. [Dependencies](#dependencies)
8. [Feedback](#feedback)
9. [Follow Me](#follow-me)

## Overview

The Social App is a Flutter-based social networking application that leverages Firebase services to provide users with a seamless experience. With features like Firebase Authentication, Cloud Firestore, Firebase Storage, validation, shared preferences, icons, animations, and state management using Bloc, this app aims to showcase best practices in Flutter development.

## Features

- **Firebase Authentication:** Utilizes Firebase Authentication for secure user sign-in and registration.

- **Firebase Core:** Integrates Firebase Core to enable the use of Firebase services.

- **Cloud Firestore:** Utilizes Cloud Firestore for real-time data storage and retrieval.

- **Firebase Storage:** Implements Firebase Storage for storing and retrieving user-uploaded images.

- **Validation:** Provides robust validation for user inputs.

- **Professionally Shared Preferences:** Securely stores user data and preferences using shared preferences.

- **Iconly Broken:** Utilizes the Iconly Broken icon set for a modern and stylish user interface.

- **Animation Splash Screen:** Welcomes users with an engaging splash screen animation for a visually appealing start to the app.

- **Loading Animation:** Displays loading animations during data retrieval or processing.

- **Image Picker:** Allows users to pick images from their device.

- **Theme (Light, Dark) Mode:** Supports both light and dark themes for user customization.

- **Reusable Components:** Promotes code reusability by incorporating reusable components for a more modular and maintainable codebase.

- **Google Fonts:** Enhances the typography of the app using Google Fonts.

- **State Management (Bloc):** Adopts the Bloc pattern for efficient state management.

- **Shimmer Animation (Skeletons):** Enhances user experience with shimmer animations (skeletons) during data loading.

- **Toast:** Displays toast messages to provide feedback to users.

## Getting Started
### Prerequisites

- Ensure you have Flutter and Dart installed on your development machine. For installation instructions, refer to the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/Halawany1/Ecommerce_App.git
1. Navigate to the project directory:
    ```bash
   cd Ecommerce_App
2. Install dependencies:
    ```bash
   flutter pub get

## Project Structure

The project is structured as follows:

- **lib/**: Contains the main source code of the application.
- **lib/network/** : Handles API-related functionalities.
- **lib/helper/** : Contains the bloc observer to tracking stated of the application.
- **lib/shared/** : Includes reusable components used throughout the app.
- **lib/modules/** : Contains different screens of the application.
- **lib/models/** :  Contains different models of the application.
- **lib/bloc/** : Implements Cubit for state management.
- **lib/constants** : Contains constant shared attributes of the application.
  
## Usage
- To run the app on an emulator or physical device, use the following command:
   ```bash
   flutter run
   
## Dependencies

The E-Commerce App relies on the following key dependencies, each serving a specific purpose:

- **`cupertino_icons`**: Provides Cupertino style icons for iOS.

- **`dio`**: A powerful HTTP client for Dart, utilized for efficient handling of API requests.

- **`bloc`**: A predictable state management library for Flutter applications.

- **`flutter_bloc`**: The Flutter-specific implementation of the BLoC pattern for state management.

- **`conditional_builder_null_safety`**: A package for conditionally building widgets based on certain conditions, ensuring null safety.

- **`google_fonts`**: Enables the use of Google Fonts in the Flutter app.

- **`loading_animation_widget`**: A package for displaying loading animations during data retrieval or processing.

- **`animated_splash_screen`**: Facilitates the creation of animated splash screens for a visually appealing start to the app.

- **`fluttertoast`**: A Flutter package for displaying toast messages.

- **`iconly`**: A package providing the Iconly icon set for a modern and stylish user interface.

- **`shared_preferences`**: Provides a persistent key-value store for secure storage of user preferences.

- **`image_picker`**: Allows users to pick images from their device.

- **`firebase_messaging`**: Integrates Firebase Cloud Messaging for handling push notifications.

- **`skeletons`**: A package for implementing shimmer animations (skeletons) during data loading.

- **`scrollable_positioned_list`**: A package for creating a scrollable list with a positioned element.

### Firebase Dependencies

The E-Commerce App also relies on the following Firebase dependencies:

- **`firebase_core`**: Initializes Firebase for Flutter applications.

- **`firebase_auth`**: Provides Firebase Authentication for secure user sign-in and registration.

- **`cloud_firestore`**: Utilizes Cloud Firestore for real-time data storage and retrieval.

- **`firebase_storage`**: Implements Firebase Storage for storing and retrieving user-uploaded images.

For a complete list of dependencies, refer to the `pubspec.yaml` file.

Feel free to customize or expand this section based on additional dependencies or features in your project.


## Feedback

If you have any feedback, please reach out to us at mohamedelhalawany120@gmail.com

## 🔗 You can follow me on

[![portfolio](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/halawany1)
[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/mohamed-elhalawany-329314220/)
