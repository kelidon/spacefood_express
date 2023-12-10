import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

import '../blocs/game_stats/game_stats_bloc.dart';
import 'level.dart';

class LevelsScene extends PositionComponent
    with FlameBlocListenable<GameStatsBloc, GameStatsState> {
  List<Level> levels = [
    Level(),
    Level(),
    Level(),
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
    for (int i = 1; i < levels.length; i++) {
      if (state.level == i + 1) {
        remove(levels[i]);
        add(levels[i + 1]);
        currentLevel = levels[i + 1];
      }
    }
    super.onNewState(state);
  }
}