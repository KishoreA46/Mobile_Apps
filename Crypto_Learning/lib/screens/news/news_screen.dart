import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/news_service.dart';
import '../../models/news.dart';
import '../../core/theme/app_colors.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../main_navigation/main_navigation_screen.dart';

final newsServiceProvider = Provider<NewsService>((ref) => NewsService());

final newsProvider = FutureProvider<List<NewsModel>>((ref) async {
  final service = ref.watch(newsServiceProvider);
  return service.getLatestNews();
});

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  Future<void> _launchUrl(String urlString, BuildContext context) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open article link')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newsAsync = ref.watch(newsProvider);

    return Scaffold(
      backgroundColor: context.bgColor,
      appBar: AppBar(
        title: Text(
          'Crypto News',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: context.textPrimary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: context.textPrimary),
          onPressed: () => AppDrawerScope.of(
            context,
          )?.scaffoldKey.currentState?.openDrawer(),
        ),
      ),
      body: newsAsync.when(
        data: (newsList) {
          return RefreshIndicator(
            onRefresh: () => ref.refresh(newsProvider.future),
            child: ListView.separated(
              itemCount: newsList.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final article = newsList[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    article.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          article.domain,
                          style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          DateFormat(
                            'MMM dd, HH:mm',
                          ).format(article.publishedAt),
                          style: TextStyle(
                            color: context.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () => _launchUrl(article.url, context),
                );
              },
            ),
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primary),
        ),
        error: (e, s) => Center(child: Text('Error loading news: $e')),
      ),
    );
  }
}
