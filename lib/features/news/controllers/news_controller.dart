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
  Rx<bool> hasMore = true.obs;
  Rx<bool> isLoadingMore = false.obs;

  String? nextPageToken;

  WebViewController? webViewController;
  Rx<bool> isWebViewLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getNews();
  }

  void getNews({bool isLoadMore = false}) async {
    if (isLoadMore && isLoadingMore.value) return;
    if (!isLoadMore && isLoading.value) return;

    if (isLoadMore) {
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
      newsList.clear();
      nextPageToken = null;
    }

    REYHttpHelper.setBaseUrl('https://newsdata.io/api/1/');

    try {
      String url = "latest?apikey=${dotenv.env['NEWS_API_KEY']}&q=sampah";

      // Add nextPage parameter if this is a load more request
      if (isLoadMore && nextPageToken != null) {
        url += "&page=$nextPageToken";
      }

      final newsResponse = await httpHelper.getRequest(url);

      if (newsResponse.statusCode == 200 && newsResponse.body is Map) {
        final newsResponseModel = NewsResponse.fromJson(newsResponse.body);

        if (newsResponseModel.status == 'success') {
          if (newsResponseModel.results.isNotEmpty) {
            newsList.addAll(newsResponseModel.results);
            nextPageToken = newsResponseModel.nextPage;
            hasMore.value = nextPageToken != null;
          } else {
            hasMore.value = false;
          }
        } else {
          REYLoaders.errorSnackBar(
            title: 'loadNewsError'.tr,
            message: '${'statusNotSuccessful'.tr}: ${newsResponseModel.status}',
          );
        }
      } else {
        REYLoaders.errorSnackBar(
          title: 'loadNewsError'.tr,
          message: '${'responseNotValid'.tr}: ${newsResponse.statusCode}',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'loadNewsError'.tr,
        message: e.toString(),
      );
    } finally {
      if (isLoadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
      REYHttpHelper.setBaseUrl('https://api.greenappstelkom.id/api');
    }
  }

  void loadMoreNews() {
    if (hasMore.value && !isLoadingMore.value) {
      getNews(isLoadMore: true);
    }
  }

  void refreshNews() {
    getNews(isLoadMore: false);
  }

  void initializeWebViewController(String url) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    isWebViewLoading(false);
  }
}
