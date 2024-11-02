import 'package:demo_booking_app/utils/dimensions.dart';
import 'package:demo_booking_app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PickCalendarButton extends StatelessWidget {
  const PickCalendarButton(
      {super.key, required this.label, required this.onTap});

  final VoidCallback onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 50,
        width: Get.width / 2 -
            DimensionUtils.PADDING_SIZE_EXTRA_LARGE -
            DimensionUtils.SIZE_BOX_HEIGHT_EXTRA_SMALL,
        decoration: BoxDecoration(
          color: Colors.white,
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
