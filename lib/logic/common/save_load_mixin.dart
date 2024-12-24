import 'package:flutter/foundation.dart';
import 'package:yleon/logic/common/json_prefs_file.dart';
import 'package:yleon/logic/common/throttler.dart';

mixin ThrottledSaveLoadMixin {
  //obtener los datos de las preferencias en formato Map, guardado en json
  late final _file = JsonPrefsFile(fileName);
  // Se asegura de que no se guarde algo más de una vez cada 2 segundos.
  final _throttle = Throttler(const Duration(seconds: 2));

  Future<void> load() async {
    final results = await _file.load();
    try {
      copyFromJson(results);
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> save() async {
    if (!kIsWeb) debugPrint('Saving...');
    try {
      await _file.save(toJson());
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> scheduleSave() async => _throttle.call(save);

  /// Serialization
  String get fileName;
  Map<String, dynamic> toJson();
  void copyFromJson(Map<String, dynamic> value);
}
