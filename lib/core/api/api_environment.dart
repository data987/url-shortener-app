import '../../environment_config.dart';

class ApiEndpoints {
  ///
  /// POST Login
  ///
  /// @deprecated [baseUrl]: Base of endpoint, only for dev or temporal cases
  ///
  static String login({String? baseUrl}) {
    baseUrl = baseUrl ?? EnvironmentConfig.apiURL;
    return "$baseUrl/v1/login";
  }
}
