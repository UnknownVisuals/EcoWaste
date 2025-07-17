import 'package:eco_waste/features/news/models/news_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final RxList<NewsModel> newsList = <NewsModel>[].obs;

  Rx<bool> isLoading = false.obs;
  Rx<bool> hasMore = false.obs;

  int page = 1;
  final int pageSize = 5;

  WebViewController? webViewController;
  Rx<bool> isWebViewLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNews();
  }

  void getNews() async {
    if (isLoading.value) return;
    isLoading.value = true;

    REYHttpHelper.setBaseUrl('https://newsdata.io/api/1/');

    try {
      final newsResponse = await httpHelper.getRequest(
        "latest?apikey=${dotenv.env['NEWS_API_KEY']}&q=sampah",
      );

      List<dynamic>? articles;
      if (newsResponse.statusCode == 200 &&
          newsResponse.body is Map &&
          newsResponse.body['results'] is List) {
        articles = newsResponse.body['results'] as List;
      }

      if (articles != null) {
        List<NewsModel> fetchedNews = articles
            .map((data) => NewsModel.fromJson(data as Map<String, dynamic>))
            .toList();

        if (fetchedNews.length < pageSize) {
          hasMore.value = false;
        } else {
          hasMore.value = true;
        }

        newsList.addAll(fetchedNews);
        page++;
      } else {
        REYLoaders.errorSnackBar(
          title: "Gagal memuat berita",
          message: "Format data tidak sesuai: ${newsResponse.body}",
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: "Gagal memuat berita",
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
      REYHttpHelper.setBaseUrl('https://api.sobatsampah.id/api');
    }
  }

  void initializeWebViewController(String url) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    isWebViewLoading(false);
  }
}
