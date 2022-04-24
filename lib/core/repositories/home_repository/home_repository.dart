import 'package:url_shortener_app/core/api/api_provider.dart';
import 'package:url_shortener_app/core/models/url_shorten_model.dart';

class HomeRepository {
  HomeRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<UrlShorten> postUrlToShorten({required String urlToShorten}) async {
    final Map<String, dynamic> postUrlResponse =
        await apiProvider.postUrlToShorten(urlToShorten);
    final responseToModel = UrlShorten.fromJson(postUrlResponse);
    return responseToModel;
  }
}
