import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  static final String fileDirName = 'images';
  static String documentsDir = '';

  static Future initDir() async {
    var documents = await getApplicationDocumentsDirectory();
    documentsDir = documents.path;
    var path = p.join(documentsDir, fileDirName);
    var directory = Directory(path);
    if (!directory.existsSync()) directory.createSync();
  }

  static String filePath(String filename) {
    return '$documentsDir/$fileDirName/$filename';
  }

  static Future<String> copyImage(String path) async {
    var extension = p.extension(path);
    var filename = '${DateTime.now().millisecondsSinceEpoch}$extension';
    var newPath = filePath(filename);

    await File(path).copy(newPath);
    return filename;
  }
}
