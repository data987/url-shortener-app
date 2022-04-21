class EnvironmentConfig {
  ///
  /// Url for service
  ///
  static const String apiURL = String.fromEnvironment('API_URL',
      defaultValue: "https://url-shortener-nu.herokuapp.com/api/");

  ///
  /// Environment PROD; QA; STAGE or DEV
  ///
  static const String envValue =
      String.fromEnvironment('ENV', defaultValue: "DEV");
}
