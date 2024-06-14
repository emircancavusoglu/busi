import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

Future<List<File?>> getMultipleFile() async {
  final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['xlsx'],);
  if (result != null) {
    final List<File?> file =
    result.paths.map((path) => File(path!)).toList();
    return file;
  } else {
    throw Exception('Dosya seçilmedi');
  }
}

