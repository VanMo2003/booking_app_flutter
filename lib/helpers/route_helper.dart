import 'package:demo_booking_app/screens/auth_screen/enter_info_screen.dart';
import 'package:get/get.dart';

import '../screens/auth_screen/sign_in_screen.dart';
import '../screens/auth_screen/sign_up_screen.dart';
import '../screens/init_screen.dart';
import '../screens/splash_screen/splash_screen.dart';

class RouteHelper {
  static const String initial = "/init";
  static const String splash = "/splash";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";
  static const String enterInfo = "/enter-info";

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;
  static String getEnterInfoRoute() => enterInfo;

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => InitScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(
      name: signIn,
      page: () => SignInScreen(),
    ),
    GetPage(name: signUp, page: () => SignUpScreen()),
  ];
}
