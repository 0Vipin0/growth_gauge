# Growth Gauge

## Description

Growth Gauge is your personal companion for tracking tasks and time-based activities.  This application goes beyond simple counting, visualizing your progress with insightful graphs and statistics to help you understand your activity patterns and achievements.

## Features

*   **Organized Counter Lists:**  Effortlessly manage and track all your ongoing tasks and timers within a clear and intuitive list.
*   **Detailed Counter Insights:** Dive deep into each counter with comprehensive detail views, including:
    *   **Heatmaps:**  Visually identify trends and peak activity periods over extended durations.
    *   **7-Day Charts:**  Quickly review your performance and counts for the past week at a glance.
*   **JSON Data Export:**  Securely export your valuable counter and timer data as JSON files for backup, sharing, or in-depth analysis with other tools.
*   **Persistent Data Storage:**  Enjoy peace of mind knowing your data is persistently stored using Shared Preferences, ensuring your progress is saved across all application sessions.
*   **Personalized App Experience:** Customize the look and feel of Growth Gauge to match your style by adjusting application themes and fonts directly within the settings.

## Build Process
1.  **Flutter Environment Setup:** Ensure you have the Flutter SDK installed and correctly configured on your development machine. Refer to the official Flutter installation guide for detailed platform-specific instructions: [Flutter Install Guide](https://flutter.dev/docs/get-started/install).

2.  **Dependency Retrieval:** Navigate to the project's root directory in your terminal and execute:
    ```bash
    flutter pub get
    ```

3.  **Code Analysis :**  Run the Flutter analyzer to identify potential code issues and ensure code quality:
    ```bash
    flutter analyze
    ```

4.  **Platform-Specific Builds:** Build the application for your desired target platform using Flutter's build commands. Common examples include:
    *   **Android (APK):** `flutter build apk` (For distribution, consider `flutter build apk --split-per-abi`)
    *   **Android (App Bundle - recommended for Play Store):** `flutter build appbundle`
    *   **iOS:** `flutter build ios` (Requires macOS and Xcode)
    *   **Web:** `flutter build web`

5.  **Run for Development:** To quickly run the application on a connected device or emulator during development, use:
    ```bash
    flutter run
    ```

## Future Goals

*   **CSV Data Export:** Implement the ability to export data in CSV format for enhanced compatibility with spreadsheet software and data analysis workflows.
*   **Automated Builds with GitHub Actions:** Integrate GitHub Actions to automate the build, testing, and artifact generation processes for various platforms, streamlining development and release cycles.
*   **Cross-Device Data Synchronization:** Enable seamless data sharing and access across multiple devices through cloud storage integration, allowing users to manage their Growth Gauge data from anywhere.
*   **User Authentication:** Implement user authentication to enhance data security and potentially unlock future user-specific features and data management capabilities.
*   **Sound Alerts and Notifications:** Support scheduled local notifications for both Mobile and Desktop with possibility of customizable sound notification.
*   **Target Tracking:** Allows users to define target and trigger notification when goal is reached.
*   **Data Categorization:** Allows users to add tags/categories to counters and timers to organize them with tag based filtering support.
*   **Summary Statistics:** Display summary statistics like average, minimum, maximum for specific counters or timers with basic trend analysis showing rate of change counter and timer values over time. 

## License

Growth Gauge is licensed under the [BSD 3-Clause License](LICENSE).  See the `LICENSE` file for the full license text.