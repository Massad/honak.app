import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> sharePost({
    required String postId,
    required String pageSlug,
    required String content,
  }) async {
    final url = 'https://honak.app/$pageSlug/post/$postId';
    final text = content.length > 100
        ? '${content.substring(0, 100)}...\n$url'
        : '$content\n$url';
    await Share.share(text);
  }

  Future<void> sharePage({
    required String pageSlug,
    required String pageName,
  }) async {
    final url = 'https://honak.app/$pageSlug';
    await Share.share('$pageName\n$url');
  }
}
