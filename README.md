# Tic-Tac-Toe - Cross-Platform Real-Time Game

A modern, feature-rich Tic-Tac-Toe game built with Flutter, showcasing real-time multiplayer capabilities and cross-platform development skills.



https://github.com/user-attachments/assets/d45a6b08-1de9-4012-ac81-c75226d87fbd




## 🎯 Project Overview

This project demonstrates a complete Flutter application with real-time online multiplayer functionality. Players can create or join games and play against each other in real-time, with support for dynamic board sizes (3x3, 4x4, 5x5, etc.).

**Built for**: Technical interview demonstration  
**Status**: Functional MVP with room for enhancements (see TODO section)

## 🚀 Key Features

- ✅ **Real-time Online Multiplayer**: Play with anyone, anywhere with instant synchronization
- ✅ **Local Game Mode**: Play offline on the same device (Human vs Human)
- ✅ **Dynamic Board Sizes**: Configurable grid sizes (3x3, 4x4, 5x5, etc.)
- ✅ **Cross-Platform**: Runs on Android, iOS, Web, Windows, macOS, and Linux
- ✅ **Game Management**: Create games with unique IDs or join existing ones
- ✅ **Win Detection**: Automatic detection of wins (rows, columns, diagonals) and draws
- ✅ **Real-time Updates**: Instant board state synchronization across all players
- ✅ **Theme System**: Light/Dark theme with customizable color schemes
- ✅ **Modern UI**: Glass morphism effects with liquid glass renderer
- ✅ **Settings**: Customizable visual effects (blur, saturation, chromatic aberration, etc.)

## 🛠️ Tech Stack

### Core Framework
- **Flutter 3.38.3** - Cross-platform UI framework
- **Dart 3.x** - Programming language with sound null safety

### State Management & Architecture
- **Riverpod v2** - Modern reactive state management with code generation
- **riverpod_generator** - Code generation for type-safe providers
- **freezed** - Immutable data models with code generation

### Navigation
- **go_router** - Declarative routing solution for Flutter

### Backend & Real-time Database
- **Firebase Realtime Database** - NoSQL cloud database for real-time data synchronization

### UI & Visual Effects
- **liquid_glass_renderer** - Glass morphism effects for modern UI
- **motor** - Animation library for smooth transitions

### Code Quality
- **json_serializable** - JSON serialization/deserialization
- **flutter_lints** - Recommended linting rules
- **custom_lint** & **riverpod_lint** - Enhanced linting for Riverpod
- **build_runner** - Code generation tools

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point
├── firebase_options.dart          # Firebase configuration
├── router.dart                    # go_router configuration
├── models/
│   └── game.dart                  # Game data model (freezed)
├── screens/
│   ├── home_screen.dart           # Main menu (online/offline selection)
│   ├── online_pseudo_screen.dart  # Player name entry for online games
│   ├── game_selection_screen.dart # Create/join online game
│   ├── online_game_screen.dart    # Online multiplayer game board
│   ├── local_game_screen.dart     # Local (offline) game board
│   └── realtime_debug_screen.dart # Debug screen for Firebase
├── widgets/
│   ├── game_board.dart            # Reusable game board widget
│   ├── game_cell.dart             # Individual game cell
│   ├── game_info.dart             # Game status display
│   ├── liquid_glass_card.dart     # Glass morphism card component
│   ├── app_scaffold.dart          # Custom scaffold with background
│   ├── app_button.dart            # Themed button component
│   └── settings.dart              # Settings sheet with visual controls
├── services/
│   ├── game_service.dart          # Game service interface
│   ├── game_service_local_impl.dart      # Local game implementation
│   ├── game_service_realtimedb_impl.dart # Online game implementation
│   └── realtime_database_service.dart    # Firebase operations
├── providers/
│   ├── game_providers.dart        # Game state providers
│   ├── realtime_database_providers.dart # Database providers
│   └── settings_providers.dart    # Settings state providers
└── theme/
    ├── app_theme.dart             # Theme data model
    ├── app_theme.provider.dart    # Theme provider
    ├── color_theme.dart           # Color scheme definitions
    └── theme_switcher.dart        # Theme toggle widget
