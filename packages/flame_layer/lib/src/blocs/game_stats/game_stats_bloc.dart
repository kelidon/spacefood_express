import 'package:equatable/equatable.dart';
import 'package:flame_layer/src/utils/audio_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_stats_event.dart';

part 'game_stats_state.dart';

class GameStatsBloc extends Bloc<GameStatsEvent, GameStatsState> {
  GameStatsBloc() : super(const GameStatsState.empty()) {
    on<NextLevel>((event, emit) {
      emit(
        state.copyWith(level: state.level + 1, status: GameStatus.respawned),
      );
    });

    on<LevelWin>((event, emit) {
      AudioManager.playSpecialEffects(Sounds.finish);
      emit(
        state.copyWith(status: GameStatus.levelWin),
      );
    });
    on<LevelLoose>(
      (event, emit) {
        AudioManager.playSpecialEffects(Sounds.dead);
        emit(
          state.copyWith(
            status: event.isFreeze
                ? GameStatus.levelLooseFreeze
                : GameStatus.levelLooseBurn,
          ),
        );
      },
    );

    on<PlayerRespawned>((event, emit) {
      AudioManager.playSpecialEffects(Sounds.start);
      emit(
        state.copyWith(status: GameStatus.respawned),
      );
    });

    on<GameWin>(
      (event, emit) => emit(
        state.copyWith(status: GameStatus.gameWin),
      ),
    );

    on<GameReset>(
      (event, emit) => emit(
        const GameStatsState.empty(),
      ),
    );
  }
}
