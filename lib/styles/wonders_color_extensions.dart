import 'package:yleon/common_libs.dart';

extension WonderColorExtensions on WonderType {
  Color get bgColor {
    return switch (this) {
      WonderType.yhody_wonder1 => const Color(0xFF16184D),
    };
  }

  Color get fgColor {
    return switch (this) {
      WonderType.yhody_wonder1 => const Color(0xFF4AA39D),
    };
  }
}

extension ColorFilterOnColor on Color {
  ColorFilter get colorFilter => ColorFilter.mode(this, BlendMode.srcIn);
}
