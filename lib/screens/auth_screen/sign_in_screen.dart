import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/authentication_controller.dart';
import '../../controller/loading_controller.dart';
import '../../helpers/route_helper.dart';
import '../../helpers/valid_helper.dart';
import '../../utils/assets_utils.dart';
import '../../utils/dimensions.dart';
import '../../utils/language/key_language.dart';
import '../widgets/button_text_widget.dart';
import '../widgets/loading_widget.dart';
import '../widgets/text_field_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
      child: Scaffold(
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
                    Container(
                      height: DimensionUtils.ICON_SIZE_LOGO,
                      width: DimensionUtils.ICON_SIZE_LOGO,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            AssetsUtils.logoHotel,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                    ),
                    Text(
                      KeyLanguage.signIn.tr,
                      style: GoogleFonts.roboto(
                        fontSize: DimensionUtils.FONT_SIZE_TITLE_LARGE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_LARGE,
                    ),
                    TextFieldWidget(
                      controller: usernameController,
                      labelText: KeyLanguage.username.tr,
                    ),
                    const SizedBox(
                      height: DimensionUtils.SIZE_BOX_HEIGHT_SMALL,
                    ),
                    TextFieldWidget(
                      controller: passwordController,
                      labelText: KeyLanguage.password.tr,
                      isPasswordField: true,
                      validator: (value) {
                        return ValidationHelper.validPassword(value);
                      },
                    ),
                    const SizedBox(
                        height: DimensionUtils.SIZE_BOX_HEIGHT_LARGE),
                    ButtonTextWidget(
                      label: KeyLanguage.signIn.tr,
                      onTap: () {
                        signIn();
                      },
                    ),
                    const SizedBox(
                        height:
                            DimensionUtils.SIZE_BOX_HEIGHT_EXTRA_LARGE_OVER *
                                2 /
                                3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          KeyLanguage.questionSignUp.tr,
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () async {
                            toSignUp();
                          },
                          child: Text(
                            KeyLanguage.signUp.tr,
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
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

  void signIn() {
    String username = usernameController.text;
    String password = passwordController.text;

    if (form.currentState!.validate()) {
      Get.find<LoadingController>().loading(
        handle: () {
          Get.find<AuthenticationController>().login(username, password);
        },
      );
    }
  }

  void toSignUp() {
    Get.find<LoadingController>().loading(
      handle: () {
        Get.toNamed(RouteHelper.signUp);
      },
    );
  }
}
