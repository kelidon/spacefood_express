import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_stats_event.dart';

part 'game_stats_state.dart';

class GameStatsBloc extends Bloc<GameStatsEvent, GameStatsState> {
  GameStatsBloc() : super(const GameStatsState.empty()) {
    on<NextLevel>(
      (event, emit) => emit(
        //if last - win
        state.copyWith(level: state.level+1, status: GameStatus.respawned),
      ),
    );

    on<PlayerRespawned>(
      (event, emit) => emit(
        state.copyWith(status: GameStatus.respawned),
      ),
    );

    on<PlayerDied>((event, emit) {
      emit(
        state.copyWith(
          status: GameStatus.levelLoose,
        ),
      );
    });

    on<GameReset>(
      (event, emit) => emit(
        const GameStatsState.empty(),
      ),
    );
  }
}
