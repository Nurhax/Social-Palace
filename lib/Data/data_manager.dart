import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataManager {
  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/data.json';
  }

  Future<File> _getFile() async {
    final path = await _getFilePath();
    return File(path);
  }

  Future<Map<String, dynamic>> _readData() async {
    try {
      final file = await _getFile();
      if (!await file.exists()) {
        // Initialize with empty list if file doesn't exist
        return {"ids": []};
      }
      final contents = await file.readAsString();
      return json.decode(contents);
    } catch (e) {
      // If error (e.g. corrupted), return empty
      return {"ids": []};
    }
  }

  Future<void> _writeData(Map<String, dynamic> data) async {
    final file = await _getFile();
    await file.writeAsString(json.encode(data));
  }

  // Insert a new ID
  Future<void> saveId(String id) async {
    final data = await _readData();
    List<dynamic> ids = data['ids'] ?? [];

    // Avoid duplicates
    if (!ids.contains(id)) {
      ids.add(id);
      data['ids'] = ids;
      await _writeData(data);
    }
  }

  // Check if ID exists
  Future<bool> checkId(String id) async {
    final data = await _readData();
    List<dynamic> ids = data['ids'] ?? [];
    return ids.contains(id);
  }
}
