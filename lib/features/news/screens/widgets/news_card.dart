import 'package:cached_network_image/cached_network_image.dart';
import 'package:eco_waste/features/news/screens/widgets/news_open.dart';
import 'package:eco_waste/utils/constants/colors.dart';
import 'package:eco_waste/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.url,
    required this.imageUrl,
    required this.title,
    required this.source,
    required this.date,
  });

  final String url, imageUrl, title, source, date;

  String _formatDate(String date) {
    if (date.isEmpty) return '-';
    try {
      final DateTime dateTime = DateTime.parse(date);
      return DateFormat('dd MMMM yyyy').format(dateTime);
    } catch (_) {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: url.isNotEmpty ? () => Get.to(() => NewsOpen(url: url)) : null,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: REYSizes.md,
              vertical: REYSizes.sm,
            ),
            child: Column(
              children: [
                if (imageUrl.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(REYSizes.sm),
                      color: Colors.white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      cacheManager: CacheManager(
                        Config(
                          'customCacheKey',
                          stalePeriod: const Duration(days: 7),
                          maxNrOfCacheObjects: 100,
                        ),
                      ),
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: REYColors.primary,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                if (imageUrl.isEmpty)
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(REYSizes.sm),
                      color: Colors.grey[200],
                    ),
                    child: const Center(child: Icon(Icons.image_not_supported)),
                  ),
                const SizedBox(height: REYSizes.sm * 1.5),
                Text(
                  title.isNotEmpty ? title : '-',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: REYSizes.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      source.isNotEmpty ? source : '-',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      _formatDate(date),
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
