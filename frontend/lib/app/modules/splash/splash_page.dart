import 'package:flutter/material.dart';
import 'package:frontend/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:frontend/app/modules/splash/splash_controller.dart';

bool get isWindows => UniversalPlatform.isWindows;

class SplashPage extends GetView<SplashController> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (_){
            return Container(
              child: Text(isWindows.toString()),
            );
          }
        ),
      ),
    );
  }
}