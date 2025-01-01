import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/room_controller.dart';
import '../../../data/models/body/room.dart';
import '../../../data/models/response/room_response.dart';
import '../../../helpers/valid_helper.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/language/key_language.dart';
import '../../../views/custom_snackbar.dart';
import '../../widgets/text_field_widget.dart';
import 'widgets/button_dialog.dart';

class RoomSceen extends StatefulWidget {
  const RoomSceen({super.key});

  @override
  State<RoomSceen> createState() => _RoomSceenState();
}

class _RoomSceenState extends State<RoomSceen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<RoomResponse>? rooms;

  final form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (Get.find<RoomController>().rooms == null) {
      Get.find<RoomController>().getAllRoomByHotel().then(
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
    rooms = Get.find<RoomController>().rooms;
    Get.find<RoomController>().update();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.getBackgroundPrimary(),
      body: GetBuilder<RoomController>(
        builder: (controller) {
          if (rooms == null) {
            return Center(
                child: CircularProgressIndicator(
              color: ColorConstant.getLoadingColor(),
            ));
          }

          if (rooms!.isEmpty) {
            log("List Empty");
            return Center(
              child: Text(
                KeyLanguage.listEmpty.tr,
              ),
            );
          }
          return ListView.builder(
            itemCount: rooms!.length,
            itemBuilder: (context, index) {
              RoomResponse roomResponse = rooms![index];
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
                        labelText: "Tên phòng",
                      ),
                      const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                      ),
                      TextFieldWidget(
                        controller: descriptionController,
                        labelText: "Mô tả phòng",
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

    Room room = Room(
      name: name,
      description: description,
      price: price,
    );

    Get.find<RoomController>().creatRoom(room).then(
      (value) {
        if (value == 200) {
          clearController();
          showCustomSnackBar("Thêm thành công : ${room.name}");
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
