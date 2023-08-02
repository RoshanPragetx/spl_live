import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'helper_files/constant_variables.dart';
import 'localization/app_localization.dart';
import 'routes/app_routes.dart';
import 'routes/app_routes_name.dart';
import 'screens/Local Storage.dart';
import 'screens/initial_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return GetMaterialApp(
          title: 'SPL app',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          defaultTransition: Transition.fadeIn,
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          transitionDuration: const Duration(milliseconds: 500),
          //  home: const DashBoardPage(),
          translations: AppLocalization(),
          locale: getLocale(),
          initialBinding: InitialBindings(),
          initialRoute: AppRoutName.splashScreen,
          getPages: AppRoutes.pages,
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
