import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:docx_viewer/docx_viewer.dart';
import '../controllers/pdfcontroller.dart';
import '../ui_component/customappbar.dart';

class ViewDocx extends StatelessWidget {
  const ViewDocx({super.key});

  @override
  Widget build(BuildContext context) {
    final Pdfcontroller controller = Get.find<Pdfcontroller>();  // Get the controller
    // Extract the file name from the file path
    String fileName = '';
    if (controller.status.value.isNotEmpty) {
      fileName = controller.status.value.split('/').last;  // Get the file name from the path
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
                  ? DocxView(filePath: controller.status.value)  // For online DOCX files
                  : DocxView(filePath: controller.status.value)  // For local DOCX files (pass the path as a string)
              : Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
