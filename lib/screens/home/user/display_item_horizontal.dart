import 'package:demo_booking_app/data/models/response/hotel_response.dart';
import 'package:demo_booking_app/utils/assets_utils.dart';
import 'package:demo_booking_app/utils/dimensions.dart';
import 'package:demo_booking_app/utils/formart_utils.dart';
import 'package:demo_booking_app/utils/language/key_language.dart';
import 'package:demo_booking_app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                        "${FormartUtils.formatDoubleToVND(hotel.price ?? 0)} ",
                        style: StyleUtils.priceItem,
                      ),
                      const Spacer(),
                      Container(
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
