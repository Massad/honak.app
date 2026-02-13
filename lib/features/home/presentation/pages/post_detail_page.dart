import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/post.dart';
import 'package:honak/features/home/presentation/providers/post_detail_provider.dart';
import 'package:honak/features/home/presentation/providers/share_provider.dart';
import 'package:honak/shared/widgets/cached_image.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';

class PostDetailPage extends ConsumerWidget {
  final String postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(postDetailProvider(postId));

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Directionality(
              textDirection: TextDirection.ltr,
              child: Icon(Icons.arrow_back_ios_new, size: 20),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: postAsync.when(
        loading: () => const SingleChildScrollView(
          child: SkeletonFeedPost(count: 1),
        ),
        error: (error, _) => ErrorView(
          message: error.toString(),
          onRetry: () => ref.invalidate(postDetailProvider(postId)),
        ),
        data: (post) => _PostDetailContent(post: post),
      ),
    );
  }
}

class _PostDetailContent extends StatelessWidget {
  final Post post;

  const _PostDetailContent({required this.post});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: AppSpacing.cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PostPageHeader(page: post.page, createdAt: post.createdAt),
              SizedBox(height: AppSpacing.lg),
              if (post.content.isNotEmpty)
                Text(
                  post.content,
                  style: context.textTheme.bodyLarge,
                ),
            ],
          ),
        ),
        if (post.media.isNotEmpty) ...[
          SizedBox(height: AppSpacing.sm),
          ...post.media.map(
            (media) => Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.sm),
              child: CachedImage(
                imageUrl: media.url,
                width: double.infinity,
                height: 300,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        Padding(
          padding: AppSpacing.paddingH(AppSpacing.lg),
          child: Column(
            children: [
              SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () => ShareService().sharePost(
                      postId: post.id,
                      pageSlug: post.page.slug,
                      content: post.content,
                    ),
                    child: Icon(
                      Icons.share_outlined,
                      size: 20,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppSpacing.md),
              const Divider(height: 1),
            ],
          ),
        ),
        SizedBox(height: AppSpacing.xxl),
      ],
    );
  }
}

class _PostPageHeader extends StatelessWidget {
  final PostPage page;
  final int createdAt;

  const _PostPageHeader({required this.page, required this.createdAt});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: context.colorScheme.surfaceContainerHighest,
          backgroundImage:
              page.avatarUrl != null ? NetworkImage(page.avatarUrl!) : null,
          child: page.avatarUrl == null
              ? Text(
                  page.name.isNotEmpty ? page.name[0] : '',
                  style: context.textTheme.titleMedium,
                )
              : null,
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      page.name,
                      style: context.textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (page.isVerified) ...[
                    SizedBox(width: AppSpacing.xs),
                    Icon(
                      Icons.verified,
                      size: 16,
                      color: context.colorScheme.primary,
                    ),
                  ],
                ],
              ),
              Text(
                _timeAgo(createdAt),
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

String _timeAgo(int timestamp) {
  final now = DateTime.now();
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  final diff = now.difference(date);
  if (diff.inMinutes < 60) return '${diff.inMinutes}د';
  if (diff.inHours < 24) return '${diff.inHours}س';
  return '${diff.inDays}ي';
}
