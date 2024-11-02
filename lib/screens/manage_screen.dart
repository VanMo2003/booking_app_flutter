import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';
import 'home/admin/admin_screen.dart';
import 'home/hotelier/hotelier_screen.dart';
import 'home/user/user_sceen.dart';

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
    return GetBuilder<UserController>(
      builder: (controller) {
        switch (controller.roles) {
          case Roles.admin:
            return AdminScreen();
          case Roles.hotelier:
            return HotelierScreen();
          case Roles.user:
            return UserScreen();
          default:
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
