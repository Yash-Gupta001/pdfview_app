import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

class Pdfcontroller extends GetxController {
  // Define the file names in assets
  final List<String> assetPath = [
    'assets/files/file-sample_150kB.pdf',
    'assets/files/file-sample_PDF_1MB.pdf',
    'assets/files/file-sample_PDF_500_kB.pdf',
  ];

  RxString status = ''.obs; // Keep track of the PDF file path

  // Load a specific asset based on index
  Future<String> loadAsset(int index) async {
    final ByteData data = await rootBundle.load(assetPath[index]);
    final buffer = data.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final fileName = assetPath[index].split('/').last;
    final tempFile = File('${tempDir.path}/$fileName');

    await tempFile.writeAsBytes(buffer, flush: true);
    return tempFile.path;
  }

  // Open the PDF file (store the file path in the status)
  Future<void> openPdfFile(int index) async {
    final filePath = await loadAsset(index);
    status.value = filePath; // Set the file path in status

    // Optionally, you can show a snackbar when a PDF is opened
    Get.snackbar(
      'File Opened',
      'The file has been opened successfully.',
      colorText: Colors.white,
      backgroundColor: Colors.black54,
    );
  }
}
