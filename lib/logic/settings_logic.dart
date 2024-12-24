
import 'package:yleon/common_libs.dart';
import 'package:yleon/logic/common/save_load_mixin.dart';

class SettingsLogic with ThrottledSaveLoadMixin {
  @override
  String get fileName => 'settings.dat';

  late final currentLocale = ValueNotifier<String?>(null)..addListener(scheduleSave);

  @override
  void copyFromJson(Map<String, dynamic> value) {
    currentLocale.value = value['currentLocale'];
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'currentLocale': currentLocale.value,
    };
  }
}