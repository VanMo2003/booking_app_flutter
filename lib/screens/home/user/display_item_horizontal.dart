import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/response/hotel_response.dart';
import '../../../utils/assets_utils.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/formart_utils.dart';
import '../../../utils/language/key_language.dart';
import '../../../utils/style.dart';

class DisplayItemsHorizontal extends StatelessWidget {
  const DisplayItemsHorizontal({super.key, required this.hotel});

  final HotelResponse hotel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(
        left: DimensionUtils.PADDING_SIZE_LARGE,
        bottom: DimensionUtils.PADDING_SIZE_EXTRA_SMALL,
      ),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(DimensionUtils.BORDER_RADIUS_OVER_LARGE),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:
                BorderRadius.circular(DimensionUtils.BORDER_RADIUS_OVER_LARGE),
            child: Hero(
              tag: hotel.pathImage ?? AssetsUtils.hotel,
              child: Image.network(
                hotel.pathImage ?? AssetsUtils.hotel,
                fit: BoxFit.cover,
                height: Get.height * 0.22,
                width: Get.width * 0.6,
              ),
            ),
          ),
          Container(
            height: Get.height * 0.18,
            width: Get.width * 0.6,
            padding: const EdgeInsets.only(
              top: DimensionUtils.PADDING_SIZE_DEFAULT,
              left: DimensionUtils.PADDING_SIZE_LARGE,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.nameHotel ?? KeyLanguage.nameHotel.tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleUtils.titleItem.copyWith(height: 1.2),
                ),
                Text(
                  hotel.address ?? KeyLanguage.address.tr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: StyleUtils.addressItem,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        maxLines: 1,
                        "${FormartUtils.formatDoubleToVND(hotel.rooms!.isNotEmpty ? hotel.rooms![0].price ?? 0 : 200000)} ",
                        style: StyleUtils.priceItem,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          log("Lưu vào yêu thích");
                        },
                        child: Container(
                          width: 41,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.red.withOpacity(0.5),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.bookmark,
                            color: Color(0xFFf9f9fa),
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
