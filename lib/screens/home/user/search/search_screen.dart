import 'dart:developer';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_constant.dart';
import '../../../../utils/dimensions.dart';
import 'widget/app_bar_search.dart';
import 'widget/pick_calendar_button.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<DateTime?> _rangeDatePickerValueWithDefaultValue = [
    DateTime(1999, 5, 6),
    DateTime(1999, 5, 21),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.getBackgroundPrimary(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Get.height * 0.125),
        child: const SafeArea(
          child: AppBarSearch(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: DimensionUtils.PADDING_SIZE_EXTRA_LARGE),
        child: Column(
          children: [
            Row(
              children: [
                PickCalendarButton(
                  label: "02-11-2024",
                  onTap: () {
                    log("pick calendar");
                    _buildRangeDatePickerWithValue();
                  },
                ),
                const SizedBox(width: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
                PickCalendarButton(
                  label: "03-11-2024",
                  onTap: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRangeDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      centerAlignModePicker: true,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.teal[800],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dynamicCalendarRows: true,
      modePickerBuilder: ({required monthDate, isMonthPicker}) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: isMonthPicker == true ? Colors.red : Colors.teal[800],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              isMonthPicker == true
                  ? getLocaleShortMonthFormat(const Locale('en'))
                      .format(monthDate)
                  : monthDate.year.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
      weekdayLabelBuilder: ({required weekday, isScrollViewTopHeader}) {
        if (weekday == DateTime.wednesday) {
          return const Center(
            child: Text(
              'W',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return null;
      },
      disabledDayTextStyle:
          const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
      selectableDayPredicate: (day) {
        if (_rangeDatePickerValueWithDefaultValue.isEmpty ||
            _rangeDatePickerValueWithDefaultValue.length == 2) {
          // exclude Wednesday
          return day.weekday != DateTime.wednesday;
        } else {
          // Make sure range does not contain any Wednesday
          final firstDate = _rangeDatePickerValueWithDefaultValue.first;
          final range = [firstDate!, day]..sort();
          for (var date = range.first;
              date.compareTo(range.last) <= 0;
              date = date.add(const Duration(days: 1))) {
            if (date.weekday == DateTime.wednesday) {
              return false;
            }
          }
        }
        return true;
      },
    );
    return SizedBox(
      width: 375,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text('Range Date Picker'),
          CalendarDatePicker2(
            config: config,
            value: _rangeDatePickerValueWithDefaultValue,
            onValueChanged: (dates) =>
                setState(() => _rangeDatePickerValueWithDefaultValue = dates),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Selection(s):  '),
              const SizedBox(width: 10),
              Text(
                _getValueText(
                  config.calendarType,
                  _rangeDatePickerValueWithDefaultValue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }
}
