import 'package:frontend/app/modules/home/desktop/homedesktop_page.dart';
import 'package:frontend/app/modules/home/web/homeweb_page.dart';
import 'package:frontend/app/modules/user/user_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

abstract class AppPages {

  static final pages = [
    GetPage(name: Routes.HOME_DESKTOP, page:()=> HomeDesktopPage(),),
    GetPage(name: Routes.HOME_WEB, page:()=> HomeWebPage(),),
    GetPage(name: Routes.USERS, page:()=> UserPage(),),
  ];
}