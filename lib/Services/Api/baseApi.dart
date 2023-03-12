import 'baseUrl.dart';

class BaseAPI {
  ////////////////////////////////[ USER API ] ///////////////////////////////////////

  static String connexionEndPoint = '${BaseUrl.currentUrl}/api/login_check';
  static String creerCompteEndPoint = '${BaseUrl.currentUrl}/api/signUp';
  static String getUserInfoEndPoint = '${BaseUrl.currentUrl}/api/getUserInfo';
}
