import '../../../controller/hotel_controller.dart';
import '../../../controller/booking_controller.dart';
import 'hotel_detail.dart';
import 'popular_place_item.dart';
import '../../widgets/loading_widget.dart';
import '../../../utils/color_constant.dart';
import '../../../utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/response/hotel_response.dart';
import 'widget/app_bar_custom.dart';
import 'display_item_horizontal.dart';
import 'widget/drawer_person_widget.dart';
import 'widget/popular_place_widget.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<HotelResponse>? _hotels = [];
  @override
  void initState() {
    super.initState();
    Get.find<HotelController>().getAllHotels().then(
      (value) {
        if (value == 200) {
          _hotels = Get.find<HotelController>().hotels!.sublist(0, 10);
        } else {
          _hotels = [];
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<BookingController>().clearData();
    Get.find<HotelController>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorConstant.getBackgroundPrimary(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.17),
          child: AppBarCustom(
            openDrawer: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
        drawer: DrawerPersonWidget(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.42,
                width: double.infinity,
                child: GetBuilder<HotelController>(
                  builder: (controller) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _hotels!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(HotelDetail(hotel: _hotels![index]));
                          },
                          child: DisplayItemsHorizontal(
                            hotel: _hotels![index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL),
              const PopularPlaceWidget(),
              SizedBox(
                height: Get.height * 0.42,
                width: double.infinity,
                child: GetBuilder<HotelController>(
                  builder: (controller) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: _hotels!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              HotelDetail(hotel: _hotels![index]),
                            );
                          },
                          child: PopularPlaceItem(
                            hotel: _hotels![index],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
