// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Game {

 String get id; String get player1Name; String? get player2Name; GameStatus get status; List<List<CellState>> get board; String? get currentPlayer;// Name of the player whose turn it is
 String? get winner;// Name of the winner, null if no winner yet
 bool get isDraw; DateTime get createdAt; DateTime? get lastMoveAt;
/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameCopyWith<Game> get copyWith => _$GameCopyWithImpl<Game>(this as Game, _$identity);

  /// Serializes this Game to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Game&&(identical(other.id, id) || other.id == id)&&(identical(other.player1Name, player1Name) || other.player1Name == player1Name)&&(identical(other.player2Name, player2Name) || other.player2Name == player2Name)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.board, board)&&(identical(other.currentPlayer, currentPlayer) || other.currentPlayer == currentPlayer)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.isDraw, isDraw) || other.isDraw == isDraw)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastMoveAt, lastMoveAt) || other.lastMoveAt == lastMoveAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,player1Name,player2Name,status,const DeepCollectionEquality().hash(board),currentPlayer,winner,isDraw,createdAt,lastMoveAt);

@override
String toString() {
  return 'Game(id: $id, player1Name: $player1Name, player2Name: $player2Name, status: $status, board: $board, currentPlayer: $currentPlayer, winner: $winner, isDraw: $isDraw, createdAt: $createdAt, lastMoveAt: $lastMoveAt)';
}


}

/// @nodoc
abstract mixin class $GameCopyWith<$Res>  {
  factory $GameCopyWith(Game value, $Res Function(Game) _then) = _$GameCopyWithImpl;
@useResult
$Res call({
 String id, String player1Name, String? player2Name, GameStatus status, List<List<CellState>> board, String? currentPlayer, String? winner, bool isDraw, DateTime createdAt, DateTime? lastMoveAt
});




}
/// @nodoc
class _$GameCopyWithImpl<$Res>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._self, this._then);

  final Game _self;
  final $Res Function(Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? player1Name = null,Object? player2Name = freezed,Object? status = null,Object? board = null,Object? currentPlayer = freezed,Object? winner = freezed,Object? isDraw = null,Object? createdAt = null,Object? lastMoveAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,player1Name: null == player1Name ? _self.player1Name : player1Name // ignore: cast_nullable_to_non_nullable
as String,player2Name: freezed == player2Name ? _self.player2Name : player2Name // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,board: null == board ? _self.board : board // ignore: cast_nullable_to_non_nullable
as List<List<CellState>>,currentPlayer: freezed == currentPlayer ? _self.currentPlayer : currentPlayer // ignore: cast_nullable_to_non_nullable
as String?,winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String?,isDraw: null == isDraw ? _self.isDraw : isDraw // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastMoveAt: freezed == lastMoveAt ? _self.lastMoveAt : lastMoveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Game].
extension GamePatterns on Game {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Game value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Game value)  $default,){
final _that = this;
switch (_that) {
case _Game():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Game value)?  $default,){
final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String player1Name,  String? player2Name,  GameStatus status,  List<List<CellState>> board,  String? currentPlayer,  String? winner,  bool isDraw,  DateTime createdAt,  DateTime? lastMoveAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.id,_that.player1Name,_that.player2Name,_that.status,_that.board,_that.currentPlayer,_that.winner,_that.isDraw,_that.createdAt,_that.lastMoveAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String player1Name,  String? player2Name,  GameStatus status,  List<List<CellState>> board,  String? currentPlayer,  String? winner,  bool isDraw,  DateTime createdAt,  DateTime? lastMoveAt)  $default,) {final _that = this;
switch (_that) {
case _Game():
return $default(_that.id,_that.player1Name,_that.player2Name,_that.status,_that.board,_that.currentPlayer,_that.winner,_that.isDraw,_that.createdAt,_that.lastMoveAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String player1Name,  String? player2Name,  GameStatus status,  List<List<CellState>> board,  String? currentPlayer,  String? winner,  bool isDraw,  DateTime createdAt,  DateTime? lastMoveAt)?  $default,) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.id,_that.player1Name,_that.player2Name,_that.status,_that.board,_that.currentPlayer,_that.winner,_that.isDraw,_that.createdAt,_that.lastMoveAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Game extends Game {
  const _Game({required this.id, required this.player1Name, this.player2Name, required this.status, required final  List<List<CellState>> board, this.currentPlayer, this.winner, this.isDraw = false, required this.createdAt, this.lastMoveAt}): _board = board,super._();
  factory _Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

@override final  String id;
@override final  String player1Name;
@override final  String? player2Name;
@override final  GameStatus status;
 final  List<List<CellState>> _board;
@override List<List<CellState>> get board {
  if (_board is EqualUnmodifiableListView) return _board;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_board);
}

@override final  String? currentPlayer;
// Name of the player whose turn it is
@override final  String? winner;
// Name of the winner, null if no winner yet
@override@JsonKey() final  bool isDraw;
@override final  DateTime createdAt;
@override final  DateTime? lastMoveAt;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameCopyWith<_Game> get copyWith => __$GameCopyWithImpl<_Game>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Game&&(identical(other.id, id) || other.id == id)&&(identical(other.player1Name, player1Name) || other.player1Name == player1Name)&&(identical(other.player2Name, player2Name) || other.player2Name == player2Name)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._board, _board)&&(identical(other.currentPlayer, currentPlayer) || other.currentPlayer == currentPlayer)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.isDraw, isDraw) || other.isDraw == isDraw)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastMoveAt, lastMoveAt) || other.lastMoveAt == lastMoveAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,player1Name,player2Name,status,const DeepCollectionEquality().hash(_board),currentPlayer,winner,isDraw,createdAt,lastMoveAt);

@override
String toString() {
  return 'Game(id: $id, player1Name: $player1Name, player2Name: $player2Name, status: $status, board: $board, currentPlayer: $currentPlayer, winner: $winner, isDraw: $isDraw, createdAt: $createdAt, lastMoveAt: $lastMoveAt)';
}


}

/// @nodoc
abstract mixin class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) _then) = __$GameCopyWithImpl;
@override @useResult
$Res call({
 String id, String player1Name, String? player2Name, GameStatus status, List<List<CellState>> board, String? currentPlayer, String? winner, bool isDraw, DateTime createdAt, DateTime? lastMoveAt
});




}
/// @nodoc
class __$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(this._self, this._then);

  final _Game _self;
  final $Res Function(_Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? player1Name = null,Object? player2Name = freezed,Object? status = null,Object? board = null,Object? currentPlayer = freezed,Object? winner = freezed,Object? isDraw = null,Object? createdAt = null,Object? lastMoveAt = freezed,}) {
  return _then(_Game(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,player1Name: null == player1Name ? _self.player1Name : player1Name // ignore: cast_nullable_to_non_nullable
as String,player2Name: freezed == player2Name ? _self.player2Name : player2Name // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,board: null == board ? _self._board : board // ignore: cast_nullable_to_non_nullable
as List<List<CellState>>,currentPlayer: freezed == currentPlayer ? _self.currentPlayer : currentPlayer // ignore: cast_nullable_to_non_nullable
as String?,winner: freezed == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String?,isDraw: null == isDraw ? _self.isDraw : isDraw // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastMoveAt: freezed == lastMoveAt ? _self.lastMoveAt : lastMoveAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
