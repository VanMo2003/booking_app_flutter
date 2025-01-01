import 'dart:developer';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/models/response/hotel_response.dart';
import '../../../utils/assets_utils.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/formart_utils.dart';
import '../../../utils/language/key_language.dart';
import '../../../views/custom_snackbar.dart';
import 'order_now_screen.dart';
import 'select_room.dart';
import 'select_service.dart';

class HotelDetail extends StatefulWidget {
  HotelDetail({super.key, required this.hotel, this.isPopular = false});

  final HotelResponse hotel;
  final bool isPopular;

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  List<int> selectedRooms = [];
  List<int> selectedServices = [];
  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    return Scaffold(
      backgroundColor: ColorConstant.getBackgroundPrimary(),
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(
            minHeight: Get.height,
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
                        child: Image.network(
                          widget.isPopular
                              ? "${widget.hotel.pathImage} popular"
                              : widget.hotel.pathImage ?? AssetsUtils.hotel,
                          fit: BoxFit.cover,
                          height: Get.height * 0.43,
                          width: Get.width,
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
                              "${FormartUtils.formatDoubleToVND(widget.hotel.rooms!.isNotEmpty ? widget.hotel.rooms![0].price ?? 0 : 200000)} ",
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
                          widget.hotel.nameHotel ?? "Tên khách sạn",
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
                            widget.hotel.address ?? "Địa chỉ",
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
                        Text(
                          KeyLanguage.description.tr,
                          style: const TextStyle(
                            fontSize: DimensionUtils.FONT_SIZE_LARGE,
                            fontWeight: FontWeight.w700,
                            height: 2,
                          ),
                        ),
                        ExpandableText(
                          widget.hotel.description ?? KeyLanguage.orderNow.tr,
                          expandText: KeyLanguage.seeMore.tr,
                          collapseText: KeyLanguage.collapse.tr,
                          maxLines: 3,
                          linkColor: Colors.blue,
                        ),
                        const SizedBox(
                            height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                selectedRooms = await Get.to(
                                  SelectRoom(
                                    rooms: widget.hotel.rooms!,
                                    selectedRooms: selectedRooms,
                                  ),
                                );
                                setState(() {
                                  selectedRooms.sort();
                                  log("$selectedRooms");
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: ColorConstant.getPrimaryColor(),
                                  borderRadius: BorderRadius.circular(
                                    DimensionUtils.BORDER_RADIUS_DEFAULT,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Chọn phòng",
                                    style: GoogleFonts.roboto(
                                      color:
                                          ColorConstant.getTextPrimaryColor(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                selectedServices = await Get.to(
                                  SelectService(
                                    services: widget.hotel.services!,
                                    selectedServices: selectedServices,
                                  ),
                                );
                                setState(() {
                                  selectedServices.sort();
                                  log("$selectedRooms");
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: ColorConstant.getPrimaryColor(),
                                  borderRadius: BorderRadius.circular(
                                    DimensionUtils.BORDER_RADIUS_DEFAULT,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    "Thêm dịch vụ",
                                    style: GoogleFonts.roboto(
                                      color:
                                          ColorConstant.getTextPrimaryColor(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                            height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                        if (selectedRooms.isNotEmpty) ...[
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
                                if (selectedRooms
                                    .contains(widget.hotel.rooms![i].id)) ...[
                                  Text(
                                    " - ${widget.hotel.rooms![i].name!} (${FormartUtils.formatDoubleToVND(widget.hotel.rooms![i].price!)})",
                                    style: GoogleFonts.roboto(
                                      fontStyle: FontStyle.italic,
                                      fontSize:
                                          DimensionUtils.FONT_SIZE_DEFAULT,
                                    ),
                                  ),
                                ]
                              ],
                            ],
                          )
                        ],
                        const SizedBox(
                            height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT),
                        if (selectedServices.isNotEmpty) ...[
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
                                if (selectedServices.contains(
                                    widget.hotel.services![i].id)) ...[
                                  Text(
                                    " - ${widget.hotel.services![i].name!} (${FormartUtils.formatDoubleToVND(widget.hotel.services![i].price!)})",
                                    style: GoogleFonts.roboto(
                                      fontStyle: FontStyle.italic,
                                      fontSize:
                                          DimensionUtils.FONT_SIZE_DEFAULT,
                                    ),
                                  ),
                                ]
                              ],
                            ],
                          )
                        ]
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: DimensionUtils.PADDING_SIZE_EXTRA_LARGE,
                  vertical: DimensionUtils.PADDING_SIZE_EXTRA_LARGE,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (selectedRooms.isEmpty) {
                          showCustomSnackBar(
                            "Bạn chưa chọn phòng",
                            isWarning: true,
                          );
                        } else {
                          log("order : ${widget.hotel.id}");
                          Get.to(OrderNowScreen(
                            hotel: widget.hotel,
                            selectedRooms: selectedRooms,
                            selectedServices: selectedServices,
                          ));
                        }
                      },
                      child: Container(
                        width: Get.width * 0.7,
                        decoration: BoxDecoration(
                          color: const Color(0xff002140),
                          borderRadius: BorderRadius.circular(
                              DimensionUtils.BORDER_RADIUS_EXTRA_LARGE_OVER),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(
                                DimensionUtils.PADDING_SIZE_EXTRA_EXTRA_LARGE),
                            child: Text(
                              KeyLanguage.orderNow.tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: DimensionUtils.FONT_SIZE_LARGE,
                              ),
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
