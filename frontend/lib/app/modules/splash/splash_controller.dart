
import 'package:get/get.dart';

class SplashController extends GetxController {

  void platform(bool plat){
    if(plat){
      Get.offAllNamed('/home_desktop');
    } else {
      Get.offAllNamed('/home_web');
    }
  }
}