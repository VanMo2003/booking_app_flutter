import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/hotel_controller.dart';
import '../../../../data/models/response/hotel_response.dart';
import '../../../../utils/color_constant.dart';
import '../hotel_detail.dart';
import '../popular_place_item.dart';

class ResultSearchScreen extends StatefulWidget {
  const ResultSearchScreen({super.key, required this.searchText});

  final String searchText;

  @override
  State<ResultSearchScreen> createState() => _ResultSearchScreenState();
}

class _ResultSearchScreenState extends State<ResultSearchScreen> {
  List<HotelResponse>? _hotels = [];
  @override
  void initState() {
    super.initState();
    Get.find<HotelController>().getAllHotelsByName(widget.searchText).then(
      (value) {
        _hotels = Get.find<HotelController>().searchHotels!;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<HotelController>().clearDataSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.getBackgroundPrimary(),
      appBar: AppBar(
        backgroundColor: ColorConstant.getBackgroundPrimary(),
        centerTitle: true,
        title: Text("Tìm kiếm: ${widget.searchText}"),
      ),
      body: GetBuilder<HotelController>(
        builder: (controller) {
          if (_hotels!.isEmpty) {
            return const Center(
              child: Text("Không thấy kết quả tìm kiếm"),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: _hotels!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.to(HotelDetail(hotel: _hotels![index]));
                },
                child: PopularPlaceItem(hotel: _hotels![index]),
              );
            },
          );
        },
      ),
    );
  }
}
