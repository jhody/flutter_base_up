import 'dart:async';

import 'package:yleon/common_libs.dart';
class AppLogic {
  /// Initialize the app and all main actors.
  /// Loads settings, sets up services etc.
  Future<void> bootstrap() async {
    debugPrint('bootstrap start...');
    //Iniciando Localizations
    await localeLogic.load();
    
     
  }
 
  
}
 