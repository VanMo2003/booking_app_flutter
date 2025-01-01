import 'package:booking_app_demo/data/models/response/room_response.dart';
import 'package:booking_app_demo/data/models/response/service_response.dart';

import '../../../data/models/response/hotel_response.dart';
import '../../auth_screen/widgets/birth_place_dropdown.dart';
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
    required this.rooms,
    required this.services,
  });

  final HotelResponse hotel;
  final List<RoomResponse> rooms;
  final List<ServiceResponse> services;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  RxDouble totalsMoney = RxDouble(0.0);
  double sum = 0.0;
  bool isPaymentNew = false;

  final TextEditingController _controller = TextEditingController();

  final form = GlobalKey<FormState>();

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
                    if (widget.rooms.isNotEmpty) ...[
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
                          for (int i = 0; i < widget.rooms.length; i++) ...[
                            Text(
                              " - ${widget.rooms[i].name!} (${FormartUtils.formatDoubleToVND(widget.rooms[i].price!)})",
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
                    if (widget.services.isNotEmpty) ...[
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
                          for (int i = 0; i < widget.services.length; i++) ...[
                            Text(
                              " ${widget.services[i].name!} (${FormartUtils.formatDoubleToVND(widget.services[i].price!)})",
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
