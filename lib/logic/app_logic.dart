import 'dart:async';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';

import 'package:flutter/foundation.dart';
import 'package:yleon/common_libs.dart';
import 'package:yleon/logic/common/platform_info.dart';
class AppLogic {
  /// Indicates to the rest of the app that bootstrap has not completed.
  /// The router will use this to prevent redirects while bootstrapping.
  bool isBootstrapComplete = false;

  /// Initialize the app and all main actors.
  /// Loads settings, sets up services etc.
  Future<void> bootstrap() async {
    debugPrint('bootstrap start...');
    // Set min-sizes for desktop apps
    if (PlatformInfo.isDesktop) {
      await DesktopWindow.setMinWindowSize($styles.sizes.minAppSize);
    }

    if (kIsWeb) {
      // SB: This is intentionally not a debugPrint, as it's a message for users who open the console on web.
      print(
        '''Thanks for checking out Wonderous on the web!
        If you encounter any issues please report them at https://github.com/gskinnerTeam/flutter-wonderous-app/issues.''',
      );
      // Required on web to automatically enable accessibility features
      WidgetsFlutterBinding.ensureInitialized().ensureSemantics();
    }

    
    // Set preferred refresh rate to the max possible (the OS may ignore this)
    if (!kIsWeb && PlatformInfo.isAndroid) {
      await FlutterDisplayMode.setHighRefreshRate();
    }
    // Settings
    await settingsLogic.load();
    
    //Iniciando Localizations
    await localeLogic.load();
    
    // Flag bootStrap as complete
    isBootstrapComplete = true;
    // Load initial view (replace empty initial view which is covered by a native splash screen)
    bool showIntro = settingsLogic.hasCompletedOnboarding.value == false;
    if (showIntro) {
      appRouter.go(ScreenPaths.intro);
    } else {
      appRouter.go(initialDeeplink ?? ScreenPaths.home);
    }
     
  }
 
  
}
 