import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flame_layer/src/actors/models/planet_type.dart';
import 'package:flame_layer/src/actors/planet.dart';
import 'package:flame_layer/src/actors/player.dart';
import 'package:flame_layer/src/blocs/game_stats/game_stats_bloc.dart';
import 'package:flame_layer/src/flame_layer/spacefood_game.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends PositionComponent
    with
        HasGameRef<SpaceFoodGame>,
        FlameBlocListenable<GameStatsBloc, GameStatsState> {
  int levelNumber;
  late PlayerComponent player;
  List<PlanetComponent> allPlanets = [];
  late PlanetComponent finishPlanet;
  late PlanetComponent spawnPlanet;

  Level(this.levelNumber);

  void loadComponents() {
    final objectGroup =
        game.mapComponent!.tileMap.getLayer<ObjectGroup>('planets');
    for (final object in objectGroup!.objects) {
      PlanetType planetType;
      // print(object.properties.first.name);
      Property? property = object.properties.byName['type'];
      if (property != null) {
        planetType = PlanetType.fromString(property.value as String);
      } else {
        planetType = PlanetType.normal;
      }
      final planet = PlanetComponent(
        object.height / 1.1,
        object.x,
        object.y,
        -0.02,
        object.height,
        object.width,
        planetType,
      );

      allPlanets.add(planet);

      if (planetType == PlanetType.finish) {
        finishPlanet = planet;
      }
      if (planetType == PlanetType.spawn) {
        spawnPlanet = planet;
      }
    }

    player = PlayerComponent(spawnPlanet);

    //center player relative to the camera;
    player.anchor = Anchor.center;

    //obviously;
    gameRef.camera.follow(player);

    addAll(allPlanets);
    add(player);
  }

  void resetPlayer() {
    player
      ..planet = spawnPlanet
      ..isFlying = false;
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
