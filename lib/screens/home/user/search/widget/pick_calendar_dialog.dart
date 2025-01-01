import 'package:get/get.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../../../../../controller/calendar_controller.dart';

class PickCalendarDialog extends StatefulWidget {
  const PickCalendarDialog({super.key});

  @override
  State<PickCalendarDialog> createState() => _PickCalendarDialogState();
}

class _PickCalendarDialogState extends State<PickCalendarDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: _buildCalendarWithActionButtons(),
    );
  }

  Widget _buildCalendarWithActionButtons() {
    final config = CalendarDatePicker2WithActionButtonsConfig(
      calendarType: CalendarDatePicker2Type.range,
      disableModePicker: true,
      rangeBidirectional: true,
      selectableDayPredicate: (day) {
        // Chỉ cho phép chọn các ngày từ hôm nay trở đi
        return day.isAfter(DateTime.now().subtract(const Duration(days: 0)));
      },
    );
    return SizedBox(
      width: 375,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          GetBuilder<CalendarController>(
            builder: (calendarController) {
              return CalendarDatePicker2WithActionButtons(
                config: config,
                value: calendarController.values,
                onCancelTapped: () {
                  Navigator.of(context).pop();
                },
                onValueChanged: (dates) => setState(() {
                  calendarController.changeDateTime(dates);
                  Duration difference = dates[0]!.difference(dates[1]!);

                  Get.back(result: difference.inDays.abs());
                }),
              );
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
