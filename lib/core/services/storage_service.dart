import 'dart:convert';

import 'package:hive_ce_flutter/hive_flutter.dart';

class StorageService {
  static const String boxName = 'app_box';
  final Box _box = Hive.box(boxName);

  // Generic put
  Future<void> write(String key, dynamic value) async {
    if (value is String) {
      await _box.put(key, value);
    } else {
      // store JSON strings
      await _box.put(key, jsonEncode(value));
    }
  }

  // Generic read
  T? read<T>(String key) {
    final raw = _box.get(key);
    if (raw == null) return null;
    if (raw is String) {
      try {
        final decoded = jsonDecode(raw);
        return decoded as T?;
      } catch (_) {
        // not JSON, return as T if castable
        return raw as T?;
      }
    } else {
      return raw as T?;
    }
  }

  Future<void> delete(String key) => _box.delete(key);

  // Tasks helper - stores all tasks as list under 'tasks'
  Future<void> saveAllTasks(List<Map<String, dynamic>> tasks) async {
    await write('tasks', tasks);
  }

  List<Map<String, dynamic>> getAllTasks() {
    final raw = read('tasks');
    if (raw == null) return [];
    // raw should be List<dynamic>
    final list = raw as List<dynamic>;
    return list.map((e) => Map<String, dynamic>.from(e)).toList();
  }

  // Settings (rule toggles)
  Future<void> saveSettings(Map<String, dynamic> settings) async {
    await write('settings', settings);
  }

  Map<String, dynamic> getSettings() {
    final raw = read('settings');
    if (raw == null) return {};
    return Map<String, dynamic>.from(raw);
  }
}
