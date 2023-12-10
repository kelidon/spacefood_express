import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:spacefood_express/actors/planet.dart';
import 'package:spacefood_express/actors/player.dart';
import 'package:spacefood_express/blocs/game_stats/game_stats_bloc.dart';
import 'package:spacefood_express/flame_layer/spacefood_game.dart';

import '../actors/models/planet_type.dart';

class Level extends PositionComponent
    with HasGameRef<SpaceFoodGame>, FlameBlocListenable<GameStatsBloc, GameStatsState> {
  late PlayerComponent player;
  List<PlanetComponent> allPlanets = [];

  void loadComponents() {
    final objectGroup = game.mapComponent!.tileMap.getLayer<ObjectGroup>('planets');
    for (final object in objectGroup!.objects) {
      PlanetType planetType;
      Property? property = object.properties.byName['type'];
      if (property != null) {
        planetType = PlanetType.fromString(property.value);
      } else {
        planetType = PlanetType.normal;
      }
      allPlanets.add(
        PlanetComponent(
          object.height / 1.1,
          object.x,
          object.y,
          -0.02,
          object.height,
          object.width,
          planetType,
        ),
      );
    }

    player = PlayerComponent(allPlanets.firstWhere(
      (e) => e.planetType == PlanetType.spawn,
    ));

    //center player relative to the camera;
    player.anchor = Anchor.center;

    //obviously;
    gameRef.camera.follow(player);

    addAll(allPlanets);
    add(player);
  }

  void resetLevel(){
    print("here");
    player.planet = allPlanets.firstWhere(
          (e) => e.planetType == PlanetType.spawn,
    );
    player.isFlying = false;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    loadComponents();
  }

  @override
  void update(double dt) {
    //stop player when reach bounds
    if (gameRef.mapComponent != null) {
      player.position = Vector2(
        player.position.x.clamp(0, gameRef.mapComponent!.size.x),
        player.position.y.clamp(0, gameRef.mapComponent!.size.y),
      );
    }
  }
}