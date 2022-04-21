class EnvironmentConfig {
  ///
  /// Url for service
  ///
  static const String apiURL = String.fromEnvironment('API_URL',
      defaultValue: "https://agent-service-dev.devonwatch.com");
}
