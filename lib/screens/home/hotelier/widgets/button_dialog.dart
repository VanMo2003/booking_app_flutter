import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/dimensions.dart';

class ButtonDialog extends StatelessWidget {
  const ButtonDialog({
    super.key,
    required this.label,
    this.onTap,
    this.isCancel = false,
  });

  final String label;
  final void Function()? onTap;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(DimensionUtils.PADDING_SIZE_SMALL),
        decoration: BoxDecoration(
          color: isCancel
              ? ColorConstant.getPrimaryColor().withOpacity(0.2)
              : ColorConstant.getPrimaryColor(),
          borderRadius: BorderRadius.circular(
            DimensionUtils.BORDER_RADIUS_DEFAULT,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.roboto(
              fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
            ),
          ),
        ),
      ),
    );
  }
}
