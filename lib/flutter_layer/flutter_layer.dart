import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spacefood_express/flutter_layer/level_info_widget.dart';
import 'package:spacefood_express/flutter_layer/temperature_info_widget.dart';
import 'package:spacefood_express/flutter_layer/time_left_widget.dart';

import '../blocs/game_stats/game_stats_bloc.dart';
import 'level_start_alert.dart';

class FlutterLayer extends StatefulWidget {
  const FlutterLayer({super.key});

  @override
  State<FlutterLayer> createState() => _FlutterLayerState();
}

class _FlutterLayerState extends State<FlutterLayer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameStatsBloc, GameStatsState>(
        builder: (context, state) {
      print('qqq ${state.status}');
      if (state.status == GameStatus.initial) {
        Future.delayed(Duration.zero, () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => const LevelStartAlert(
              foodName: 'Pasta',
              image: 'background',
            )));
      }
      return const Column(
        children: [
          //GameStat(),
          Expanded(
            child: Stack(
              children: [
                //todo - extra info on game screen
                Positioned(top: 50, right: 10, child: TemperatureInfo()),
                Positioned(top: 150, right: 10, child: TimeLeftWidget()),
                Positioned(top: 50, right: 100, child: LevelInfo()),

                /// perfect ->  Stack(children: [FlameLayer(), FlutterLayer())
              ],
            ),
          ),
        ],
      );
    });
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
