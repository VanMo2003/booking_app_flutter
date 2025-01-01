import 'package:booking_app_demo/data/models/response/booking_response.dart';

import '../../../data/models/response/hotel_response.dart';
import '../../widgets/loading_widget.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/language/key_language.dart';
import '../../../utils/style.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/calendar_controller.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/date_convert.dart';
import '../../../utils/formart_utils.dart';
import 'search/widget/pick_calendar_button.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({
    super.key,
    required this.hotel,
    required this.booking,
    this.isHotelier = false,
  });

  final HotelResponse hotel;
  final BookingResponse booking;
  final bool isHotelier;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  RxDouble totalsMoney = RxDouble(0.0);
  double sum = 0.0;
  bool isPaymentNew = false;

  final form = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    if (widget.booking.price != null) {
      totalsMoney.value = widget.booking.price ?? 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.getWhiteColor(),
          title: Text("Thông tin đơn hàng"),
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
                    if (widget.isHotelier) ...[
                      richText(
                        label: KeyLanguage.phone.tr,
                        content: widget.booking.user!.phone,
                      ),
                      const SizedBox(
                          height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    ],
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
                              onTap: () {},
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
                              onTap: () {},
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    if (widget.booking.bookedRoom!.rooms!.isNotEmpty) ...[
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
                              i < widget.booking.bookedRoom!.rooms!.length;
                              i++) ...[
                            Text(
                              " - ${widget.booking.bookedRoom!.rooms![i].name!} (${FormartUtils.formatDoubleToVND(widget.booking.bookedRoom!.rooms![i].price!)})",
                              style: GoogleFonts.roboto(
                                fontStyle: FontStyle.italic,
                                fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                              ),
                            ),
                          ],
                        ],
                      )
                    ],
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    if (widget.booking.bookedRoom!.services!.isNotEmpty) ...[
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
                              i < widget.booking.bookedRoom!.services!.length;
                              i++) ...[
                            Text(
                              " ${widget.booking.bookedRoom!.services![i].name!} (${FormartUtils.formatDoubleToVND(widget.booking.bookedRoom!.services![i].price!)})",
                              style: GoogleFonts.roboto(
                                fontStyle: FontStyle.italic,
                                fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                              ),
                            ),
                          ],
                        ],
                      )
                    ],
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                    richText(
                      label: "Tổng tiền",
                      content: "${totalsMoney.value}",
                    ),
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                  ],
                ),
                const SizedBox(height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
              ],
            ),
          ),
        ),
      ),
    );
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
}
