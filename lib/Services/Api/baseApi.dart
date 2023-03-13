import 'baseUrl.dart';

class BaseAPI {
  ////////////////////////////////[ USER API ] ///////////////////////////////////////

  static String connexionEndPoint = '${BaseUrl.currentUrl}/api/login';
  static String creerCompteEndPoint = '${BaseUrl.currentUrl}/api/register';
  static String getUserInfoEndPoint = '${BaseUrl.currentUrl}/api/user';
  static String addUserInfoEndPoint = '${BaseUrl.currentUrl}/api/user';
  static String updateUserInfoEndPoint = '${BaseUrl.currentUrl}/api/user/';
  static String setActiveUserEndPoint =
      '${BaseUrl.currentUrl}/api/user/is-active/';
  static String setAdminEndPoint = '${BaseUrl.currentUrl}/api/user/is-admin/';
  static String updatePasswordUserEndPoint =
      '${BaseUrl.currentUrl}/api/update-password';
  static String forgotPasswordUserEndPoint =
      '${BaseUrl.currentUrl}/api/forgot-password';
}
