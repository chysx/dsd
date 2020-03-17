/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2020-03-09 15:53

class SfConfig {
  static String url ='https://test.salesforce.com/services/oauth2/token';
  static String clientId = '3MVG9lcxCTdG2VbvVIU4x0gAacuOdRIjZlxol_fARoYQscWCRfeaCWkBCFVtHB3Gi_HFIXUR.NBVAcAgiV_yN';
  static String clientSecret = 'DBC6ED3FD0845C4065ADAC14CF05C8BF4C544023330319783A7B005A00A02952';
  static String grantType = 'password';
  static String userName = 'bruce.yue@cchellenic.com.devcch';
  static String password = 'ebest#2020';

  static String clientIdLabel = 'client_id';
  static String clientSecretLabel = 'client_secret';
  static String grantTypeLabel = 'grant_type';
  static String userNameLabel = 'username';
  static String passwordLabel = 'password';

  static String makeConfig() {
    String result = '';
    result += grantTypeLabel + '=' + grantType + "&";
    result += clientIdLabel + '=' + clientId + "&";
    result += clientSecretLabel + '=' + clientSecret + "&";
    result += userNameLabel + '=' + userName + "&";
    result += passwordLabel + '=' + password;
    return result;
  }
}