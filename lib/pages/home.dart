import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/pdfcontroller.dart';
import '../ui_component/customappbar.dart';
import '../ui_component/custombutton.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final Pdfcontroller controller = Get.put(Pdfcontroller());

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(title: "Home", leading: false),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 8),
              CustomButton(
                text: 'assets PDF 1',
                onPressed: () async {
                  await controller.openFile(0);  // Open the file
                },
              ),
              SizedBox(height: 8),
              CustomButton(
                text: 'assets PDF 2',
                onPressed: () async {
                  await controller.openFile(1);
                },
              ),
              SizedBox(height: 8),
              CustomButton(
                text: 'assets PDF 3',
                onPressed: () async {
                  await controller.openFile(2);
                },
              ),
              
              SizedBox(height: 8),
              CustomButton(
                text: 'DOCX type',
                onPressed: () async {
                  await controller.openFile(3);  // DOCX file
                },
              ),
              SizedBox(height: 8),
              CustomButton(
                text: 'online pdf',
                onPressed: () async {
                  await controller.openFile(4);  // DOCX file
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
