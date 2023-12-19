import 'package:shared/src/common/assets/shared_asset.dart';

abstract class SharedAssets {
  static const String currentPackageName = 'shared';
  static const SharedAsset testPlanet = SharedAsset(
    asset: 'assets/images/test_planet.png',
    package: currentPackageName,
  );
  static const SharedAsset testPlanet2 = SharedAsset(
    asset: 'assets/images/test_planet_2.png',
    package: currentPackageName,
  );
  static const SharedAsset testPlanet3 = SharedAsset(
    asset: 'assets/images/test_planet_3.png',
    package: currentPackageName,
  );
}
