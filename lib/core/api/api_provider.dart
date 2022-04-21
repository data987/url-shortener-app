import 'package:http/http.dart' as http;

import 'api_environment.dart';
import 'http_requests.dart';

class ApiProvider {
  ApiProvider({required this.httpClient});

  http.Client httpClient;
  final HttpRequests _httpRequest = HttpRequests();

  // Get User login: GET
  Future<Map<String, dynamic>> getUserLogin(String token) async {
    final String getLoginUrl = ApiEndpoints.login();
    final loginResponse = await _httpRequest.get(
        httpClient: httpClient, url: getLoginUrl, token: token);
    return loginResponse;
  }
}
