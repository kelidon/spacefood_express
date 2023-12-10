import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacefood_express/flutter_layer/level_info_widget.dart';
import 'package:spacefood_express/flutter_layer/temperature_info_widget.dart';
import 'package:spacefood_express/flutter_layer/time_left_widget.dart';
import 'package:spacefood_express/flutter_layer/win_lose_alert.dart';

import '../blocs/game_stats/game_stats_bloc.dart';
import '../blocs/inventory/inventory_bloc.dart';
import 'level_start_alert.dart';

class FlutterLayer extends StatelessWidget {
  const FlutterLayer({super.key});

  @override
  Widget build(BuildContext context) {
    void showAlert(Widget alertWidget) {
      Future.delayed(
          Duration.zero,
          () =>
              showDialog<String>(context: context, builder: (BuildContext context) => alertWidget));
    }

    final statsBloc = context.watch<GameStatsBloc>();
    final inventoryBloc = context.watch<InventoryBloc>();

    switch (statsBloc.state.status) {
      case GameStatus.initial:
        showAlert(LevelStartAlert(
          foodName: 'Pasta',
          image: 'background',
          onStart: () => statsBloc.add(const PlayerRespawned()),
        ));
      case GameStatus.respawned:
        inventoryBloc.add(const ResetInventory());
      case GameStatus.levelLooseFreeze:
        showAlert(WinLoseAlert(
          isWinning: false,
          isFreeze: true,
          onContinue: () => statsBloc.add(const PlayerRespawned()),
        ));
      case GameStatus.levelLooseBurn:
        showAlert(WinLoseAlert(
          isWinning: false,
          isFreeze: false,
          onContinue: () => statsBloc.add(const PlayerRespawned()),
        ));
      case GameStatus.levelWin:
        showAlert(WinLoseAlert(
          isWinning: true,
          onContinue: () => statsBloc.add(const NextLevel()),
        ));
      case GameStatus.gameWin:
        //diff
        showAlert(WinLoseAlert(
          isWinning: true,
          onContinue: () => statsBloc.add(const GameReset()),
        ));
    }
    return const Stack(
      children: [
        //todo - extra info on game screen
        Positioned(top: 50, right: 10, child: TemperatureInfo()),
        Positioned(top: 150, right: 10, child: TimeLeftWidget()),
        Positioned(top: 50, right: 100, child: LevelInfo()),
      ],
    );
    //   BlocBuilder<GameStatsBloc, GameStatsState>(builder: (context, state) {
    //   if (state.status == GameStatus.initial) {
    //     Future.delayed(
    //         Duration.zero,
    //         () => showDialog<String>(
    //             context: context,
    //             builder: (BuildContext context) => const LevelStartAlert(
    //                   foodName: 'Pasta',
    //                   image: 'background',
    //                 )));
    //   }
    //   return const Stack(
    //     children: [
    //       //todo - extra info on game screen
    //       Positioned(top: 50, right: 10, child: TemperatureInfo()),
    //       Positioned(top: 150, right: 10, child: TimeLeftWidget()),
    //       Positioned(top: 50, right: 100, child: LevelInfo()),
    //     ],
    //   );
    // });
  }
}

//
// Center(
// child: ElevatedButton(
// onPressed: () {
// showDialog(
// context: context,
// builder: (BuildContext context) {
// return const LevelStartAlert(
// foodName: 'Pasta',
// image: 'allplanets',
// );
// },
// );
// },
// child: Text('Show Dialog'),
// ),
// ),
