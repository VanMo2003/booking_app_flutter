import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/dimensions.dart';
import '../../../../utils/language/key_language.dart';
import '../../../../utils/style.dart';

class PopularPlaceWidget extends StatelessWidget {
  const PopularPlaceWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: DimensionUtils.PADDING_SIZE_LARGE),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(DimensionUtils.BORDER_RADIUS_DEFAULT),
        ),
        child: ListTile(
          title: Text(
            KeyLanguage.popularPlace.tr,
            style: StyleUtils.titleItem.copyWith(
              fontSize: DimensionUtils.FONT_SIZE_EXTRA_LARGE,
            ),
          ),
          trailing: Text(
            KeyLanguage.seeAll.tr,
            style: StyleUtils.link,
          ),
        ),
      ),
    );
  }
}
