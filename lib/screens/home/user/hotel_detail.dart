import 'package:demo_booking_app/data/models/response/hotel_response.dart';
import 'package:demo_booking_app/utils/assets_utils.dart';
import 'package:demo_booking_app/utils/color_constant.dart';
import 'package:demo_booking_app/utils/dimensions.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/formart_utils.dart';

class HotelDetail extends StatelessWidget {
  const HotelDetail({super.key, required this.hotel, this.isPopular = false});

  final HotelResponse hotel;
  final bool isPopular;

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: ColorConstant.getBackgroundPrimary(),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: Get.height, // Chiều cao tối thiểu
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            DimensionUtils.BORDER_RADIUS_OVER_LARGE),
                        child: Hero(
                          tag: hotel.pathImage ?? AssetsUtils.hotel,
                          child: Image.network(
                            isPopular
                                ? "${hotel.pathImage} popular"
                                : hotel.pathImage ?? AssetsUtils.hotel,
                            fit: BoxFit.cover,
                            height: Get.height * 0.43,
                            width: Get.width,
                          ),
                        ),
                      ),
                      // for back button
                      Positioned(
                        top: padding.top,
                        right: DimensionUtils.PADDING_SIZE_EXTRA_LARGE,
                        left: DimensionUtils.PADDING_SIZE_EXTRA_LARGE,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: Get.width * 0.12,
                              width: Get.width * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(
                                    DimensionUtils.BORDER_RADIUS_EXTRA_LARGE),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              height: Get.width * 0.12,
                              width: Get.width * 0.12,
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(
                                    DimensionUtils.BORDER_RADIUS_EXTRA_LARGE),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: DimensionUtils.ICON_SIZE_DEFAULT,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      // for price
                      Positioned(
                        bottom: -Get.height * 0.04,
                        left: DimensionUtils.PADDING_SIZE_EXTRA_LARGE,
                        child: Container(
                          height: Get.height * 0.08,
                          width: Get.width * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                DimensionUtils.BORDER_RADIUS_EXTRA_LARGE_OVER),
                          ),
                          child: Center(
                            child: Text(
                              "${FormartUtils.formatDoubleToVND(hotel.price ?? 0)} ",
                              style: const TextStyle(
                                color: Color(0xFF1DA1F2),
                                fontWeight: FontWeight.bold,
                                fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // for bookmark icon
                    ],
                  ),
                  SizedBox(height: Get.height * 0.03),
                  Padding(
                    padding: const EdgeInsets.all(
                        DimensionUtils.PADDING_SIZE_EXTRA_LARGE),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hotel.nameHotel ?? "Tên khách sạn",
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: DimensionUtils.FONT_SIZE_EXTRA_OVER_LARGE,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(
                            height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: DimensionUtils.PADDING_SIZE_EXTRA_LARGE),
                          child: Text(
                            hotel.address ?? "Địa chỉ",
                            maxLines: 2,
                            style: TextStyle(
                              height: 1.2,
                              color: Color(0xFF657786).withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                        const Text(
                          "Mô tả",
                          style: TextStyle(
                            fontSize: DimensionUtils.FONT_SIZE_LARGE,
                            fontWeight: FontWeight.w700,
                            height: 2,
                          ),
                        ),
                        ExpandableText(
                          hotel.description ?? "Mô tả chi tiết",
                          expandText: 'Xem thêm',
                          collapseText: 'Thu gọn',
                          maxLines: 3,
                          linkColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: DimensionUtils.PADDING_SIZE_EXTRA_LARGE,
                    vertical: DimensionUtils.PADDING_SIZE_EXTRA_LARGE),
                child: Row(
                  children: [
                    Container(
                      width: Get.width * 0.7,
                      decoration: BoxDecoration(
                        color: const Color(0xff002140),
                        borderRadius: BorderRadius.circular(
                            DimensionUtils.BORDER_RADIUS_EXTRA_LARGE_OVER),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(
                              DimensionUtils.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                          child: Text(
                            "Đặt phòng ngay",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: DimensionUtils.FONT_SIZE_LARGE,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: Get.width * 0.15,
                      height: Get.width * 0.15,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.red.withOpacity(0.8),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            )
                          ]),
                      child: const Icon(
                        Icons.bookmark,
                        color: Color(0xFFf9f9fa),
                        size: DimensionUtils.ICON_SIZE_DEFAULT,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
