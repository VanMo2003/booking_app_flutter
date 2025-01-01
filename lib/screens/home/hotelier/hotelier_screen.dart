import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../controller/hotel_controller.dart';
import '../../../utils/color_constant.dart';
import '../../widgets/loading_widget.dart';
import 'order_screen.dart';
import 'person_screen.dart';
import 'revenue_sceen.dart';
import 'room_sceen.dart';
import 'service_sceen.dart';

class HotelierScreen extends StatefulWidget {
  const HotelierScreen({super.key});

  @override
  State<HotelierScreen> createState() => _HotelierScreenState();
}

class _HotelierScreenState extends State<HotelierScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var _currentIndex = 0.obs;

  List<Widget> listWidget = [
    RoomSceen(),
    ServiceSceen(),
    OrderScreen(),
    RevenueSceen(),
    PersonScreen(),
  ];

  List<String> listTitle = [
    "phòng",
    "dịch vụ",
    "đơn hàng",
    "doanh thu",
    "Cá nhân",
  ];

  @override
  void initState() {
    super.initState();
    Get.find<HotelController>().getHotelMySelf();
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<HotelController>().clearData();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Obx(() {
        return Scaffold(
          backgroundColor: ColorConstant.getBackgroundPrimary(),
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: ColorConstant.getPrimaryColor(),
            toolbarHeight: 50,
            elevation: 10,
            title: Text(
              listTitle[_currentIndex.value].tr,
            ),
            centerTitle: true,
          ),
          body: Container(
            child: listWidget[_currentIndex.value],
          ),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: _currentIndex.value,
            onTap: (i) => _currentIndex.value = i,
            items: [
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.room,
                  color: Theme.of(context).disabledColor,
                ),
                title: Text(listTitle[0]),
                selectedColor: ColorConstant.getPrimaryColor(),
              ),
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.room_service,
                  color: Theme.of(context).disabledColor,
                ),
                title: Text(listTitle[1]),
                selectedColor: ColorConstant.getPrimaryColor(),
              ),
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  color: Theme.of(context).disabledColor,
                ),
                title: Text(listTitle[2]),
                selectedColor: ColorConstant.getPrimaryColor(),
              ),
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.list,
                  color: Theme.of(context).disabledColor,
                ),
                title: Text(listTitle[3]),
                selectedColor: ColorConstant.getPrimaryColor(),
              ),
              SalomonBottomBarItem(
                icon: Icon(
                  Icons.person,
                  color: Theme.of(context).disabledColor,
                ),
                title: Text(listTitle[4]),
                selectedColor: ColorConstant.getPrimaryColor(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
