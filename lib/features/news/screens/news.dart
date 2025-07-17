import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/authentication/models/user_model.dart';
import 'package:eco_waste/features/news/controllers/news_controller.dart';
import 'package:eco_waste/features/news/screens/widgets/news_card.dart';
import 'package:eco_waste/features/personalization/screens/profile/profile.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.put(NewsController());

    return Scaffold(
      appBar: REYAppBar(
        title: Text(
          'Berita',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(
              ProfileScreen(
                username: userModel.username,
                email: userModel.email,
                desaId: userModel.desaId,
              ),
            ),
            child: Image.asset(REYImages.user, width: 40, height: 40),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.newsList.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          );
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!controller.isLoading.value &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                controller.hasMore.value) {
              controller.getNews();
            }
            return false;
          },
          child: ListView.builder(
            itemCount:
                controller.newsList.length + (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == controller.newsList.length) {
                return const Center(
                  child: CircularProgressIndicator(color: REYColors.primary),
                );
              }
              var item = controller.newsList[index];
              return NewsCard(
                imageUrl: item.imageUrl,
                title: item.title,
                source: item.sourceName,
                date: item.pubDate,
                url: item.link,
              );
            },
          ),
        );
      }),
    );
  }
}
