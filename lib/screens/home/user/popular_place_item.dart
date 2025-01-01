import '../../../data/models/response/hotel_response.dart';
import '../../../utils/assets_utils.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/formart_utils.dart';

class PopularPlaceItem extends StatelessWidget {
  const PopularPlaceItem({super.key, required this.hotel});

  final HotelResponse hotel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.width * 0.32,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(DimensionUtils.BORDER_RADIUS_LARGE),
      ),
      padding: const EdgeInsets.all(DimensionUtils.PADDING_SIZE_SMALL),
      margin: const EdgeInsets.symmetric(
        horizontal: DimensionUtils.MARGIN_SIZE_LARGE,
        vertical: DimensionUtils.MARGIN_SIZE_DEFAULT,
      ),
      child: Row(
        children: [
          SizedBox(
            height: Get.width * 0.3 - DimensionUtils.PADDING_SIZE_SMALL * 2,
            width: Get.width * 0.3 - DimensionUtils.PADDING_SIZE_SMALL * 2,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 12,
                  left: 0,
                  bottom: 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      DimensionUtils.BORDER_RADIUS_EXTRA_LARGE_OVER,
                    ),
                    child: Hero(
                      tag: "${hotel.pathImage} popular",
                      child: Image.network(
                        hotel.pathImage ?? AssetsUtils.hotel,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        DimensionUtils.BORDER_RADIUS_DEFAULT,
                      ),
                    ),
                    color: ColorConstant.getPrimaryColor(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Color(0xFFf9f9fa),
                            size: DimensionUtils.FONT_SIZE_SMALL,
                          ),
                          const SizedBox(
                            width: DimensionUtils.SIZE_BOX_HEIGHT_EXTRA_SMALL,
                          ),
                          Text(
                            "${hotel.rating ?? 0.0}",
                            style: StyleUtils.styleDefault.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    hotel.nameHotel ?? "Name Hotel",
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    hotel.address ?? "Địa chỉ",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF657786).withOpacity(0.6),
                    ),
                  ),
                  Row(
                    children: [
                      const Text(""),
                      const Spacer(),
                      Text(
                        "${FormartUtils.formatDoubleToVND(hotel.rooms!.isNotEmpty ? hotel.rooms![0].price ?? 0 : 200000)} ",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1e98d0),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
