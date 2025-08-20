import 'package:eco_waste/features/news/models/news_model.dart';
import 'package:eco_waste/utils/http/http_client.dart';
import 'package:eco_waste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsController extends GetxController {
  final REYHttpHelper httpHelper = Get.put(REYHttpHelper());
  final RxList<NewsModel> newsList = <NewsModel>[].obs;
  final RxList<NewsModel> internalNewsList = <NewsModel>[].obs;

  Rx<bool> isLoading = false.obs;
  Rx<bool> hasMore = false.obs;
  Rx<bool> isLoadingInternal = false.obs;

  int page = 1;
  final int pageSize = 5;

  WebViewController? webViewController;
  Rx<bool> isWebViewLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getInternalNews(); // Load internal news first
    getExternalNews(); // Then load external news
  }

  /// Get internal news from API (if available)
  Future<void> getInternalNews() async {
    if (isLoadingInternal.value) return;

    try {
      isLoadingInternal.value = true;

      final response = await httpHelper.getRequest('news');

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          final List<dynamic> newsData = responseBody['data'];
          internalNewsList.value = newsData
              .map((item) => NewsModel.fromJson(item))
              .toList();
        }
      }
    } catch (e) {
      // If internal news API fails, continue silently
      print('Internal news API not available: ${e.toString()}');
    } finally {
      isLoadingInternal.value = false;
    }
  }

  /// Get external news from newsdata.io
  void getExternalNews() async {
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
        List<NewsModel> fetchedNews = articles.map((data) {
          // Transform external API data to match our model
          final transformedData = {
            'id': data['article_id'] ?? '',
            'title': data['title'] ?? '',
            'description': data['description'] ?? '',
            'content': data['content'],
            'link': data['link'] ?? '',
            'image_url': data['image_url'] ?? '',
            'pubDate': data['pubDate'] ?? '',
            'source_name': data['source_name'] ?? '',
            'author': data['creator']?.isNotEmpty == true
                ? data['creator'][0]
                : null,
            'category': data['category']?.isNotEmpty == true
                ? data['category'][0]
                : null,
            'is_active': true,
            'created_at': data['pubDate'] ?? DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          };
          return NewsModel.fromJson(transformedData);
        }).toList();

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
      REYHttpHelper.setBaseUrl('https://api.greenappstelkom.id/api');
    }
  }

  /// Get combined news list (internal + external)
  List<NewsModel> get combinedNewsList {
    return [...internalNewsList, ...newsList];
  }

  /// Create internal news (Admin only)
  Future<void> createNews({
    required String title,
    required String description,
    String? content,
    required String imageUrl,
    String? author,
    String? category,
  }) async {
    try {
      isLoadingInternal.value = true;

      final newsData = {
        'title': title,
        'description': description,
        'content': content,
        'image_url': imageUrl,
        'author': author,
        'category': category,
        'is_active': true,
      };

      final response = await httpHelper.postRequest('news', newsData);

      if (response.statusCode == 201) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message: 'News created successfully',
          );

          // Refresh internal news list
          getInternalNews();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to create news',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to create news: ${e.toString()}',
      );
    } finally {
      isLoadingInternal.value = false;
    }
  }

  /// Update internal news (Admin only)
  Future<void> updateNews(
    String newsId,
    Map<String, dynamic> updateData,
  ) async {
    try {
      isLoadingInternal.value = true;

      final response = await httpHelper.putRequest('news/$newsId', updateData);

      if (response.statusCode == 200) {
        final responseBody = response.body;

        if (responseBody['status'] == 'success') {
          REYLoaders.successSnackBar(
            title: 'Success',
            message: 'News updated successfully',
          );

          // Refresh internal news list
          getInternalNews();
        } else {
          REYLoaders.errorSnackBar(
            title: 'Error',
            message: responseBody['message'] ?? 'Failed to update news',
          );
        }
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to update news: ${e.toString()}',
      );
    } finally {
      isLoadingInternal.value = false;
    }
  }

  /// Delete internal news (Admin only)
  Future<void> deleteNews(String newsId) async {
    try {
      isLoadingInternal.value = true;

      final response = await httpHelper.deleteRequest('news/$newsId');

      if (response.statusCode == 200) {
        REYLoaders.successSnackBar(
          title: 'Success',
          message: 'News deleted successfully',
        );

        // Refresh internal news list
        getInternalNews();
      } else {
        REYLoaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to delete news',
        );
      }
    } catch (e) {
      REYLoaders.errorSnackBar(
        title: 'Error',
        message: 'Failed to delete news: ${e.toString()}',
      );
    } finally {
      isLoadingInternal.value = false;
    }
  }

  void initializeWebViewController(String url) async {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(url));
    isWebViewLoading(false);
  }

  /// Search news by title or description
  List<NewsModel> searchNews(String query) {
    if (query.isEmpty) return combinedNewsList;

    return combinedNewsList
        .where(
          (news) =>
              news.title.toLowerCase().contains(query.toLowerCase()) ||
              news.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  /// Filter news by category
  List<NewsModel> filterNewsByCategory(String category) {
    return combinedNewsList
        .where((news) => news.category?.toLowerCase() == category.toLowerCase())
        .toList();
  }
}
