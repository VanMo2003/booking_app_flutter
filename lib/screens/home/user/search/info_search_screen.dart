import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controller/loading_controller.dart';
import '../../../../helpers/valid_helper.dart';
import '../../../../utils/color_constant.dart';
import '../../../../utils/dimensions.dart';
import '../../../widgets/loading_widget.dart';
import 'result_search_screen.dart';
import 'widget/pick_calendar_dialog.dart';

class InfoSearchScreen extends StatefulWidget {
  const InfoSearchScreen({super.key});

  @override
  State<InfoSearchScreen> createState() => _InfoSearchScreenState();
}

class _InfoSearchScreenState extends State<InfoSearchScreen> {
  final form = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();

  bool _hasText = false;
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        _hasText = controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.getBackgroundPrimary(),
          title: Text(
            "Nhập tên hoặc địa chỉ ...",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
            ),
          ),
          centerTitle: true,
        ),
        backgroundColor: ColorConstant.getBackgroundPrimary(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: DimensionUtils.PADDING_SIZE_EXTRA_LARGE),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: form,
                  child: TextFormField(
                    controller: controller,
                    autofocus: true,
                    cursorColor: ColorConstant.getPrimaryColor(),
                    cursorHeight: 30,
                    style: GoogleFonts.roboto(
                      fontSize: DimensionUtils.FONT_SIZE_OVER_LARGE,
                    ),
                    validator: (value) {
                      return ValidationHelper.validNull(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      suffixIcon: _hasText
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              color: Colors.grey,
                              onPressed: () {
                                controller.clear();
                                setState(() {
                                  _hasText = false;
                                });
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(
                    height: DimensionUtils.SIZE_BOX_HEIGHT_EXTRA_LARGE),
                GestureDetector(
                  onTap: () {
                    if (form.currentState!.validate()) {
                      Get.find<LoadingController>().loading(
                        handle: () {
                          Get.to(
                              ResultSearchScreen(searchText: controller.text));
                        },
                      );
                    }
                  },
                  child: Container(
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                      color: const Color(0xff002140),
                      borderRadius: BorderRadius.circular(
                        DimensionUtils.BORDER_RADIUS_EXTRA_LARGE,
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "Tìm kiếm",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: DimensionUtils.FONT_SIZE_LARGE,
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

  void pickCalendar() {
    showDialog(
      context: context,
      builder: (context) {
        return const PickCalendarDialog();
      },
    );
  }
}