```

## 🏃 Getting Started

### Prerequisites
- Flutter SDK 3.38.3 or higher
- Dart 3.x
- Node.js and npm (for Firebase CLI)
- Firebase CLI installed globally: `npm install -g firebase-tools`

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd tictactoe
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (for Freezed, Riverpod, JSON serialization)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Start Firebase Emulators** (for local development)
   ```bash
   # In a separate terminal, start the Firebase emulators
   firebase emulators:start
   
   # The Realtime Database emulator will run on http://localhost:9000
   # The emulator UI will be available at http://localhost:4000
   ```
   
   **Notes**: 
   - The app automatically uses the Firebase emulator in debug mode
   - If you see "port taken" errors, emulators are already running - check with `lsof -i :9000`

5. **Run the app**
   ```bash
   flutter run                    # Default device
   flutter run -d chrome          # Web
   flutter run -d macos           # macOS
   flutter run -d windows         # Windows
   flutter run -d <device-id>     # iOS/Android device
   ```
   
   For online multiplayer testing, run the app on multiple devices/instances

### Firebase Setup

#### Local Development with Emulators (Recommended)

This project is configured to use **Firebase Emulators** for local development, which means:
- ✅ No internet connection required for development
- ✅ Free to use, no Firebase quota consumption
- ✅ Fast iteration without affecting production data
- ✅ Automatic data reset between sessions

The emulator configuration is in `firebase.json`:
- **Realtime Database**: Port 9000
- **Firestore**: Port 8080 (for future use)
- **Authentication**: Port 9099 (for future use)
- **Emulator UI**: http://localhost:4000

The app automatically connects to the emulator in **debug mode** (see `lib/main.dart` lines 18-24).

#### Production Firebase Setup

If you want to connect to a real Firebase project, the configuration files are already included:
- `android/app/google-services.json` (Android)
- `ios/Runner/GoogleService-Info.plist` (iOS)
- `macos/Runner/GoogleService-Info.plist` (macOS)
- `lib/firebase_options.dart` (All platforms)

**Note**: In a production environment, these files should not be committed to version control.

To use your own Firebase project:
1. Create a Firebase project at https://console.firebase.google.com
2. Install FlutterFire CLI: `dart pub global activate flutterfire_cli`
3. Run `flutterfire configure` to generate new configuration files

## 🎮 How to Play

### Online Game
1. Select **"Online game"** from the home screen
2. Enter your player name
3. **Create** a new game or **Join** an existing game using a game ID
4. Share the game ID with your opponent
5. Take turns placing your marks (X or O)
6. Win by getting N marks in a row (horizontally, vertically, or diagonally)

### Local Game
1. Select **"Offline game"** from the home screen
2. Play on the same device - take turns tapping cells
3. The game automatically alternates between players

## 🔧 Troubleshooting

### Firebase Emulator Issues

**Problem**: `firebase: command not found`
```bash
# Solution: Install Firebase CLI
npm install -g firebase-tools
```

**Problem**: Emulator fails to start or port already in use
```bash
# Solution: Check if emulators are already running
lsof -i :9000  # Check Realtime Database port
lsof -i :4000  # Check Emulator UI port

# Kill the process if needed
kill -9 <PID>

# Or use different ports by editing firebase.json
```

**Problem**: App can't connect to emulator
- Make sure emulators are running (`firebase emulators:start`)
- Check that the app is running in debug mode (emulator connection is only enabled in debug)
- For iOS Simulator/Android Emulator, use `localhost`
- For physical devices, use your computer's local IP address and update `main.dart` accordingly

**Problem**: Code generation fails
```bash
# Solution: Clean and rebuild
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

**Problem**: Theme or UI not displaying correctly
- Ensure all dependencies are installed: `flutter pub get`
- Check that code generation completed successfully
- Try restarting the app

## 🏗️ Architecture Highlights

### State Management
- Uses **Riverpod 2.0** with code generation for compile-time safety
- Separation of concerns: UI, business logic, and data layers
- Reactive programming with StreamProviders for real-time updates

### Real-time Synchronization
- Firebase Realtime Database listeners for instant updates
- Optimistic UI updates with server reconciliation
- Automatic offline support via Firebase SDK

### Data Model
- **Freezed** for immutable, copyable data classes
- **JSON serialization** for Firebase data exchange
- Type-safe game state representation


```

## 📝 TODO List for improvements

### Navigation
- [x] ~~Implement full declarative navigation flow with go_router~~ ✅ **COMPLETED**

### UI/UX Enhancements
- [x] ~~Implement dark/light theme mode~~ ✅ **COMPLETED**
- [x] ~~Add settings screen with visual controls~~ ✅ **COMPLETED**
- [ ] Add animations with Rive for smooth transitions and interactions
- [ ] System preference detection for theme (auto dark/light mode)
- [ ] Board size configuration in settings

### Testing
- [ ] Unit tests for game logic (win detection, draw detection, move validation)
- [ ] Widget tests/Integration tests
- [ ] Code coverage reporting

### CI/CD Pipeline
- [ ] **Web Deployment**: Automated deployment to Firebase Hosting or similar
- [ ] **Lint Check**: Automated linting in CI pipeline
- [ ] **Test Execution**: Run all tests on every commit
- [ ] **Analyzer Check**: Static analysis validation
- [ ] **Code Coverage**: Generate and track coverage metrics
- [ ] **iOS Distribution**: Deploy to TestFlight for beta testing
- [ ] **Android Distribution**: Deploy to Firebase App Distribution

### Internationalization
- [ ] Set up Flutter localization (intl package)
- [ ] Support multiple languages (English, French, etc.)
- [ ] Locale-aware formatting

### Authentication & Security
- [ ] Add Firebase Authentication
- [ ] User profiles and statistics
- [ ] Secure database rules based on authentication

### Game Modes
- [x] ~~Local mode: Human vs Human (same device)~~ ✅ **COMPLETED**
- [ ] Local mode: Human vs AI/Computer
- [ ] Setting to let user change board size
- [ ] AI difficulty levels (Easy, Medium, Hard)

### Additional Features
- [ ] Game history and replay
- [ ] Player statistics and leaderboards
- [ ] Sound effects and haptic feedback

## 📄 License

This project was created for technical interview purposes.

## 👨‍💻 Author

Corentin Bazin

---

*This project demonstrates proficiency in Flutter, state management, real-time databases, and cross-platform mobile development.*
