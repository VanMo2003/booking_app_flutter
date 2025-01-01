import 'dart:developer';

import '../../../controller/loading_controller.dart';
import '../../../controller/booking_controller.dart';
import '../../../controller/payment_controller.dart';
import '../../../data/models/body/order.dart';
import '../../../data/models/response/hotel_response.dart';
import '../../auth_screen/widgets/birth_place_dropdown.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/language/key_language.dart';
import '../../../utils/style.dart';
import '../../../views/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/calendar_controller.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/date_convert.dart';
import '../../../utils/formart_utils.dart';
import '../../payment/vnpay_payment_screen.dart';
import 'search/widget/pick_calendar_button.dart';
import 'search/widget/pick_calendar_dialog.dart';

class OrderNowScreen extends StatefulWidget {
  const OrderNowScreen({
    super.key,
    required this.hotel,
    required this.selectedRooms,
    required this.selectedServices,
  });

  final HotelResponse hotel;
  final List<int> selectedRooms;
  final List<int> selectedServices;

  @override
  State<OrderNowScreen> createState() => _OrderNowScreenState();
}

class _OrderNowScreenState extends State<OrderNowScreen> {
  RxDouble totalsMoney = RxDouble(0.0);
  double sum = 0.0;
  bool isPaymentNew = false;

  final TextEditingController _controller = TextEditingController();

  final form = GlobalKey<FormState>();
  int difference = 1;

  @override
  void initState() {
    super.initState();

    for (var room in widget.hotel.rooms!) {
      if (widget.selectedRooms.contains(room.id)) {
        sum += room.price ?? 0.0;
      }
    }
    if (widget.selectedServices.isNotEmpty) {
      for (var service in widget.hotel.services!) {
        if (widget.selectedRooms.contains(service.id)) {
          sum += service.price ?? 0.0;
        }
      }
    }

    totalsMoney.value = sum;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.getWhiteColor(),
          title: const Text("Thông tin đơn hàng"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: Get.height * 0.9,
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: DimensionUtils.PADDING_SIZE_DEFAULT,
                vertical: DimensionUtils.PADDING_SIZE_EXTRA_EXTRA_LARGE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    richText(
                      label: KeyLanguage.nameHotel.tr,
                      content: widget.hotel.nameHotel,
                    ),
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    richText(
                      label: KeyLanguage.address.tr,
                      content: widget.hotel.address,
                    ),
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    GetBuilder<CalendarController>(
                      builder: (calendarController) {
                        return Row(
                          children: [
                            PickCalendarButton(
                              label: DateConvert.reversedDateTimeString(
                                calendarController
                                    .getValueText()
                                    .split("to")[0]
                                    .trim(),
                              ),
                              onTap: () {
                                pickCalendar();
                              },
                            ),
                            const SizedBox(
                                width: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
                            PickCalendarButton(
                              label: DateConvert.reversedDateTimeString(
                                calendarController
                                    .getValueText()
                                    .split("to")[1]
                                    .trim(),
                              ),
                              onTap: () {
                                pickCalendar();
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    BirthPlaceDropdown(
                      label: "Phương thức thanh toán",
                      items: const [
                        "Thanh toán khi trả phòng",
                        "Thanh toán qua vnpay",
                      ],
                      onValueChanged: (newValue) {
                        isPaymentNew = newValue == "Thanh toán qua vnpay";
                        log("$isPaymentNew :  $newValue");
                      },
                    ),
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    Text(
                      "Chú thích : ",
                      style: StyleUtils.titleItem.copyWith(
                        fontSize: DimensionUtils.FONT_SIZE_LARGE,
                      ),
                    ),
                    TextFieldWidget(
                      controller: _controller,
                      onChanged: (newValue) {},
                    ),
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    if (widget.selectedRooms.isNotEmpty) ...[
                      Text(
                        "Phòng đã chọn : ",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < widget.hotel.rooms!.length;
                              i++) ...[
                            if (widget.selectedRooms
                                .contains(widget.hotel.rooms![i].id)) ...[
                              Text(
                                " - ${widget.hotel.rooms![i].name!} (${FormartUtils.formatDoubleToVND(widget.hotel.rooms![i].price!)})",
                                style: GoogleFonts.roboto(
                                  fontStyle: FontStyle.italic,
                                  fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                                ),
                              ),
                            ]
                          ],
                        ],
                      )
                    ],
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    if (widget.selectedServices.isNotEmpty) ...[
                      Text(
                        "Dịch vụ : ",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < widget.hotel.services!.length;
                              i++) ...[
                            if (widget.selectedServices
                                .contains(widget.hotel.services![i].id)) ...[
                              Text(
                                " ${widget.hotel.services![i].name!} (${FormartUtils.formatDoubleToVND(widget.hotel.services![i].price!)})",
                                style: GoogleFonts.roboto(
                                  fontStyle: FontStyle.italic,
                                  fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                                ),
                              ),
                            ]
                          ],
                        ],
                      )
                    ],
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    Obx(
                      () => richText(
                        label: "Tổng tiền",
                        content:
                            "$sum * $difference(ngày) = ${totalsMoney.value}",
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                GestureDetector(
                  onTap: () {
                    createOrder();
                  },
                  child: Container(
                    width: Get.width * 0.5,
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
                          "Hoàn tất thanh toán",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickCalendar() async {
    difference = await showDialog(
      context: context,
      builder: (context) {
        return const PickCalendarDialog();
      },
    );

    totalsMoney.value = sum * difference;
  }

  Widget richText({required String? label, required String? content}) {
    return RichText(
      text: TextSpan(
        style: StyleUtils.titleItem.copyWith(
          fontSize: DimensionUtils.FONT_SIZE_EXTRA_LARGE,
        ),
        children: [
          TextSpan(
            text: label,
            style: GoogleFonts.roboto(
              fontSize: DimensionUtils.FONT_SIZE_LARGE,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline,
            ),
          ),
          TextSpan(
            text: ": $content",
          ),
        ],
      ),
    );
  }

  void createOrder() {
    String startDate =
        Get.find<CalendarController>().getValueText().split(" to ")[0];
    String endDate =
        Get.find<CalendarController>().getValueText().split(" to ")[1];
    Get.find<LoadingController>().loading(
      handle: () {
        Order order = Order(
          arrivalDate: startDate,
          departureDate: endDate,
          paymentMethod: isPaymentNew ? "PAY_NOW" : "DIRECT_PAYMENT",
          rooms: widget.selectedRooms,
          price: totalsMoney.value,
          services: widget.selectedServices,
          note: _controller.text,
          hotelId: widget.hotel.id,
        );

        Get.find<BookingController>().createOrder(order).then(
          (value) {
            if (value == 200) {
              if (isPaymentNew) {
                Get.find<PaymentController>().createPayment(237008).then(
                  (value) async {
                    if (value != null) {
                      try {
                        await Get.to(VNPayPaymentScreen(paymentUrl: value));
                      } catch (e) {
                        log("Error: $e");
                      }
                    }
                  },
                );
              } else {
                Get.back();
                showCustomSnackBar("Đặt phòng thành công");
              }
            } else if (value == 404) {
              showCustomSnackBar("Hết phòng vào thời gian đó", isWarning: true);
            }
          },
        );
      },
    );
  }
}
