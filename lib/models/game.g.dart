// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Game _$GameFromJson(Map<String, dynamic> json) => _Game(
  id: json['id'] as String,
  player1Name: json['player1Name'] as String,
  player2Name: json['player2Name'] as String?,
  status: $enumDecode(_$GameStatusEnumMap, json['status']),
  board: (json['board'] as List<dynamic>)
      .map(
        (e) => (e as List<dynamic>)
            .map((e) => $enumDecode(_$CellStateEnumMap, e))
            .toList(),
      )
      .toList(),
  currentPlayer: json['currentPlayer'] as String?,
  winner: json['winner'] as String?,
  isDraw: json['isDraw'] as bool? ?? false,
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastMoveAt: json['lastMoveAt'] == null
      ? null
      : DateTime.parse(json['lastMoveAt'] as String),
);

Map<String, dynamic> _$GameToJson(_Game instance) => <String, dynamic>{
  'id': instance.id,
  'player1Name': instance.player1Name,
  'player2Name': instance.player2Name,
  'status': _$GameStatusEnumMap[instance.status]!,
  'board': instance.board
      .map((e) => e.map((e) => _$CellStateEnumMap[e]!).toList())
      .toList(),
  'currentPlayer': instance.currentPlayer,
  'winner': instance.winner,
  'isDraw': instance.isDraw,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastMoveAt': instance.lastMoveAt?.toIso8601String(),
};

const _$GameStatusEnumMap = {
  GameStatus.waiting: 'waiting',
  GameStatus.playing: 'playing',
  GameStatus.finished: 'finished',
};

const _$CellStateEnumMap = {
  CellState.empty: 'empty',
  CellState.x: 'X',
  CellState.o: 'O',
};
