part of 'game_stats_bloc.dart';

abstract class GameStatsEvent extends Equatable {
  const GameStatsEvent();
}

class PlayerRespawned extends GameStatsEvent {
  const PlayerRespawned();

  @override
  List<Object?> get props => [];
}

class NextLevel extends GameStatsEvent {
  const NextLevel();

  @override
  List<Object?> get props => [];
}

class LevelLoose extends GameStatsEvent {
  const LevelLoose({required this.isFreeze});

  final bool isFreeze;

  @override
  List<Object?> get props => [];
}

class LevelWin extends GameStatsEvent {
  const LevelWin();

  @override
  List<Object?> get props => [];
}

class GameWin extends GameStatsEvent {
  const GameWin();

  @override
  List<Object?> get props => [];
}

class GameReset extends GameStatsEvent {
  const GameReset();

  @override
  List<Object?> get props => [];
}
