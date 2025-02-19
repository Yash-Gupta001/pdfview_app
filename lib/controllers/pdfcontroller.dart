import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // For platform check
import 'package:http/http.dart' as http; 

import '../pages/viewpdf.dart';
import '../pages/viewdocx.dart';
import '../pages/viewdoc.dart';


class Pdfcontroller extends GetxController {
  final List<String> assetPath = [
    'assets/files/150kB.pdf',
    'assets/files/file-sample_PDF_1MB.pdf',
    'assets/files/file-sample_PDF_500_kB.pdf',
    'assets/files/sampledocx.docx',
    'https://www.orimi.com/pdf-test.pdf', 
    'assets/files/30mbdocx.docx',
    'assets/files/sampledoc.doc',
    'https://file-examples-com.github.io/uploads/2017/02/file-sample_100kB.docx'
  ];

  RxString status = ''.obs;

  // Load asset based on the index
  Future<String> loadAsset(int index) async {
    String filePath = assetPath[index];
    String tempFilePath = '';

    if (filePath.startsWith('http')) {
      // Handle remote file URL (e.g., download PDF from the internet)
      tempFilePath = await _downloadFile(filePath);
    } else {
      // Handle local assets
      final ByteData data = await rootBundle.load(filePath);
      final buffer = data.buffer.asUint8List();
      if (!kIsWeb) {
        final tempDir = await getTemporaryDirectory();
        final fileName = filePath.split('/').last;
        final tempFile = File('${tempDir.path}/$fileName');
        await tempFile.writeAsBytes(buffer, flush: true);
        tempFilePath = tempFile.path;
      } else {
        // For web, we don't write to disk, but instead, use the file as-is
        tempFilePath = filePath;
      }
    }

    return tempFilePath;
  }

  // Method to download file from URL
  Future<String> _downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final tempDir = await getTemporaryDirectory();
      final fileName = url.split('/').last;
      final tempFile = File('${tempDir.path}/$fileName');
      await tempFile.writeAsBytes(bytes, flush: true);
      return tempFile.path;
    } else {
      throw Exception('Failed to download file: ${response.statusCode}');
    }
  }

  // Open the file
  Future<void> openFile(int index) async {
    final filePath = await loadAsset(index);
    status.value = filePath;

    // Check the file extension to decide it is PDF or DOC/DOCX
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

    else if (extension == 'doc') {
      Get.to(() => ViewDoc());
      Get.snackbar(
        'File Opened',
        'The Document file has been opened successfully.',
        colorText: Colors.white,
        backgroundColor: Colors.black54,
      );
    }

    else if (extension == 'docx') {
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
