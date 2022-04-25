import '../../environment_config.dart';

class ApiEndpoints {
  ///
  /// POST get url shorten
  ///
  /// @deprecated [baseUrl]: Base of endpoint, only for dev or temporal cases
  ///
  static String postUrl({String? baseUrl}) {
    baseUrl = baseUrl ?? EnvironmentConfig.apiURL;
    return "$baseUrl/alias";
  }
}
