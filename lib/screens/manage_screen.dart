import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';

class ManageScreen extends StatefulWidget {
  const ManageScreen({super.key});

  @override
  State<ManageScreen> createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<UserController>().getMyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Home"),
      ),
    );
  }
}
