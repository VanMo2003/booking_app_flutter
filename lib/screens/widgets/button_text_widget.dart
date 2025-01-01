import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/dimensions.dart';
import '../../utils/style.dart';

class ButtonTextWidget extends StatelessWidget {
  const ButtonTextWidget({
    super.key,
    required this.label,
    required this.onTap,
  });

  final void Function() onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: Get.height * 0.06,
        padding: const EdgeInsets.symmetric(
            horizontal: DimensionUtils.PADDING_SIZE_DEFAULT),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            label,
            style: StyleUtils.button
                .copyWith(color: Colors.white.withOpacity(0.9)),
          ),
        ),
      ),
    );
  }
}
