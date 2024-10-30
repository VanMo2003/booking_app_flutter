import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../helpers/route_helper.dart';
import '../../utils/assets_utils.dart';
import '../../utils/color_constant.dart';
import '../../utils/dimensions.dart';
import '../../utils/style.dart';

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TweenAnimationBuilder<double>(
            duration: const Duration(
                milliseconds: DimensionUtils.TIME_LOADING_DEFAULT),
            tween: Tween<double>(begin: -1, end: 1),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(
                    (size.width - DimensionUtils.ICON_SIZE_LOGO) / 2 * value,
                    0),
                child: Transform.scale(
                  scale: value < 0 ? 0 : value,
                  child: SizedBox(
                    height: DimensionUtils.ICON_SIZE_LOGO,
                    child: Image.asset(AssetsUtils.logoHotel),
                  ),
                ),
              );
            },
          ),
          TweenAnimationBuilder<double>(
            duration: const Duration(
                milliseconds: DimensionUtils.TIME_LOADING_DEFAULT),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(
                  (size.width - DimensionUtils.ICON_SIZE_LOGO) / 2,
                  0,
                ),
                child: Transform.scale(
                  scale: value,
                  child: Text(
                    "Booking",
                    style: StyleUtils.titleLarge
                        .copyWith(color: ColorConstant.getPrimaryColor()),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  route() {
    Future.delayed(
      const Duration(milliseconds: DimensionUtils.TIME_SPLASH),
      () {
        Get.offNamed(RouteHelper.getInitialRoute());
      },
    );
  }
}
