import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';

bool get isWindows => UniversalPlatform.isWindows;


void main() {
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: isWindows ? Routes.HOME_DESKTOP : Routes.HOME_WEB,
        defaultTransition: Transition.fade,
        getPages: AppPages.pages,
    )
  );
}