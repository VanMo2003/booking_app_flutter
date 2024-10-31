import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/language/key_language.dart';

enum Gender { male, female }

extension GenderX on Gender {
  String get gender {
    switch (this) {
      case Gender.male:
        return "Nam";
      case Gender.female:
        return "Nữ";
      default:
        return "Giới tính";
    }
  }
}

class RadioGender extends StatefulWidget {
  RadioGender({super.key, required this.onValueChanged});

  final Function(String) onValueChanged;

  @override
  State<RadioGender> createState() => _RadioGenderState();
}

class _RadioGenderState extends State<RadioGender> {
  Gender character = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        itemRadioGender(Gender.male, KeyLanguage.male.tr),
        itemRadioGender(Gender.female, KeyLanguage.female.tr),
      ],
    );
  }

  Widget itemRadioGender(Gender value, String label) {
    return Expanded(
      child: ListTile(
        title: Text(label),
        leading: Radio<Gender>(
          value: value,
          groupValue: character,
          onChanged: (Gender? value) {
            setState(() {
              character = value!;
            });

            widget.onValueChanged(character.gender);
          },
        ),
      ),
    );
  }
}
