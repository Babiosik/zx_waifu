import 'dart:io';

import 'package:path_provider/path_provider.dart';

class IOFile {

  final String fileName;

  IOFile(this.fileName);

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$fileName');
  }

  Future<String> read() async {
    try {
      final file = await _localFile;

      // Read the file
      String content = await file.readAsString();

      return content;
    } catch (e) {
      // If encountering an error, return 0
      return "Error";
    }
  }

  Future<File> write(String content) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString('$content');
  }
}