sealed class RouteParameters {
  RouteParameters();
}

class LevelRouteParameters extends RouteParameters {
  final int level;

  LevelRouteParameters({
    required this.level,
  });
}
