import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

class CalendarDialog {
  List<DateTime?> dialogCalendarPickerValue = [
    DateTime.now(),
  ];

  CalendarDialog(this.context);

  BuildContext context;

  config() {
    return CalendarDatePicker2WithActionButtonsConfig(
        calendarViewScrollPhysics: const NeverScrollableScrollPhysics(),
        dayTextStyle: TextStyle(
          color: Theme.of(context).disabledColor,
          fontWeight: FontWeight.w700,
        ),
        calendarType: CalendarDatePicker2Type.single,
        selectedDayHighlightColor: Theme.of(context).primaryColor,
        firstDayOfWeek: 1,
        weekdayLabelTextStyle: TextStyle(
          color: Theme.of(context).disabledColor,
          fontWeight: FontWeight.bold,
        ),
        controlsTextStyle: TextStyle(
          color: Theme.of(context).disabledColor,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        centerAlignModePicker: true,
        customModePickerIcon: const SizedBox(),
        selectedDayTextStyle: TextStyle(
          color: Theme.of(context).cardColor,
          fontWeight: FontWeight.w700,
        ),
        dayTextStylePredicate: ({required date}) {
          TextStyle? textStyle;
          if (date.weekday == DateTime.saturday ||
              date.weekday == DateTime.sunday) {
            textStyle =
                TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
          }
          if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
            textStyle = TextStyle(
              color: Colors.red[400],
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.underline,
            );
          }
          return textStyle;
        },
        dayBuilder: ({
          required date,
          textStyle,
          decoration,
          isSelected,
          isDisabled,
          isToday,
        }) {
          Widget? dayWidget;
          if (date.day % 3 == 0 && date.day % 9 != 0) {
            dayWidget = Container(
              decoration: decoration,
              child: Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Text(
                      MaterialLocalizations.of(context).formatDecimal(date.day),
                      style: textStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 27.5),
                      child: Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: isSelected == true
                              ? Theme.of(context).cardColor
                              : Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return dayWidget;
        },
        yearBuilder: ({
          required year,
          decoration,
          isCurrentYear,
          isDisabled,
          isSelected,
          textStyle,
        }) {
          return Center(
            child: Container(
              decoration: decoration,
              height: 36,
              width: 72,
              child: Center(
                child: Semantics(
                  selected: isSelected,
                  button: true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        year.toString(),
                        style: textStyle,
                      ),
                      if (isCurrentYear == true)
                        Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(left: 5),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.redAccent,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static String getValueText(
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
