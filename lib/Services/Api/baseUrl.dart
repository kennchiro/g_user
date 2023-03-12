class BaseUrl {
  static const String online = "https://sav.neny.fr";
  static const String local = "http://192.168.144.196:8000";

  static String currentUrl = BaseUrl.local;

  static String getCurrentBaseUrl() {
    switch (BaseUrl.currentUrl) {
      case BaseUrl.local:
        return 'local';
      case BaseUrl.online:
        return 'online';
      default:
        return 'online';
    }
  }
}
