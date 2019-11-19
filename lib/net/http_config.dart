/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/7/30 16:36

class HttpConfig {
  static UrlConfig urlConfig = UrlConfig.QAS;

  static const String SCHEME_HTTP = "http://";
  static const String SCHEME_HTTPS = "https://";

  static String getHost() {
    switch (urlConfig) {
      case UrlConfig.DEV:
        return UrlDev.HOST;
      case UrlConfig.UAT:
        return UrlUat.HOST;
      case UrlConfig.QAS:
        return UrlQas.HOST;
      case UrlConfig.PRD:
        return UrlPrd.HOST;
    }
    return UrlDev.HOST;
  }

  static String getPort() {
    switch (urlConfig) {
      case UrlConfig.DEV:
        return UrlDev.PORT;
      case UrlConfig.QAS:
        return UrlQas.PORT;
      case UrlConfig.UAT:
        return UrlUat.PORT;
      case UrlConfig.PRD:
        return UrlPrd.PORT;
    }
    return UrlDev.PORT;
  }

  static String getScheme() {
    switch (urlConfig) {
      case UrlConfig.DEV:
        if (UrlDev.IS_SSL) {
          return SCHEME_HTTPS;
        } else {
          return SCHEME_HTTP;
        }
        break;
      case UrlConfig.QAS:
        if (UrlQas.IS_SSL) {
          return SCHEME_HTTPS;
        } else {
          return SCHEME_HTTP;
        }
        break;
      case UrlConfig.UAT:
        if (UrlUat.IS_SSL) {
          return SCHEME_HTTPS;
        } else {
          return SCHEME_HTTP;
        }
        break;
      case UrlConfig.PRD:
        if (UrlPrd.IS_SSL) {
          return SCHEME_HTTPS;
        } else {
          return SCHEME_HTTP;
        }
        break;
      default:
        return SCHEME_HTTP;
    }
  }

  static bool isSsl() {
    return getScheme() == (SCHEME_HTTPS);
  }

  String api() {
    return Url.API();
  }

  String fileApi() {
    return FileUrl.API();
  }
}

enum UrlConfig { PRD, UAT, QAS, DEV }

class UrlDev {
  static const String HOST = "180.166.98.86";
  static const String PORT = "1089";
  static const bool IS_SSL = false;
  static const String ENV = "DEV";
}

//class UrlQas {
//  static const String HOST = "aglsfaqa.ebestmobile.net";
//  static const String PORT = "8085";
//  static const bool IS_SSL = true;
//  static const String ENV = "QAS";
//}

class UrlQas {
  static const String HOST = "40.89.153.240";
  static const String PORT = "1080";
  static const bool IS_SSL = false;
  static const String ENV = "QAS";
}

class UrlUat {
  static const String HOST = "40.89.153.240";
  static const String PORT = "1088";
  static const bool IS_SSL = false;
  static const String ENV = "UAT";
}

//class UrlUat {
//  static const String HOST = "180.166.98.86";
//  static const String PORT = "1090";
//  static const bool IS_SSL = false;
//  static const String ENV = "UAT";
//}

class UrlPrd {
  static const String HOST = "40.89.153.240";
  static const String PORT = "1090";
  static const bool IS_SSL = false;
  static const String ENV = "PRD";
}

class Url {
  static String SCHEME = HttpConfig.getScheme();
  static String HOST = HttpConfig.getHost();
  static String PORT = HttpConfig.getPort();

  static String API() {
    SCHEME = HttpConfig.getScheme();
    HOST = HttpConfig.getHost();
    PORT = HttpConfig.getPort();
    return SCHEME + HOST + ":" + PORT;
  }
}

class FileUrl {
  static String SCHEME = HttpConfig.getScheme();
  static String HOST = HttpConfig.getHost();
  static String PORT = HttpConfig.getPort();
  static String METHOD = "/FileService/AndroidFileService.svc/MobileUploadFile";

  static String API() {
    return SCHEME + HOST + ":" + PORT + METHOD;
  }
}

class PriceUrl {
  static String SCHEME = HttpConfig.getScheme();
  static String HOST = HttpConfig.getHost();
  static String PORT = HttpConfig.getPort();
  static String METHOD = "/SFAMiddleware/api/GetOnlinePricingByAPI";

  static String API() {
    return SCHEME + HOST + ":" + PORT + METHOD;
  }
}

class TimeOut {
  static const int CONNECT_TIMEOUT = 120 * 1000;
  static const int READ_TIMEOUT = 120 * 1000;
  static const int WRITE_TIMEOUT = 120 * 1000;
}

class DirectionUrl {
  static const String HOST = "maps.googleapis.com";
  static const String SCHEME = "https://";
  static const String METHOD = "/maps/api/directions/json?";
  static const String API = SCHEME + HOST + METHOD;
}
