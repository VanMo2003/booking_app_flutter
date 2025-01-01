import 'package:booking_app_demo/screens/home/user/person_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/authentication_controller.dart';
import '../../../../controller/langue_controller.dart';
import '../../../../controller/loading_controller.dart';
import '../../../../controller/user_controller.dart';
import '../../../../helpers/route_helper.dart';
import '../../../../utils/dimensions.dart';
import '../../../../utils/language/key_language.dart';

class DrawerPersonWidget extends StatefulWidget {
  @override
  State<DrawerPersonWidget> createState() => _DrawerPersonWidgetState();
}

class _DrawerPersonWidgetState extends State<DrawerPersonWidget> {
  String langCode = "vi";

  @override
  void initState() {
    super.initState();
    langCode = Get.find<LanguageController>().getLocale();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: GetBuilder<UserController>(
        builder: (userController) {
          return Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  userController.user!.fullName ?? KeyLanguage.fullname.tr,
                  style: const TextStyle(
                    fontSize: DimensionUtils.FONT_SIZE_EXTRA_LARGE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                otherAccountsPictures: [
                  GetBuilder<LanguageController>(
                    builder: (controller) {
                      return GestureDetector(
                        onTap: () {
                          Get.find<LoadingController>().loading(
                            handle: () {
                              controller
                                  .changeLocale(langCode == "vi" ? "en" : "vi");
                              Get.back();
                            },
                          );
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(langCode == "vi"
                              ? "https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/800px-Flag_of_Vietnam.svg.png"
                              : "https://imgproxy7.tinhte.vn/RNzAb5pRNbyb5mbYzkHx0WTlUiRIbx2Kjey9FVgyhM0/w:400/plain/https://photo2.tinhte.vn/data/attachment-files/2022/12/6238921_tinhte-co-uk-1.png"),
                        ),
                      );
                    },
                  )
                ],
                accountEmail: Text(
                  userController.user!.phone ?? KeyLanguage.phone.tr,
                  style: const TextStyle(
                    fontSize: DimensionUtils.FONT_SIZE_SMALL,
                  ),
                ),
                currentAccountPicture: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://img.freepik.com/premium-photo/elevate-your-brand-with-friendly-avatar-that-reflects-professionalism-ideal-sales-managers_1283595-18531.jpg",
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    buttonItem(
                      icon: Icons.home,
                      label: KeyLanguage.house.tr,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    buttonItem(
                      icon: Icons.person,
                      label: KeyLanguage.person.tr,
                      onTap: () {
                        Get.to(PersonUserScreen());
                      },
                    ),
                    buttonItem(
                      icon: Icons.shopping_cart,
                      label: KeyLanguage.order.tr,
                      onTap: () {
                        Get.toNamed(RouteHelper.orderUser);
                      },
                    ),
                    buttonItem(
                      icon: Icons.bookmark,
                      label: KeyLanguage.favorite.tr,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    buttonItem(
                      icon: Icons.settings,
                      label: KeyLanguage.setting.tr,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(),
                    buttonItem(
                      icon: Icons.logout,
                      label: KeyLanguage.logout.tr,
                      onTap: () {
                        Get.find<LoadingController>().loading(
                          handle: () {
                            Get.find<AuthenticationController>().logout();
                          },
                        );
                        // Đăng xuất
                      },
                    ),
                  ],
                ),
              ),

              // Footer với thông tin bổ sung hoặc bản quyền
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buttonItem(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        onTap();
      },
    );
  }
}
