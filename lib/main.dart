import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/binding/all_controller_bindings.dart';
import 'app/core/themes/app_color.dart';
import 'app/core/themes/app_textstyle.dart';
import 'app/routes/app_pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zama XR',
      debugShowCheckedModeBanner: false,
      initialBinding: AllControllerBindings(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: AppTextStyle.fontFamily,
        scaffoldBackgroundColor: AppColor.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primary,
          primary: AppColor.primary,
          secondary: AppColor.secondary,
        ),
      ),
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: mediaQuery.textScaler.clamp(
              minScaleFactor: 0.9,
              maxScaleFactor: 1.05,
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}

