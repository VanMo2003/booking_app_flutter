import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/response/room_response.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dimensions.dart';

class SelectRoom extends StatefulWidget {
  SelectRoom({super.key, required this.rooms, required this.selectedRooms});

  List<RoomResponse> rooms;
  List<int> selectedRooms;

  @override
  State<SelectRoom> createState() => _SelectRoomState();
}

class _SelectRoomState extends State<SelectRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back(result: widget.selectedRooms);
            },
            icon: Icon(Icons.home)),
        backgroundColor: ColorConstant.getBackgroundAppBar(),
        title: Text(
          "Chọn phòng",
        ),
        centerTitle: true,
      ),
      backgroundColor: ColorConstant.getBackgroundPrimary(),
      body: ListView.builder(
        itemCount: widget.rooms.length,
        itemBuilder: (context, index) {
          RoomResponse roomResponse = widget.rooms[index];
          return GestureDetector(
            onTap: () {
              setState(() {
                if (widget.selectedRooms.contains(roomResponse.id)) {
                  widget.selectedRooms.remove(roomResponse.id);
                } else {
                  widget.selectedRooms.add(roomResponse.id!);
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: DimensionUtils.MARGIN_SIZE_DEFAULT,
                horizontal: DimensionUtils.MARGIN_SIZE_DEFAULT,
              ),
              decoration: BoxDecoration(
                  color: widget.selectedRooms.contains(roomResponse.id)
                      ? ColorConstant.getPrimaryColor()
                      : Colors.white),
              child: ListTile(
                title: Text(roomResponse.name ?? "Tên phòng"),
                subtitle: Text(roomResponse.description ?? "Mô tả"),
                trailing: Text("${roomResponse.price ?? 0.0}"),
              ),
            ),
          );
        },
      ),
    );
  }
}
