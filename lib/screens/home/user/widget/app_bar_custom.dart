import 'dart:developer';

import 'package:demo_booking_app/controller/user_controller.dart';
import 'package:demo_booking_app/data/models/response/user_response.dart';
import 'package:demo_booking_app/helpers/route_helper.dart';
import 'package:demo_booking_app/utils/language/key_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../utils/dimensions.dart';
import '../../../../utils/style.dart';

class AppBarCustom extends StatefulWidget {
  const AppBarCustom({super.key, required this.openDrawer});

  final VoidCallback openDrawer;

  @override
  State<AppBarCustom> createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  UserResponse? user;

  @override
  void initState() {
    super.initState();

    user = Get.find<UserController>().user;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: DimensionUtils.PADDING_SIZE_SMALL),
        child: Column(
          children: [
            ListTile(
              leading: GestureDetector(
                onTap: () {
                  widget.openDrawer();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      DimensionUtils.BORDER_RADIUS_EXTRA_LARGE,
                    ),
                    color: Colors.white,
                  ),
                  child: const Icon(Icons.person, size: 30),
                ),
              ),
              title: Center(
                child: Text(
                  user!.fullName ?? KeyLanguage.fullname.tr,
                  style: StyleUtils.titleLarge.copyWith(
                    fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
                  ),
                ),
              ),
              trailing: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    DimensionUtils.BORDER_RADIUS_EXTRA_LARGE,
                  ),
                  color: Colors.white,
                ),
                child: const Icon(Icons.notifications, size: 30),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensionUtils.PADDING_SIZE_SMALL * 2,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.search);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          DimensionUtils.BORDER_RADIUS_DEFAULT,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Tìm kiếm",
                          style: StyleUtils.button.copyWith(
                            fontSize: DimensionUtils.FONT_SIZE_SMALL,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT,
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            DimensionUtils.BORDER_RADIUS_DEFAULT)),
                    child: Center(
                      child: Text(
                        "Sắp xếp",
                        style: StyleUtils.button.copyWith(
                          fontSize: DimensionUtils.FONT_SIZE_SMALL,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
