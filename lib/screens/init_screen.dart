import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/authentication_controller.dart';
import 'auth_screen/sign_in_screen.dart';
import 'manage_screen.dart';
import 'unknown_screen.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthenticationController>(
      builder: (controller) {
        log("authentication controller");
        switch (controller.status) {
          case AuthenticationStatus.authentication:
            return const ManageScreen();
          case AuthenticationStatus.un_authentication:
            return SignInScreen();
          default:
            return const UnknownScreen();
        }
      },
    );
  }
}
