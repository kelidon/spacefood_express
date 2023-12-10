import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacefood_express/flutter_layer/level_info_widget.dart';
import 'package:spacefood_express/flutter_layer/temperature_info_widget.dart';
import 'package:spacefood_express/flutter_layer/time_left_widget.dart';
import 'package:spacefood_express/flutter_layer/win_lose_alert.dart';

import '../blocs/game_stats/game_stats_bloc.dart';
import '../blocs/inventory/inventory_bloc.dart';
import '../utils/audio_manager.dart';
import 'level_start_alert.dart';

class FlutterLayer extends StatelessWidget {
  const FlutterLayer({super.key});

  @override
  Widget build(BuildContext context) {
    void showAlert(Widget alertWidget) {
      Future.delayed(
        Duration.zero,
        () => showDialog<String>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) => alertWidget),
      );
    }

    final statsBloc = context.watch<GameStatsBloc>();

    switch (statsBloc.state.status) {
      case GameStatus.respawned:
        break;
      case GameStatus.initial:
        showAlert(LevelStartAlert(
          foodName: 'Pasta',
          image: 'background',
          onStart: () {
            AudioManager.playBackgroundMusic('example.mp3');
            Future.delayed(const Duration(seconds: 5), () {
              AudioManager.stopBackgroundMusic();
              AudioManager.clearAudioCache('example.mp3');
            });
            statsBloc.add(const PlayerRespawned());
          },
        ));
      case GameStatus.levelLooseFreeze:
        showAlert(WinLoseAlert(
            isWinning: false,
            isFreeze: true,
            onContinue: () {
              context.read<InventoryBloc>().add(const ResetInventory());
              statsBloc.add(const PlayerRespawned());
            }));
      case GameStatus.levelLooseBurn:
        showAlert(WinLoseAlert(
            isWinning: false,
            isFreeze: false,
            onContinue: () {
              context.read<InventoryBloc>().add(const ResetInventory());
              statsBloc.add(const PlayerRespawned());
            }));
      case GameStatus.levelWin:
        showAlert(WinLoseAlert(
            isWinning: true,
            onContinue: () {
              context.read<InventoryBloc>().add(const ResetInventory());
              statsBloc.add(const NextLevel());
            }));
      case GameStatus.gameWin:
        //diff
        showAlert(WinLoseAlert(
            isWinning: true,
            onContinue: () {
              context.read<InventoryBloc>().add(const ResetInventory());
              statsBloc.add(const GameReset());
            }));
    }
    return const Stack(
      children: [
        Positioned(top: 50, right: 10, child: TemperatureInfo()),
        Positioned(top: 150, right: 10, child: TimeLeftWidget()),
        Positioned(top: 50, right: 100, child: LevelInfo()),
      ],
    );
  }
}
