part of 'game_stats_bloc.dart';

enum GameStatus {
  initial,
  respawn,
  respawned,
  gameOver,
  levelLoose,
  levelWin,
}

class GameStatsState extends Equatable {
  final int score;
  final int level;
  final GameStatus status;

  const GameStatsState({
    required this.score,
    required this.level,
    required this.status,
  });

  const GameStatsState.empty()
      : this(
          score: 0,
          level: 0,
          status: GameStatus.initial,
        );

  GameStatsState copyWith({
    int? score,
    int? level,
    GameStatus? status,
  }) {
    return GameStatsState(
      score: score ?? this.score,
      level: level ?? this.level,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [score, level, status];
}
