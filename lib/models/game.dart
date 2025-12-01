import 'package:freezed_annotation/freezed_annotation.dart';

part 'game.freezed.dart';
part 'game.g.dart';

/// Represents the state of a cell in the game board
enum CellState {
  @JsonValue('empty')
  empty,
  @JsonValue('X')
  x,
  @JsonValue('O')
  o;

  String get displayValue {
    switch (this) {
      case CellState.empty:
        return '';
      case CellState.x:
        return 'X';
      case CellState.o:
        return 'O';
    }
  }
}

/// Represents the status of the game
enum GameStatus {
  @JsonValue('waiting')
  waiting, // Waiting for second player
  @JsonValue('playing')
  playing, // Game in progress
  @JsonValue('finished')
  finished, // Game finished
}

@freezed
abstract class Game with _$Game {
  const Game._();

  const factory Game({
    required String id,
    required String player1Name,
    String? player2Name,
    required GameStatus status,
    required List<List<CellState>> board,
    String? currentPlayer, // Name of the player whose turn it is
    String? winner, // Name of the winner, null if no winner yet
    @Default(false) bool isDraw,
    required DateTime createdAt,
    DateTime? lastMoveAt,
  }) = _Game;

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  /// Create a new game with player 1
  factory Game.newOnlineGame({
    required String id,
    required String player1Name,
    required int boardSize,
  }) {
    return Game(
      id: id,
      player1Name: player1Name,
      status: GameStatus.waiting,
      board: List.generate(
        boardSize,
        (_) => List.generate(boardSize, (_) => CellState.empty),
      ),
      currentPlayer: null,
      winner: null,
      isDraw: false,
      createdAt: DateTime.now(),
      lastMoveAt: null,
    );
  }

  factory Game.newOfflineGame({required int boardSize}) {
    final player1Name = 'Player 1';
    final player2Name = 'Player 2';
    return Game(
      id: '',
      player1Name: player1Name,
      player2Name: player2Name,
      status: GameStatus.playing,
      board: List.generate(
        boardSize,
        (_) => List.generate(boardSize, (_) => CellState.empty),
      ),
      currentPlayer: player1Name,
      winner: null,
      isDraw: false,
      createdAt: DateTime.now(),
    );
  }

  int get size => board.length; // Get the size of the board

  // /// Check if a player can join the game
  bool get canJoin => status == GameStatus.waiting && player2Name == null;

  /// Check if it's a specific player's turn
  bool isPlayerTurn(String playerName) => currentPlayer == playerName;

  // /// Get the cell state for the current player
  CellState get currentPlayerCellState {
    if (currentPlayer == player1Name) return CellState.x;
    if (currentPlayer == player2Name) return CellState.o;
    return CellState.empty;
  }

  // /// Check if the game is over
  bool get isGameOver => status == GameStatus.finished;

  // /// Get the symbol for a player (X or O)
  CellState getPlayerSymbol(String playerName) {
    if (playerName == player1Name) return CellState.x;
    if (playerName == player2Name) return CellState.o;
    return CellState.empty;
  }

  /// Join the game as player 2
  Game joinAsPlayer2(String player2Name) {
    return copyWith(
      player2Name: player2Name,
      status: GameStatus.playing,
      currentPlayer: player1Name, // Player 1 (X) starts
    );
  }

  /// Restart the game with the same players
  Game restart() {
    return copyWith(
      board: List.generate(
        size,
        (_) => List.generate(size, (_) => CellState.empty),
      ),
      status: GameStatus.playing,
      currentPlayer: player1Name, // Player 1 (X) starts
      winner: null,
      isDraw: false,
      lastMoveAt: DateTime.now(),
    );
  }

  bool canMakeMove(int row, int col, String playerName) {
    if (!isPlayerTurn(playerName)) {
      return false;
    }

    if (row > size - 1 || col > size - 1) {
      return false;
    }

    if (board[row][col] != CellState.empty) {
      return false;
    }

    return true;
  }

  /// Make a move at the specified position
  Game makeMove(int row, int col, String playerName) {
    if (!isPlayerTurn(playerName)) {
      throw Exception('Not your turn!');
    }

    if (board[row][col] != CellState.empty) {
      throw Exception('Cell already occupied!');
    }

    // Create new board with the move
    final newBoard = List.generate(
      size,
      (r) => List.generate(
        size,
        (c) =>
            (r == row && c == col) ? getPlayerSymbol(playerName) : board[r][c],
      ),
    );

    // Check for winner
    final winner = _checkWinner(newBoard, size);
    final isDraw = winner == null && _isBoardFull(newBoard);

    // Determine next player
    String? nextPlayer;
    if (winner == null && !isDraw) {
      nextPlayer = playerName == player1Name ? player2Name : player1Name;
    }

    return copyWith(
      board: newBoard,
      currentPlayer: nextPlayer,
      winner: winner == CellState.x
          ? player1Name
          : (winner == CellState.o ? player2Name : null),
      isDraw: isDraw,
      status: (winner != null || isDraw) ? GameStatus.finished : status,
      lastMoveAt: DateTime.now(),
    );
  }

  /// Check if there's a winner
  /// Works dynamically with any board size
  static CellState? _checkWinner(List<List<CellState>> board, int size) {
    // Check rows
    for (var row = 0; row < size; row++) {
      final firstCell = board[row][0];
      if (firstCell != CellState.empty) {
        var allMatch = true;
        for (var col = 1; col < size; col++) {
          if (board[row][col] != firstCell) {
            allMatch = false;
            break;
          }
        }
        if (allMatch) return firstCell;
      }
    }

    // Check columns
    for (var col = 0; col < size; col++) {
      final firstCell = board[0][col];
      if (firstCell != CellState.empty) {
        var allMatch = true;
        for (var row = 1; row < size; row++) {
          if (board[row][col] != firstCell) {
            allMatch = false;
            break;
          }
        }
        if (allMatch) return firstCell;
      }
    }

    // Check main diagonal (top-left to bottom-right)
    final mainDiagFirst = board[0][0];
    if (mainDiagFirst != CellState.empty) {
      var allMatch = true;
      for (var i = 1; i < size; i++) {
        if (board[i][i] != mainDiagFirst) {
          allMatch = false;
          break;
        }
      }
      if (allMatch) return mainDiagFirst;
    }

    // Check anti-diagonal (top-right to bottom-left)
    final antiDiagFirst = board[0][size - 1];
    if (antiDiagFirst != CellState.empty) {
      var allMatch = true;
      for (var i = 1; i < size; i++) {
        if (board[i][size - 1 - i] != antiDiagFirst) {
          allMatch = false;
          break;
        }
      }
      if (allMatch) return antiDiagFirst;
    }

    return null;
  }

  /// Check if the board is full
  static bool _isBoardFull(List<List<CellState>> board) {
    return board.every((row) => row.every((cell) => cell != CellState.empty));
  }
}
