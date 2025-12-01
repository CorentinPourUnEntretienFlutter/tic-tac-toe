# Tic-Tac-Toe - Cross-Platform Real-Time Game

A modern, feature-rich Tic-Tac-Toe game built with Flutter, showcasing real-time multiplayer capabilities and cross-platform development skills.

[demo tic tac toe.webm](https://github.com/user-attachments/assets/5849d1aa-2c02-41e0-a1f0-3368d894a8b8)


## 🎯 Project Overview

This project demonstrates a complete Flutter application with real-time online multiplayer functionality. Players can create or join games and play against each other in real-time, with support for dynamic board sizes (3x3, 4x4, 5x5, etc.).

**Built for**: Technical interview demonstration  
**Status**: Functional MVP with room for enhancements (see TODO section)

## 🚀 Key Features

- ✅ **Real-time Online Multiplayer**: Play with anyone, anywhere with instant synchronization
- ✅ **Dynamic Board Sizes**: Configurable grid sizes (3x3, 4x4, 5x5, because why not?)
- ✅ **Cross-Platform**: Runs on Android, iOS, Web, Windows, macOS, and Linux
- ✅ **Game Management**: Create games with unique IDs or join existing ones
- ✅ **Win Detection**: Automatic detection of wins (rows, columns, diagonals) and draws
- ✅ **Real-time Updates**: Instant board state synchronization across all players

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

### Code Quality
- **json_serializable** - JSON serialization/deserialization
- **flutter_lints** - Recommended linting rules
- **build_runner** - Code generation tools
- **tests** - Unit test and widget tests

## 📁 Project Structure

```
lib/
├── main.dart                      # App entry point
├── firebase_options.dart          # Firebase configuration
├── models/
│   └── game.dart                  # Game data model (freezed)
├── screens/
│   ├── name_entry_screen.dart     # Player name input
│   ├── game_selection_screen.dart # Create/join game
│   └── game_screen.dart           # Main game board
├── widgets/
│   └── game_board.dart            # Reusable game board widget
├── services/
│   ├── game_service.dart          # Game logic (win detection, etc.)
│   └── realtime_database_service.dart # Firebase operations
└── providers/
    ├── game_providers.dart        # Game state providers
    └── realtime_database_providers.dart # Database providers
```

## 🏃 Getting Started

### Prerequisites
- Flutter SDK 3.38.3 or higher
- Dart 3.x
- **Node.js and npm** (for Firebase CLI)
- **Firebase CLI** installed globally
- Firebase project configured (see below)

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
   - The app is configured to automatically use the Firebase emulator in debug mode. This allows you to develop and test without affecting your production Firebase database.
   - If you see "port taken" errors, the emulators are already running - you can skip this step or check running emulators with `lsof -i :9000`

5. **Run the app** (in a new terminal) player 1
   ```bash
   # Run on your preferred platform
   flutter run                    # Default device
   flutter run -d chrome          # Web
   flutter run -d macos           # macOS
   flutter run -d windows         # Windows
   flutter run -d <device-id>     # iOS/Android device
   ```

6. Repeat previous step for player 2

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
2. Install Firebase CLI: `npm install -g firebase-tools`
3. Install FlutterFire CLI: `dart pub global activate flutterfire_cli`
4. Run `flutterfire configure` to generate new configuration files

## 🎮 How to Play

1. **Enter Your Name**: Start by entering your player name
2. **Create or Join a Game**: 
   - Create a new game by selecting a board size
   - Or join an existing game using a game ID
3. **Share Game ID**: Share the game ID with your opponent
4. **Play**: Take turns placing your marks (X or O)
5. **Win**: Get N marks in a row (horizontally, vertically, or diagonally) to win!

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

## 🧪 Code Quality

- **Linting**: Follows Flutter recommended lints
- **Type Safety**: Full null safety support (Dart 3.x)
- **Code Generation**: Automated boilerplate reduction
- **Analysis**: `flutter analyze` with no issues

## 🛠️ Useful Commands

### Flutter Commands
```bash
flutter run                    # Run the app on default device
flutter run -d chrome          # Run on web browser
flutter test                   # Run all tests
flutter analyze                # Run static analysis
flutter format .               # Format all Dart files
flutter clean                  # Clean build artifacts
flutter pub get                # Install/update dependencies
flutter doctor                 # Check Flutter installation and dependencies
```

### Code Generation
```bash
# Generate code for Freezed, Riverpod, JSON serialization
dart run build_runner build --delete-conflicting-outputs

# Watch mode for continuous generation during development
dart run build_runner watch --delete-conflicting-outputs
```

### Firebase Emulator Commands
```bash
# Start all configured emulators (Database, Firestore, Auth)
firebase emulators:start

# Start only Realtime Database emulator
firebase emulators:start --only database

# Export emulator data (save current state)
firebase emulators:export ./emulator-data

# Start emulators with previously exported data
firebase emulators:start --import ./emulator-data

# Access Emulator UI at http://localhost:4000
```

## 📝 TODO List

### Navigation
- [x] ~~Implement full declarative navigation flow with go_router~~ ✅ **COMPLETED**

### UI/UX Enhancements
- [ ] Add animations with Rive for smooth transitions and interactions
- [ ] Implement dark/light theme mode with system preference detection
- [ ] Add settings screen (board size configuration, language selection)

### Testing
- [ ] Unit tests for game logic (win detection, draw detection, move validation)
- [ ] Integration (widget) tests for user flows
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
- [ ] Local mode: Human vs Human (same device)
- [ ] Local mode: Human vs AI/Computer
- [ ] AI difficulty levels (Easy, Medium, Hard)

### Additional Features
- [ ] Game history and replay
- [ ] Player statistics and leaderboards
- [ ] Chat functionality during games
- [ ] Custom themes and board designs
- [ ] Sound effects and haptic feedback

## 📄 License

This project was created for technical interview purposes.

## 👨‍💻 Author

Corentin Bazin

---

*This project demonstrates proficiency in Flutter, state management, real-time databases, and cross-platform mobile development.*
