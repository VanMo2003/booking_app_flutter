import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/response/room_response.dart';
import '../../../data/models/response/service_response.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dimensions.dart';

class SelectService extends StatefulWidget {
  SelectService(
      {super.key, required this.services, required this.selectedServices});

  List<ServiceResponse> services;
  List<int> selectedServices;

  @override
  State<SelectService> createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back(result: widget.selectedServices);
            },
            icon: Icon(Icons.home)),
        backgroundColor: ColorConstant.getBackgroundAppBar(),
        title: Text(
          "Thêm dịch vụ",
        ),
        centerTitle: true,
      ),
      backgroundColor: ColorConstant.getBackgroundPrimary(),
      body: ListView.builder(
        itemCount: widget.services.length,
        itemBuilder: (context, index) {
          ServiceResponse serviceResponse = widget.services[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (widget.selectedServices.contains(serviceResponse.id)) {
                  log("bỏ chọn : ${serviceResponse.id}");
                  widget.selectedServices.remove(serviceResponse.id);
                } else {
                  log("chọn : ${serviceResponse.id}");
                  widget.selectedServices.add(serviceResponse.id!);
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: DimensionUtils.MARGIN_SIZE_DEFAULT,
                horizontal: DimensionUtils.MARGIN_SIZE_DEFAULT,
              ),
              decoration: BoxDecoration(
                  color: widget.selectedServices.contains(serviceResponse.id)
                      ? ColorConstant.getPrimaryColor()
                      : Colors.white),
              child: ListTile(
                title: Text(serviceResponse.name ?? "Tên phòng"),
                subtitle: Text(serviceResponse.description ?? "Mô tả"),
                trailing: Text("${serviceResponse.price ?? 0.0}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
