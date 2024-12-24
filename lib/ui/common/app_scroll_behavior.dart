import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:yleon/common_libs.dart';
import 'package:yleon/logic/common/platform_info.dart';

class AppScrollBehavior extends ScrollBehavior {
  @override
  // Agregar arrastre con el ratón en el escritorio para facilitar las pruebas de diseño adaptable
  Set<PointerDeviceKind> get dragDevices {
    final devices = Set<PointerDeviceKind>.from(super.dragDevices);
    devices.add(PointerDeviceKind.mouse);
    return devices;
  }

  // Usar física de rebote en todas las plataformas, lo que coincide mejor con el diseño de la aplicación
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics();

  @override
  Widget buildScrollbar(BuildContext context, Widget child, ScrollableDetails details) {
    if (PlatformInfo.isMobile) return child;
    return RawScrollbar(
      controller: details.controller,
      thumbVisibility: PlatformInfo.isDesktopOrWeb,
      thickness: 8,
      interactive: true,
      child: child,
    );
  }
}
