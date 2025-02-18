import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../pages/viewpdf.dart';
import '../pages/viewdocx.dart';  // Import the ViewDocx screen

class Pdfcontroller extends GetxController {
  final List<String> assetPath = [
    'assets/files/150kB.pdf',
    'assets/files/file-sample_PDF_1MB.pdf',
    'assets/files/file-sample_PDF_500_kB.pdf',
    'assets/files/sampledocx.docx',
    'https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf'
  ];

  RxString status = ''.obs;

  // Load asset based on the index
  Future<String> loadAsset(int index) async {
    final ByteData data = await rootBundle.load(assetPath[index]);
    final buffer = data.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final fileName = assetPath[index].split('/').last;
    final tempFile = File('${tempDir.path}/$fileName');

    await tempFile.writeAsBytes(buffer, flush: true);
    return tempFile.path;
  }

  // Open the file (either PDF or DOC/DOCX)
  Future<void> openFile(int index) async {
    final filePath = await loadAsset(index);
    status.value = filePath;

    // Check the file extension to decide if it's a PDF or DOC/DOCX
    String extension = filePath.split('.').last.toLowerCase();

    if (extension == 'pdf') {
      Get.to(() => Viewpdf());
      // PDF file show a snackbar and proceed to view PDF
      Get.snackbar(
        'File Opened',
        'The PDF file has been opened successfully.',
        colorText: Colors.white,
        backgroundColor: Colors.black54,
      );
      
    } 
    else if (extension == 'doc' || extension == 'docx') {
      Get.to(() => ViewDocx());
      Get.snackbar(
        'File Opened',
        'The Document file has been opened successfully.',
        colorText: Colors.white,
        backgroundColor: Colors.black54,
      );
    }
  }
}
