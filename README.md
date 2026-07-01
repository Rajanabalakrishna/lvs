LVS Innovation — Flutter Developer Technical Assessment
A Flutter application built as part of the LVS Innovation Pvt. Ltd. Flutter Developer Technical Assessment, completed within the 72-hour deadline. The app demonstrates production-ready Flutter development skills including clean architecture, Firebase authentication, and smooth UI animations.

✨ Features
Splash Screen — Animated logo display with smooth transition to the Login Screen

Google Sign-In — Firebase Authentication via Google (no phone or Facebook login)

Home Screen — Pixel-accurate UI replication of the provided design reference

Responsive UI — Adapts cleanly across different screen sizes and devices

Smooth Animations — Transitions and screen animations throughout the app

Reusable Widgets — Modular, composable component structure

API-Ready Architecture — Structured for seamless REST API integration

🛠️ Tech Stack
Framework — Flutter (Latest Stable SDK ^3.11.5)

Language — Dart

State Management — Riverpod (flutter_riverpod ^3.0.3 + riverpod_generator)

Authentication — Firebase Auth + Google Sign-In

Backend Services — Firebase Core, Cloud Firestore, Firebase Storage

Navigation — go_router ^17.3.0

Fonts — Google Fonts

Functional Programming — dartz (Either type for error handling)

HTTP Client — http ^1.2.1

🏗️ Architecture
Clean Architecture — Separation of data, domain, and presentation layers

MVVM Pattern — ViewModels managed via Riverpod providers

Proper Folder Structure — Feature-first organization with clear layer boundaries

Code Documentation — Inline comments and documented functions throughout

📁 Project Structure
text
lib/
├── core/            # App-wide utilities, constants, theme
├── features/
│   ├── splash/      # Splash screen with animation
│   ├── auth/        # Login screen, Google auth flow
│   └── home/        # Home screen UI
├── shared/          # Reusable widgets and components
└── main.dart
🚀 Getting Started
Prerequisites
Flutter SDK (^3.11.5)

Firebase project configured for Android/iOS

google-services.json (Android) / GoogleService-Info.plist (iOS) placed in respective directories

Installation
bash
git clone https://github.com/Rajanabalakrishna/lvs.git
cd lvs
flutter pub get
flutter run
📋 Assignment Requirements Covered
Splash Screen with animated logo

Google Sign-In via Firebase Authentication

Home Screen matching provided UI reference

Responsive UI

Clean Architecture + MVVM

State Management with Riverpod

Proper Folder Structure

Reusable Widgets

REST API Ready Structure

Git Version Control

Code Documentation

👨‍💻 Developer
Rajana Balakrishna
Flutter Developer | Full-Stack Developer
📍 Visakhapatnam, Andhra Pradesh, India
🔗 GitHub Profile
