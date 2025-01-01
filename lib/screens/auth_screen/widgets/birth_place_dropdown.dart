import 'package:flutter/material.dart';
import '../../../utils/color_constant.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:get/get.dart';

import '../../../utils/dimensions.dart';

class BirthPlaceDropdown extends StatefulWidget {
  BirthPlaceDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.onValueChanged,
  });
  final String label;
  final List<String> items;
  final Function(String) onValueChanged;

  @override
  State<BirthPlaceDropdown> createState() => _BirthPlaceDropdownState();
}

class _BirthPlaceDropdownState extends State<BirthPlaceDropdown> {
  late String selected;

  @override
  void initState() {
    super.initState();
    selected = widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    var padding = MediaQuery.of(context).padding;
    return Container(
      height: 60,
      margin: const EdgeInsets.only(top: DimensionUtils.PADDING_SIZE_SMALL),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: ColorConstant.getBlackColor().withOpacity(0.5),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Padding(
            padding: const EdgeInsets.only(
              left: DimensionUtils.PADDING_SIZE_DEFAULT,
              right: DimensionUtils.PADDING_SIZE_DEFAULT,
            ),
            child: Text(
              widget.label,
              style: TextStyle(
                fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                fontWeight: FontWeight.bold,
                color: ColorConstant.getGreyColor(),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          items: widget.items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: DimensionUtils.PADDING_SIZE_DEFAULT,
                        right: DimensionUtils.PADDING_SIZE_DEFAULT,
                      ),
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: DimensionUtils.FONT_SIZE_DEFAULT,
                          color: Theme.of(context).canvasColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ))
              .toList(),
          value: selected,
          onChanged: (newValue) {
            setState(() {
              selected = newValue!;
            });

            widget.onValueChanged(newValue!);
          },
          iconStyleData: IconStyleData(
            iconSize: DimensionUtils.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER,
            iconEnabledColor: ColorConstant.getBlackColor(),
            iconDisabledColor: ColorConstant.getGreyColor(),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: Get.width - DimensionUtils.PADDING_SIZE_DEFAULT,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorConstant.getWhiteColor(),
            ),
            offset: const Offset(0, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all(6),
              thumbVisibility: WidgetStateProperty.all(true),
            ),
          ),
        ),
      ),
    );
  }
}
