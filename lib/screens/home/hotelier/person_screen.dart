import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/authentication_controller.dart';
import '../../../controller/loading_controller.dart';

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.find<LoadingController>().loading(
            handle: () {
              Get.find<AuthenticationController>().logout();
            },
          );
        },
        child: Container(
          height: 60,
          width: Get.width * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              "Đăng xuất",
              style: GoogleFonts.roboto(),
            ),
          ),
        ),
      ),
    );
  }
}
