import 'baseUrl.dart';

class BaseAPI {
  ////////////////////////////////[ USER API ] ///////////////////////////////////////

  static String connexionEndPoint = '${BaseUrl.currentUrl}/api/login';
  static String creerCompteEndPoint = '${BaseUrl.currentUrl}/api/register';
  static String getUserInfoEndPoint = '${BaseUrl.currentUrl}/api/user';
  static String addUserInfoEndPoint = '${BaseUrl.currentUrl}/api/user';
  static String updateUserInfoEndPoint = '${BaseUrl.currentUrl}/api/user/';

}
