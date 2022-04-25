import '../api/api_provider.dart';
import 'repositories.dart';
import 'package:http/http.dart' as http;

http.Client httpClient = http.Client();

final HomeRepository homeRepository =
    HomeRepository(apiProvider: ApiProvider(httpClient: httpClient));
