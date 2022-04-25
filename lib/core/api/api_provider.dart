import 'package:http/http.dart' as http;

import 'api_environment.dart';
import 'http_requests.dart';

class ApiProvider {
  ApiProvider({required this.httpClient});

  http.Client httpClient;
  final HttpRequests _httpRequest = HttpRequests();

  // Get User login: POST
  Future<Map<String, dynamic>> postUrlToShorten(String urlToShorten) async {
    final String postUrl = ApiEndpoints.postUrl();
    final urlShortenResponse = await _httpRequest.post(
      httpClient: httpClient,
      url: postUrl,
      body: {'url': urlToShorten},
    );
    return urlShortenResponse;
  }
}
