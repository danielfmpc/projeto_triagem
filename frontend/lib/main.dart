import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:get/get.dart';

void main() {
  runApp(
    GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.INITIAL,
        defaultTransition: Transition.fade,
        getPages: AppPages.pages,
    )
  );
}