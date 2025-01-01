import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/service_controller.dart';
import '../../../data/models/body/service.dart';
import '../../../data/models/response/service_response.dart';
import '../../../helpers/valid_helper.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/language/key_language.dart';
import '../../../views/custom_snackbar.dart';
import '../../widgets/text_field_widget.dart';
import 'widgets/button_dialog.dart';

class ServiceSceen extends StatefulWidget {
  const ServiceSceen({super.key});

  @override
  State<ServiceSceen> createState() => _ServiceSceenState();
}

class _ServiceSceenState extends State<ServiceSceen> {
  List<ServiceResponse>? services;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Get.find<ServiceController>().service == null) {
      Get.find<ServiceController>().getAllServiceByHotel().then(
        (value) {
          if (value == 200) {
            Future.delayed(
              Durations.extralong4,
              () {
                getData();
              },
            );
          }
        },
      );
    } else {
      getData();
    }
  }

  getData() {
    services = Get.find<ServiceController>().service;
    Get.find<ServiceController>().update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.getBackgroundPrimary(),
      body: GetBuilder<ServiceController>(
        builder: (controller) {
          if (services == null) {
            return Center(
                child: CircularProgressIndicator(
              color: ColorConstant.getLoadingColor(),
            ));
          }

          if (services!.isEmpty) {
            return Center(
              child: Text(
                KeyLanguage.listEmpty.tr,
              ),
            );
          }
          return ListView.builder(
            itemCount: services!.length,
            itemBuilder: (context, index) {
              if (services == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              ServiceResponse roomResponse = services![index];
              return Container(
                margin: const EdgeInsets.symmetric(
                  vertical: DimensionUtils.MARGIN_SIZE_DEFAULT,
                  horizontal: DimensionUtils.MARGIN_SIZE_DEFAULT,
                ),
                decoration: const BoxDecoration(color: Colors.white),
                child: ListTile(
                  title: Text(roomResponse.name ?? "Tên phòng"),
                  subtitle: Text(roomResponse.description ?? "Mô tả"),
                  trailing: Text("${roomResponse.price ?? 0.0}"),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstant.getPrimaryColor(),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: DimensionUtils.PADDING_SIZE_DEFAULT,
                      horizontal: DimensionUtils.PADDING_SIZE_DEFAULT),
                  width: Get.width * 0.9,
                  height: Get.height * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFieldWidget(
                        controller: nameController,
                        labelText: "Tên dịch vụ",
                      ),
                      const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                      ),
                      TextFieldWidget(
                        controller: descriptionController,
                        labelText: "Mô tả dịch vụ",
                      ),
                      const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                      ),
                      TextFieldWidget(
                        controller: priceController,
                        labelText: "Giá tiền",
                        validator: (value) {
                          return ValidationHelper.validNumber(value);
                        },
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ButtonDialog(
                            label: "Hủy",
                            isCancel: true,
                            onTap: () {
                              Get.back();
                              clearController();
                            },
                          ),
                          const SizedBox(
                            width: DimensionUtils.SIZE_BOX_HEIGHT_DEFAULT,
                          ),
                          ButtonDialog(
                            label: "Đồng ý",
                            onTap: () {
                              addRoom();
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void addRoom() {
    String name = nameController.text;
    String description = descriptionController.text;
    double price = double.parse(priceController.text);

    Service service = Service(
      name: name,
      description: description,
      price: price,
    );

    Get.find<ServiceController>().creatService(service).then(
      (value) {
        if (value == 200) {
          clearController();
          showCustomSnackBar("Thêm thành công : ${service.name}");
          Get.back();
        }
      },
    );
  }

  clearController() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
  }
}
