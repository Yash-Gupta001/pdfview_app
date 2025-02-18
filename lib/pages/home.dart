import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

import '../ui_component/customappbar.dart';



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppbar(title: "Home", leading: false),
      ),
    );
  }
}