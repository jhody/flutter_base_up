
import 'package:yleon/common_libs.dart';
/// Consolidates raster image paths used across the app
class ImagePaths {
  static String root = 'assets/images';
  static String common = 'assets/images/_common';
  static String cloud = '$common/cloud-white.png';

  static String collectibles = '$root/collectibles';
  static String particle = '$common/particle-21x23.png';
  static String ribbonEnd = '$common/ribbon-end.png';

  static String textures = '$common/texture';
  static String icons = '$common/icons';

  static String roller1 = '$textures/roller-1-white.gif';
  static String roller2 = '$textures/roller-2-white.gif';

  static String appLogo = '$common/app-logo.png';
  static String appLogoPlain = '$common/app-logo-plain.png';
}
/// Consolidates SCG image paths in their own class, hints to the UI to use an SvgPicture to render
class SvgPaths {
  static String compassFull = '${ImagePaths.common}/compass-full.svg';
  static String compassSimple = '${ImagePaths.common}/compass-simple.svg';
}
/// For wonder specific assets, add an extension to [WonderType] for easy lookup
extension WonderAssetExtensions on WonderType {
  String get assetPath {
    return switch (this) {
      WonderType.yhody_wonder1 => '${ImagePaths.root}/yhody_wonder1'//yhody
      /*WonderType.greatWall => '${ImagePaths.root}/great_wall_of_china',
      WonderType.petra => '${ImagePaths.root}/petra',
      WonderType.colosseum => '${ImagePaths.root}/colosseum',
      WonderType.chichenItza => '${ImagePaths.root}/chichen_itza',
      WonderType.machuPicchu => '${ImagePaths.root}/machu_picchu',
      WonderType.tajMahal => '${ImagePaths.root}/taj_mahal',
      WonderType.christRedeemer => '${ImagePaths.root}/christ_the_redeemer'*/
    };
  }


  String get homeBtn => '$assetPath/wonder-button.png';
}