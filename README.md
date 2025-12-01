# Tic-Tac-Toe - Cross-Platform Real-Time Game

A modern, feature-rich Tic-Tac-Toe game built with Flutter, showcasing real-time multiplayer capabilities and cross-platform development skills.

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

4. **Run the app**
   ```bash
   # Run on your preferred platform
   flutter run                    # Default device
   flutter run -d chrome          # Web
   flutter run -d macos           # macOS
   flutter run -d windows         # Windows
   flutter run -d <device-id>     # iOS/Android device
   ```

### Firebase Setup

This project requires Firebase Realtime Database. The configuration files are already included:
- `android/app/google-services.json` (Android)
- `ios/Runner/GoogleService-Info.plist` (iOS)
- `macos/Runner/GoogleService-Info.plist` (macOS)
- `lib/firebase_options.dart` (All platforms)

**Note**: In a production environment, these files should not be committed to version control.

## 🎮 How to Play

1. **Enter Your Name**: Start by entering your player name
2. **Create or Join a Game**: 
   - Create a new game by selecting a board size
   - Or join an existing game using a game ID
3. **Share Game ID**: Share the game ID with your opponent
4. **Play**: Take turns placing your marks (X or O)
5. **Win**: Get N marks in a row (horizontally, vertically, or diagonally) to win!

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

## 📝 TODO List

### Navigation
- [ ] Implement full declarative navigation flow with go_router

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
