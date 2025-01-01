import 'dart:developer';

import '../../../controller/booking_controller.dart';
import '../../../data/models/response/booking_response.dart';
import 'order_user_item.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/language/key_language.dart';
import '../../../utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderUserScreen extends StatefulWidget {
  const OrderUserScreen({super.key});

  @override
  State<OrderUserScreen> createState() => _OrderUserScreenState();
}

class _OrderUserScreenState extends State<OrderUserScreen> {
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
    Get.find<BookingController>().update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.getBackgroundPrimary(),
      appBar: AppBar(
        backgroundColor: ColorConstant.getBackgroundPrimary(),
        title: Text(
          "${KeyLanguage.order.tr} của tôi",
          style: StyleUtils.titleLarge,
        ),
        centerTitle: true,
      ),
      body: GetBuilder<BookingController>(
        builder: (controller) {
          if (bookings == null) {
            return const Center(child: CircularProgressIndicator());
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
              );
            },
          );
        },
      ),
    );
  }
}
