<p align="center">
<img src="assets/png/Quran_logo.png" alt="Logo" width="200"/>
<br/>

# Quran Search Web Application

This project is a simple Quran search web application where users can search for specific Quranic verses in English. It includes functionality for Authentication pages and searchable interface.

## Key Features

1. Authentication for real login functionality.
2. Search Page:
    - Users can search for verses across the Quran using keywords.
    - A real-time search bar dynamically displays results below it.

## Project Architecture
```bash
lib
│
┣ 📂components                        # Custom reusable components
┃ ┣ 📜custom_elevated_button.dart
┃ ┣ 📜custom_error_msg.dart
┃ ┗ 📜custom_text_form_field.dart
┣ 📂data_layer                        # managing data
┃ ┗ 📜data_layer.dart
┣ 📂models                            # Converting API data into a structured format for easy manipulation
┃ ┣ 📜search_model.dart
┃ ┗ 📜surah_model.dart
┣ 📂network                            # Manages API URLs and data fetching logic
┃ ┣ 📂mixin
┃ ┃ ┣ 📜search_method.dart
┃ ┃ ┗ 📜surah_method.dart
┃ ┣ 📜api_network.dart
┃ ┗ 📜constant_network.dart
┣ 📂screens                            # Contains UI screens for the app
┃ ┣ 📂auth_screens
┃ ┃ ┣ 📂cubit
┃ ┃ ┃ ┣ 📜auth_cubit.dart
┃ ┃ ┃ ┗ 📜auth_state.dart
┃ ┃ ┣ 📜auth_screen.dart
┃ ┃ ┣ 📜sign_in_screen.dart
┃ ┃ ┗ 📜sign_up_screen.dart
┃ ┗ 📂search_screen
┃   ┣ 📂cubit
┃   ┃ ┣ 📜search_cubit.dart
┃   ┃ ┗ 📜search_state.dart
┃   ┗ 📜search_screen.dart
┣ 📂setup                             # Provides global object access throughout the web app
┃ ┗ 📜setup.dart
┗ 📜main.dart                         # Entry point to run the web application
```

## Requirements

 In order to run the web, this project requires a Dart SDK and Flutter SDK.

1. install dart SDK
 install dart SDK from [dart documentation](https://dart.dev/get-dart)

2. install flutter SDK
 install or upgrade the latest version of Flutter from these installation [guides](https://docs.flutter.dev/get-started/install)

## How to run the project

1. Open terminal or CMD.
2. Clone the Repository, such as 
```bash
git clone https://github.com/Amjad-elahi/Quran.git
```
3. Navigate to the project path, such as 
```bash
cd quran
```
4. open the project in VS Code, such as 
```bash
code .
``` 
5. Install Dependencies with a command:
```bash
flutter pub get
```
6. Choose the device for example a chrome

7. Run the web with a command: 
```bash
flutter run
```
 ## Web Flow 
1. Authentication page (sign up or sign in)
   - Users can sign up/in with their email and password
2. search page
   - searching for a word as general search (in all the quran)
   - searching for a word in specific surah

## Challenges Faced
1.	Real-Time Search Performance:
    -	Optimizing results display to handle large datasets efficiently.

## Sample Output

<p align="center">
<img src="assets/output/quran_search_output1.gif" alt="output1" width="400"/>
<br/>

<p align="center">
<img src="assets/output/quran_search_output2.gif" alt="output2" width="400"/>
<br/>

## Created by
[Amjad Elahi](https://github.com/Amjad-elahi)


