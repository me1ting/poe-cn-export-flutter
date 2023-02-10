import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

const settingsFileName = 'config.json';

/// The application settings.
class Settings {
  var poeSessId = "";
  var pobPath = "";
  var port = 0;
  var isPobProxySupported = false;

  Settings();

  factory Settings.fromJson(Map<String, dynamic> json) {
    var settings = Settings();
    if (json.containsKey("poeSessId")) {
      settings.poeSessId = json['poeSessId'];
    }
    if (json.containsKey("pobPath")) {
      settings.pobPath = json['pobPath'];
    }
    if (json.containsKey("port")) {
      settings.port = json['port'];
    }
    if (json.containsKey("isPobProxySupported")) {
      settings.isPobProxySupported = json['isPobProxySupported'];
    }

    return settings;
  }

  Map<String, dynamic> toJson() {
    return {
      "poeSessId": poeSessId,
      "pobPath": pobPath,
      "port": port,
      "isPobProxySupported": isPobProxySupported,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}

/// SettingsManager is used to load or save settings.
///
/// User should call load() to init settings.
///
/// User should call save() to write settings to disk if the settings changed finally.
class SettingsManager {
  late Settings settings; //init by load()
  late File _settingsFile; //init by load()

  /// Load settings from application data floor.
  Future<void> load() async {
    var supportDirecory = await getApplicationSupportDirectory();
    _settingsFile = File(p.join(supportDirecory.path, settingsFileName));
    if (await _settingsFile.exists()) {
      //load from ${supportDirectory}
      var jsonString = await _settingsFile.readAsString();
      Map<String, dynamic> json = jsonDecode(jsonString);
      settings = Settings.fromJson(json);
      return;
    }

    settings = Settings();
    save();
  }

  /// Save settings to disk.
  Future<void> save() async {
    var json = settings.toJson();
    await _settingsFile.writeAsString(jsonEncode(json));
  }
}

void main(List<String> args) async {
  var manager = SettingsManager();
  await manager.load();
  print(manager.settings);
}
