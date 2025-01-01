import 'package:booking_app_demo/controller/statistical_controller.dart';
import 'package:booking_app_demo/screens/auth_screen/widgets/birth_place_dropdown.dart';
import 'package:booking_app_demo/screens/widgets/button_text_widget.dart';
import 'package:booking_app_demo/utils/color_constant.dart';
import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../utils/dimensions.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({super.key});

  @override
  State<RevenueScreen> createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  List<OrdinalData> data = [];
  List<OrdinalData> data1 = [];

  String seleted = "";

  @override
  void initState() {
    super.initState();
    if (Get.find<StatisticalController>().statistical != null) {
      Get.find<StatisticalController>()
          .statistical!
          .where(
            (element) => element.revenueMonth!.split("-")[0] == "2024",
          )
          .forEach(
        (element) {
          data.add(OrdinalData(
              domain: element.revenueMonth!.split("-")[1],
              measure: element.totalRevenue ?? 0));
        },
      );

      Get.find<StatisticalController>()
          .statistical!
          .where(
            (element) => element.revenueMonth!.split("-")[0] == "2025",
          )
          .forEach(
        (element) {
          data1.add(OrdinalData(
              domain: element.revenueMonth!.split("-")[1],
              measure: element.totalRevenue ?? 0));
        },
      );
    } else {
      for (var i = 1; i <= 12; i++) {
        data.add(OrdinalData(domain: "Tháng $i", measure: 10));
        data1.add(OrdinalData(domain: "Tháng $i", measure: 10));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              vertical: DimensionUtils.PADDING_SIZE_DEFAULT,
              horizontal: DimensionUtils.PADDING_SIZE_DEFAULT),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: Get.width * 0.7,
                    child: BirthPlaceDropdown(
                      label: "Cập nhật doanh thu",
                      items: const [
                        "Tháng hiện tại",
                        "Tháng 1-2024",
                        "Tháng 2-2024",
                        "Tháng 3-2024",
                        "Tháng 4-2024",
                        "Tháng 5-2024",
                        "Tháng 6-2024",
                        "Tháng 7-2024",
                        "Tháng 8-2024",
                        "Tháng 9-2024",
                        "Tháng 10-2024",
                        "Tháng 11-2024",
                        "Tháng 12-2024",
                        "Tháng 01-2025",
                      ],
                      onValueChanged: (seleted) {},
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: DimensionUtils.PADDING_SIZE_SMALL),
                    child: ButtonTextWidget(
                      label: 'Cập nhật',
                      onTap: () {},
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT,
              ),
              GetBuilder<StatisticalController>(
                builder: (controller) {
                  return AspectRatio(
                    aspectRatio: 12 / data.length,
                    child: DChartBarO(
                      vertical: false,
                      layoutMargin: LayoutMargin(50, 20, 30, 20),
                      configRenderBar: const ConfigRenderBar(
                        barGroupInnerPaddingPx: 0,
                        radius: 20,
                      ),
                      domainAxis: const DomainAxis(
                        showLine: true,
                        tickLength: 0,
                        gapAxisToLabel: 12,
                      ),
                      measureAxis: MeasureAxis(
                        showLine: true,
                        tickLength: 0,
                        tickLabelFormatter: (measure) {
                          return NumberFormat.compactCurrency(
                            symbol: '',
                            decimalDigits: 0,
                          ).format(measure);
                        },
                      ),
                      groupList: [
                        OrdinalGroup(
                          useSecondaryMeasureAxis: true,
                          id: '1',
                          data: data,
                          color: ColorConstant.getPrimaryColor(),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Center(
                child: Text(
                  "Doanh thu theo tháng (2024)",
                  style: GoogleFonts.roboto(
                    fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT,
              ),
              GetBuilder<StatisticalController>(
                builder: (controller) {
                  return AspectRatio(
                    aspectRatio: 12 / data1.length,
                    child: DChartBarO(
                      vertical: false,
                      layoutMargin: LayoutMargin(50, 20, 30, 20),
                      configRenderBar: const ConfigRenderBar(
                        barGroupInnerPaddingPx: 0,
                        radius: 20,
                      ),
                      domainAxis: const DomainAxis(
                        showLine: true,
                        tickLength: 0,
                        gapAxisToLabel: 12,
                      ),
                      measureAxis: MeasureAxis(
                        showLine: true,
                        tickLength: 0,
                        tickLabelFormatter: (measure) {
                          return NumberFormat.compactCurrency(
                            symbol: '',
                            decimalDigits: 0,
                          ).format(measure);
                        },
                      ),
                      groupList: [
                        OrdinalGroup(
                          useSecondaryMeasureAxis: true,
                          id: '1',
                          data: data1,
                          color: ColorConstant.getPrimaryColor(),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Center(
                child: Text(
                  "Doanh thu theo tháng (2025)",
                  style: GoogleFonts.roboto(
                    fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
