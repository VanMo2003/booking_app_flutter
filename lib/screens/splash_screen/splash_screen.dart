import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../controller/authentication_controller.dart';
import '../../helpers/route_helper.dart';
import '../../utils/assets_utils.dart';
import '../../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    route();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.8,
            fit: BoxFit.cover,
            image: AssetImage(
              AssetsUtils.background,
            ),
          ),
        ),
        alignment: Alignment.center,
        child: TweenAnimationBuilder<double>(
          duration:
              const Duration(milliseconds: DimensionUtils.TIME_LOADING_DEFAULT),
          tween: Tween<double>(begin: -1, end: 1),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 0),
              child: Transform.scale(
                scale: value < 0 ? 0 : value,
                child: Image.asset(
                  width: DimensionUtils.ICON_SIZE_SPLASH,
                  AssetsUtils.logoBooking,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future route() async {
    String? tokenLogin =
        await Get.find<AuthenticationController>().authRepo.getUserToken();
    if (tokenLogin != null) {
      log("token : $tokenLogin");

      Get.find<AuthenticationController>().introspect().then(
        (value) {
          if (value) {
            Get.find<AuthenticationController>()
                .setStatus(AuthenticationStatus.authentication);
          } else {
            Get.find<AuthenticationController>().refreshToken();
          }
        },
      );
    }

    Future.delayed(
      const Duration(milliseconds: DimensionUtils.TIME_SPLASH),
      () {
        Get.offAllNamed(RouteHelper.initial);
      },
    );
  }
}
