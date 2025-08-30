import 'package:eco_waste/common/widgets/appbar.dart';
import 'package:eco_waste/features/news/controllers/news_controller.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class NewsOpen extends StatelessWidget {
  const NewsOpen({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    final NewsController newsController = Get.find<NewsController>();
    newsController.initializeWebViewController(url);

    return Scaffold(
      appBar: const REYAppBar(title: Text('Berita'), showBackArrow: true),
      body: Obx(() {
        if (newsController.isWebViewLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: REYColors.primary),
          );
        } else {
          return WebViewWidget(controller: newsController.webViewController!);
        }
      }),
    );
  }
}
