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
  factory Game.newGame({required String id, required String player1Name}) {
    return Game(
      id: id,
      player1Name: player1Name,
      player2Name: null,
      status: GameStatus.waiting,
      board: List.generate(3, (_) => List.generate(3, (_) => CellState.empty)),
      currentPlayer: null,
      winner: null,
      isDraw: false,
      createdAt: DateTime.now(),
      lastMoveAt: null,
    );
  }

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
      3,
      (r) => List.generate(
        3,
        (c) =>
            (r == row && c == col) ? getPlayerSymbol(playerName) : board[r][c],
      ),
    );

    // Check for winner
    final winner = _checkWinner(newBoard);
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
  static CellState? _checkWinner(List<List<CellState>> board) {
    // Check rows
    for (var row in board) {
      if (row[0] != CellState.empty && row[0] == row[1] && row[1] == row[2]) {
        return row[0];
      }
    }

    // Check columns
    for (var col = 0; col < 3; col++) {
      if (board[0][col] != CellState.empty &&
          board[0][col] == board[1][col] &&
          board[1][col] == board[2][col]) {
        return board[0][col];
      }
    }

    // Check diagonals
    if (board[0][0] != CellState.empty &&
        board[0][0] == board[1][1] &&
        board[1][1] == board[2][2]) {
      return board[0][0];
    }

    if (board[0][2] != CellState.empty &&
        board[0][2] == board[1][1] &&
        board[1][1] == board[2][0]) {
      return board[0][2];
    }

    return null;
  }

  /// Check if the board is full
  static bool _isBoardFull(List<List<CellState>> board) {
    return board.every((row) => row.every((cell) => cell != CellState.empty));
  }
}
