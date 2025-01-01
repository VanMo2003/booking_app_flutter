import 'package:booking_app_demo/controller/loading_controller.dart';
import 'package:booking_app_demo/controller/user_controller.dart';
import 'package:booking_app_demo/data/models/body/user_update.dart';
import 'package:booking_app_demo/data/models/response/user_response.dart';
import 'package:booking_app_demo/screens/auth_screen/widgets/birth_place_dropdown.dart';
import 'package:booking_app_demo/utils/app_constant.dart';
import 'package:booking_app_demo/utils/color_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../helpers/valid_helper.dart';
import '../../../utils/date_convert.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/language/key_language.dart';

import '../../../utils/style.dart';
import '../../widgets/button_text_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/text_field_widget.dart';

class PersonUserScreen extends StatefulWidget {
  const PersonUserScreen({super.key});

  @override
  State<PersonUserScreen> createState() => _PersonUserScreenState();
}

class _PersonUserScreenState extends State<PersonUserScreen> {
  final TextEditingController fullNameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController birthPlaceController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  RxString dob = DateConvert.dateTimeToString(DateTime.now()).obs;
  DateTime dateSelect = DateTime.now();

  String selectedBirthPlace = "";

  final form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    UserResponse userResponse = Get.find<UserController>().user!;
    fullNameController.text = userResponse.fullName ?? "";
    phoneController.text = userResponse.phone ?? "";
    dob.value = DateConvert.reversedDateTimeString(userResponse.dateOfBirth ??
        DateConvert.dateTimeToString(DateTime.now()));
    birthPlaceController.text = userResponse.birthPlace ?? "";
    addressController.text = userResponse.address ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Thông tin cá nhân",
            style: GoogleFonts.roboto(
              fontSize: DimensionUtils.FONT_SIZE_TITLE_LARGE,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: ColorConstant.getWhiteColor(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: DimensionUtils.PADDING_SIZE_SMALL,
              ),
              child: Form(
                key: form,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_LARGE,
                    ),
                    TextFieldWidget(
                      controller: fullNameController,
                      labelText: KeyLanguage.fullname.tr,
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                    ),
                    TextFieldWidget(
                      controller: phoneController,
                      labelText: KeyLanguage.phone.tr,
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                    ),
                    Obx(() {
                      return TextFieldWidget(
                        controller: TextEditingController(text: dob.value),
                        labelText: KeyLanguage.dateOfBirth.tr,
                        readOnly: true,
                        isPasswordField: false,
                        validator: (value) {
                          return ValidationHelper.validDOB(value);
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            pickDOB();
                          },
                          icon: const Icon(Icons.calendar_month),
                        ),
                      );
                    }),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                    ),
                    BirthPlaceDropdown(
                      label: "Quê quán",
                      items: AppConstant.birthPlaces,
                      onValueChanged: (selected) {
                        setState(() {
                          selectedBirthPlace = selected;
                        });
                      },
                      selectedBirthPlace: birthPlaceController.text,
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                    ),
                    TextFieldWidget(
                      controller: addressController,
                      labelText: KeyLanguage.address.tr,
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                    ),
                    ButtonTextWidget(
                      label: KeyLanguage.update.tr,
                      onTap: () {
                        save();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  save() {
    String phoneNumber = phoneController.text;
    String fullname = fullNameController.text;
    String address = addressController.text;
    if (form.currentState!.validate()) {
      Get.find<LoadingController>().loading(
        handle: () {
          UserUpdate userNew = UserUpdate();
          userNew.setPhone = phoneNumber;
          userNew.setFullName = fullname;
          userNew.setAddress = address;
          userNew.setDateOfBirth = DateConvert.stringFormatToRequest(dob.value);
          userNew.setBirthPlace = selectedBirthPlace;
          userNew.setGender = Get.find<UserController>().user!.gender ?? "nam";
          Get.find<UserController>().updateMyInfo(userNew);
        },
      );
    }
  }

  Future<void> pickDOB() async {
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) {
        return SizedBox(
          height: Get.height * 0.4,
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    KeyLanguage.cancel.tr,
                    style: StyleUtils.styleDefault.copyWith(color: Colors.red),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 20,
                child: InkWell(
                  onTap: () {
                    dob.value = DateConvert.dateTimeToString(dateSelect);
                    debugPrint(dob.value);
                    Navigator.pop(context);
                  },
                  child: Text(
                    KeyLanguage.agree.tr,
                    style:
                        StyleUtils.styleDefault.copyWith(color: Colors.green),
                  ),
                ),
              ),
              CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: DateConvert.stringToDateTimeRequest(dob.value),
                onDateTimeChanged: (DateTime newDateTime) {
                  dateSelect = newDateTime;
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
