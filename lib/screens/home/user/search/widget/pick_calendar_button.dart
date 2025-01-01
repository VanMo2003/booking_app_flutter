import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/color_constant.dart';
import '../../../../../utils/dimensions.dart';
import '../../../../../utils/style.dart';

class PickCalendarButton extends StatelessWidget {
  const PickCalendarButton(
      {super.key, required this.label, required this.onTap});

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        onTap();
      },
      child: Container(
        height: 50,
        width: Get.width * 0.8 / 2 -
            DimensionUtils.PADDING_SIZE_DEFAULT -
            DimensionUtils.SIZE_BOX_HEIGHT_EXTRA_SMALL,
        decoration: BoxDecoration(
          color: ColorConstant.getBackgroundPrimary(),
          borderRadius: BorderRadius.circular(
            DimensionUtils.BORDER_RADIUS_EXTRA_LARGE,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: StyleUtils.button,
          ),
        ),
      ),
    );
  }
}
