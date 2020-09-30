
import 'package:universal_html/html.dart' as html;

class CookieManager {

  static addToCookie(String key, String value) {
     // 2592000 sec = 30 days.
     //  max-age=2592000;
     html.document.cookie = "$key=$value; path=/;";
  }

  static String getCookie(String key) {

    String cookies = html.document.cookie;
    List<String> listValues = cookies.isNotEmpty ? cookies.split(";") : List();
    String matchVal = "";
    for (int i = 0; i < listValues.length; i++) {
      List<String> map = listValues[i].split("=");
      String _key = map[0].trim();
      String _val = map[1].trim();
      if (key == _key) {
        matchVal = _val;
        break;
      }
    }
    return matchVal;
  }
}