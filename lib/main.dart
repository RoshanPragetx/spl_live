import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'helper_files/constant_variables.dart';
import 'localization/app_localization.dart';
import 'routes/app_routes.dart';
import 'routes/app_routes_name.dart';
import 'screens/Local Storage.dart';
import 'screens/initial_bindings.dart';
import 'self_closing_page.dart';

void main() async {
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Allow only portrait orientation
    DeviceOrientation.portraitDown,
  ]);
//  Get.put(AppLifecycleController());
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

class MyApp extends StatelessWidget {
  MyApp({super.key});
  var conrroller = Get.put(InactivityController());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return Listener(
          onPointerSignal: conrroller.onUserInteraction,
          onPointerDown: conrroller.onUserInteraction,
          onPointerMove: conrroller.onUserInteraction,
          onPointerUp: conrroller.onUserInteraction,
          child: GetMaterialApp(
            title: 'SPL app',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            defaultTransition: Transition.fadeIn,
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            transitionDuration: const Duration(milliseconds: 500),
            translations: AppLocalization(),
            locale: getLocale(),
            initialBinding: InitialBindings(),
            initialRoute: AppRoutName.splashScreen,
            getPages: AppRoutes.pages,
          ),
        );
      },
    );
  }

  Locale getLocale() {
    var storedLocale = LocalStorage.read(ConstantsVariables.languageName);
    var locale = const Locale('en', 'US');
    switch (storedLocale) {
      case ConstantsVariables.localeEnglish:
        locale = const Locale('en', 'US');
        break;

      case ConstantsVariables.localeHindi:
        locale = const Locale('hi', 'IN');
        break;

      default:
        locale = const Locale('en', 'US');
    }
    return locale;
  }
}

class AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      print("hello world");
      // App is in the foreground
    } else if (state == AppLifecycleState.paused) {
      print("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
      // App is in the background
    } else if (state == AppLifecycleState.inactive) {
      print(
          "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    }
  }
}
