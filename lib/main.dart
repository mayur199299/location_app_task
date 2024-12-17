import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location_app/Routes/app_pages.dart';
import 'package:location_app/Utils/local_storage.dart';
import 'package:sizer/sizer.dart'; // Import Sizer package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.instance.init();

  String? token = LocalStorage.instance.getVerificationToken();

  Widget initialWidget;

  initialWidget = GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'MP Buyer',
    theme: ThemeData(
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    // initialRoute: token == null || token.isEmpty
    //     ? AppRoutes.splash
    //     : AppRoutes.homepage,
    getPages: AppPages.pages,
  );

  runApp(
    Sizer(
      builder: (context, orientation, deviceType) {
        return initialWidget;
      },
    ),
  );
}
