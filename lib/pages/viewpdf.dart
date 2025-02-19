import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controllers/pdfcontroller.dart';
import '../ui_component/customappbar.dart';

class Viewpdf extends StatelessWidget {
  const Viewpdf({super.key});

  @override
  Widget build(BuildContext context) {
    final Pdfcontroller controller = Get.find<Pdfcontroller>();

    // Extract the file name from the file path
    String fileName = '';
    if (controller.status.value.isNotEmpty) {
      fileName = controller.status.value.split('/').last;
    }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(
          title: fileName,
          leading: true,
        ),
        body: Obx(() {
          return controller.status.value.isNotEmpty
              ? controller.status.value.startsWith('http')
                  ? SfPdfViewer.network(controller.status.value)  // For online PDFs use network
                  : SfPdfViewer.file(File(controller.status.value))  // For local PDFs use file
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
