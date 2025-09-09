import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/news/controllers/news_controller.dart';
import 'package:eco_waste/features/news/screens/widgets/news_card.dart';
import 'package:eco_waste/features/user/personalization/screens/profile/profile.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.put(NewsController());

    return Scaffold(
      appBar: REYAppBar(
        title: Text(
          'Berita',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(ProfileScreen()),
            child: Image.asset(REYImages.user, width: 40, height: 40),
          ),
        ],
      ),
      body: Obx(() {
        if (newsController.isLoading.value && newsController.newsList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            newsController.refreshNews();
          },
          color: REYColors.primary,
          child: NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!newsController.isLoadingMore.value &&
                  scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent - 200 &&
                  newsController.hasMore.value) {
                newsController.loadMoreNews();
              }
              return false;
            },
            child: ListView.builder(
              itemCount:
                  newsController.newsList.length +
                  (newsController.hasMore.value ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == newsController.newsList.length) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: newsController.isLoadingMore.value
                          ? const CircularProgressIndicator(
                              color: REYColors.primary,
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                }
                var item = newsController.newsList[index];
                return NewsCard(
                  imageUrl: item.imageUrl,
                  title: item.title,
                  source: item.sourceName,
                  date: item.pubDate,
                  url: item.link,
                );
              },
            ),
          ),
        );
      }),
    );
  }
}
