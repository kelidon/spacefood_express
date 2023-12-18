enum PlanetType {
  normal,
  spawn,
  finish;

  static PlanetType fromString(String value) {
    switch (value) {
      case 'spawn':
        return PlanetType.spawn;
      case 'finish':
        return PlanetType.finish;
      default:
        return PlanetType.normal;
    }
  }
}
