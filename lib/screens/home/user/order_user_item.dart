import 'dart:developer';

import 'package:booking_app_demo/data/models/response/hotel_response.dart';
import 'package:booking_app_demo/screens/home/user/order_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/booking_controller.dart';
import '../../../data/models/response/booking_response.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/style.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.booking, this.isHotelier = false});

  final BookingResponse booking;
  final bool isHotelier;

  @override
  Widget build(BuildContext context) {
    HotelResponse hotel = booking.bookedRoom!.hotel!;

    return GestureDetector(
      onTap: () {
        Get.to(OrderDetailScreen(
          hotel: hotel,
          booking: booking,
          isHotelier: isHotelier,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: DimensionUtils.PADDING_SIZE_DEFAULT,
          vertical: DimensionUtils.PADDING_SIZE_DEFAULT,
        ),
        child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: DimensionUtils.PADDING_SIZE_DEFAULT,
              vertical: DimensionUtils.PADDING_SIZE_DEFAULT,
            ),
            height: Get.height * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(DimensionUtils.BORDER_RADIUS_LARGE),
            ),
            child: Row(
              children: [
                Container(
                  height: Get.height * 0.15 -
                      DimensionUtils.PADDING_SIZE_DEFAULT * 2,
                  width: Get.height * 0.15 -
                      DimensionUtils.PADDING_SIZE_DEFAULT * 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          DimensionUtils.BORDER_RADIUS_DEFAULT),
                      image: DecorationImage(
                          image: NetworkImage(hotel.pathImage ?? ""))),
                ),
                const SizedBox(width: DimensionUtils.PADDING_SIZE_SMALL),
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Tên khách sạn:  ${hotel.nameHotel} ",
                            maxLines: 2,
                            style: StyleUtils.addressItem.copyWith(
                              fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                              color: ColorConstant.getTextPrimaryColor(),
                            ),
                          ),
                          Text(
                            "ngày đến : ${booking.bookedRoom!.arrivalDate}   ",
                            maxLines: 2,
                            style: StyleUtils.addressItem.copyWith(
                              fontSize: DimensionUtils.FONT_SIZE_EXTRA_SMALL,
                            ),
                          ),
                          Text(
                            "ngày đi : ${booking.bookedRoom!.departureDate}  ",
                            maxLines: 2,
                            style: StyleUtils.addressItem.copyWith(
                              fontSize: DimensionUtils.FONT_SIZE_EXTRA_SMALL,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: isHotelier && booking.statusOrder == "PENDING"
                            ? Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      log("Hủy");
                                      Get.find<BookingController>()
                                          .cancelOrder(booking.id ?? 0);
                                    },
                                    child: Text(
                                      "Hủy",
                                      style: GoogleFonts.roboto(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  GestureDetector(
                                    onTap: () {
                                      log("Xác nhận");
                                      Get.find<BookingController>()
                                          .confirmOrder(booking.id ?? 0);
                                    },
                                    child: Text(
                                      "Xác nhận",
                                      style: GoogleFonts.roboto(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                booking.statusOrder ?? "Trạng thái",
                                style: GoogleFonts.roboto(
                                    color: getColor(booking.statusOrder!)),
                              ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Color getColor(String status) {
    switch (status) {
      case "PENDING":
        return Colors.amber;
      case "CANCELED":
        return Colors.red;
      case "CONFIRMED":
        return Colors.blue;
      default:
        return Colors.green;
    }
  }
}
