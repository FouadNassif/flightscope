# FlightScope

## Description

**FlightScope** is a Flutter application designed for tracking flights in real-time. It allows users to search for flights based on departure and arrival cities or flight numbers. The app fetches flight data using the AviationStack API and displays essential information such as departure times, arrival times, flight statuses, and more. With a user-friendly interface and efficient performance, FlightScope is an excellent tool for anyone interested in keeping track of flights around the world.

## Features

- Real-time flight tracking
- Search functionality for flights by city or flight number
- User-friendly interface with a modern design
- Refresh flights with the latest data

## Installation

To get started with the FlightScope app, follow the steps below:

### Prerequisites

1. **Install Flutter:**
   - Follow the instructions on the official Flutter installation guide: [Flutter Install](https://flutter.dev/docs/get-started/install).
   - Ensure you have Flutter set up and configured correctly, including adding Flutter to your system's PATH.

2. **Install Android Studio:**
   - Download and install Android Studio from the official website: [Android Studio](https://developer.android.com/studio).
   - During installation, ensure the following options are selected:
     - Android SDK
     - Android SDK Platform
     - Android Virtual Device (AVD)

3. **Set Up an Emulator:**
   - Open Android Studio and go to the **AVD Manager** (Android Virtual Device Manager).
   - Create a new virtual device by clicking **Create Virtual Device** and follow the setup process.
   - Choose a device definition and a system image, then click **Finish**.
   - Start the emulator from the AVD Manager once it's set up.

### Running the App

1. **Clone the repository:**
   ```bash
   git clone https://your-repo-url.git
   cd your-repo-directory
Open the project in Android Studio:

2. **Launch Android Studio**.

- Click on Open an existing Android Studio project and select the cloned directory.

- Open the main.dart file:

- Navigate to lib/main.dart.

- Run the app without debugging:

- Start the emulator if it’s not already running.

- In Android Studio, click on the green Run button or use the shortcut Shift + F10.

### API Setup
1. **Sign up for an API key:**

    - Go to [AviationStack](https://aviationstack.com/).

    - Create an account and log in.

    - Navigate to the API section to generate your API key.

    - Add the API key to your project:

        - Open the file where you make the API requests (e.g., lib/api/all_flights.dart).
        - Create a new file .env And place you're apikey there.
        - Replace the placeholder API key with your actual key:

```bash 
final response = await http.get(
  Uri.parse('https://api.aviationstack.com/v1/flights?access_key=YOUR_API_KEY&limit=10'),);
```

**Make sure to keep your API key secure and do not share it publicly.**

### Troubleshooting
If you encounter any issues while setting up Flutter or Android Studio, please refer to the official documentation:

[Flutter Documentation](https://docs.flutter.dev/)

[Android Studio Documentation](https://docs.flutter.dev/get-started/install/windows/mobile)

**Contributing**

Contributions are welcome! If you have suggestions for improvements or features, feel free to open an issue or submit a pull request.

**License**
This project is licensed under the MIT License. See the LICENSE file for more details.
