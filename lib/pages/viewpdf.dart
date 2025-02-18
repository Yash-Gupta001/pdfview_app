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
      fileName = controller.status.value.split('/').last;//last part of the file path as the file name
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: fileName, //PDF file name in the AppBar
        leading: true,
      ),
      body: Obx(() {
        return controller.status.value.isNotEmpty
            ? SfPdfViewer.file(File(controller.status.value))  
            : Center(child: CircularProgressIndicator());  // Show a loading indicator until pdf loads
      }),
    );
  }
}