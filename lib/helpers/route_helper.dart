import 'package:get/get.dart';

import '../screens/auth_screen/sign_in.dart';
import '../screens/auth_screen/sign_up.dart';
import '../screens/init_screen.dart';
import '../screens/splash_screen/splash_screen.dart';

class RouteHelper {
  static const String initial = "/init";
  static const String splash = "/splash";
  static const String signIn = "/sign-in";
  static const String signUp = "/sign-up";

  static String getInitialRoute() => initial;
  static String getSplashRoute() => splash;
  static String getSignInRoute() => signIn;
  static String getSignUpRoute() => signUp;

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => const InitScreen()),
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(
      name: signIn,
      page: () => SignInScreen(),
    ),
    GetPage(name: signUp, page: () => SignUpScreen()),
  ];
}
