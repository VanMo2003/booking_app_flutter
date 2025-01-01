import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controller/langue_controller.dart';
import '../../../../services/language_service.dart';
import '../../../../utils/dimensions.dart';

class DropdownLangueWidget extends StatefulWidget {
  const DropdownLangueWidget({super.key});

  @override
  State<DropdownLangueWidget> createState() => _DropdownLangueWidgetState();
}

class _DropdownLangueWidgetState extends State<DropdownLangueWidget> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = Get.find<LanguageController>().getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 70,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius:
            BorderRadius.circular(DimensionUtils.BORDER_RADIUS_DEFAULT),
      ),
      child: Center(
        child: DropdownButton(
          value: selectedValue,
          borderRadius:
              BorderRadius.circular(DimensionUtils.BORDER_RADIUS_DEFAULT),
          onChanged: (value) {
            setState(() {
              selectedValue = value;
              Get.find<LanguageController>()
                  .changeLocale(selectedValue ?? "vi");
            });
          },
          alignment: Alignment.center,
          items: LanguageService.langCodes.map(
            (e) {
              return DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: GoogleFonts.roboto(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ).toList(),
          icon: Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
          ),
          underline: const SizedBox(),
        ),
      ),
    );
  }
}
