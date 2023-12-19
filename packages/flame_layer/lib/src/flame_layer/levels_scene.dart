import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_layer/src/blocs/game_stats/game_stats_bloc.dart';
import 'package:flame_layer/src/flame_layer/level.dart';
import 'package:flame_layer/src/utils/audio_manager.dart';

class LevelsScene extends PositionComponent
    with FlameBlocListenable<GameStatsBloc, GameStatsState> {
  List<Level> levels = [
    Level(0),
    Level(1),
    Level(2),
  ];

  late Level currentLevel;

  LevelsScene();

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(levels[0]);
    currentLevel = levels[0];
  }

  @override
  void onNewState(GameStatsState state) {
    for (var i = 1; i < levels.length; i++) {
      if (state.level == i + 1) {
        AudioManager.stopBackgroundMusic();
        AudioManager.playBackgroundMusic(Sounds.fromLevel(state.level));
        if (levels[i].parent != null) {
          remove(levels[i]);
          add(levels[i + 1]);
          currentLevel = levels[i + 1];
        }
      }
    }
    super.onNewState(state);
  }
}
