import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/booking_controller.dart';
import '../../../data/models/response/booking_response.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/language/key_language.dart';
import '../user/order_user_item.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<BookingResponse>? bookings;
  @override
  void initState() {
    super.initState();
    if (Get.find<BookingController>().bookings == null) {
      Get.find<BookingController>().getBookingMyself().then(
        (value) {
          if (value == 200) {
            Future.delayed(
              Durations.extralong4,
              () {
                getData();
              },
            );
          }
        },
      );
    } else {
      getData();
    }
  }

  getData() {
    bookings = Get.find<BookingController>().bookings;
    Get.find<BookingController>().sortOrderOfHotel();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookingController>(
      builder: (controller) {
        if (bookings == null) {
          return Center(
              child: CircularProgressIndicator(
            color: ColorConstant.getLoadingColor(),
          ));
        }

        if (bookings!.isEmpty) {
          log("List Empty");
          return Center(
            child: Text(
              KeyLanguage.listEmpty.tr,
            ),
          );
        }

        return ListView.builder(
          itemCount: bookings!.length,
          itemBuilder: (context, index) {
            return OrderItem(
              booking: bookings![index],
              isHotelier: true,
            );
          },
        );
      },
    );
  }
}
