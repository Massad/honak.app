import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/home/domain/entities/feed_item.dart';
import 'package:honak/features/home/presentation/providers/feed_provider.dart';
import 'package:honak/features/home/presentation/widgets/guest_welcome_banner.dart';
import 'package:honak/features/home/presentation/widgets/nearby_pages_card.dart';
import 'package:honak/features/home/presentation/widgets/post_card.dart';
import 'package:honak/features/home/presentation/widgets/promo_banner_carousel.dart';
import 'package:honak/features/home/presentation/widgets/quick_categories.dart';
import 'package:honak/features/home/presentation/widgets/reorder_section.dart';
import 'package:honak/features/home/presentation/widgets/stories_bar.dart';
import 'package:honak/features/stories/presentation/providers/stories_provider.dart'
    show storyContentProvider;
import 'package:honak/features/stories/presentation/utils/story_launcher.dart';
import 'package:honak/shared/auth/auth_state.dart';
import 'package:honak/shared/auth/auth_provider.dart';
import 'package:honak/shared/widgets/empty_state.dart';
import 'package:honak/shared/widgets/error_view.dart';
import 'package:honak/shared/widgets/app_screen.dart';
import 'package:honak/shared/widgets/skeleton/skeleton.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedAsync = ref.watch(feedItemsProvider);
    final storiesAsync = ref.watch(storiesProvider);
    // Pre-load viewer content so it's ready on first tap
    ref.watch(storyContentProvider);
    final authState = ref.watch(authProvider).valueOrNull;
    final isGuest = authState is AuthGuest;

    return AppScreen(
      title: SvgPicture.asset(
        Theme.of(context).brightness == Brightness.dark
            ? 'assets/icons/icon_dark.svg'
            : 'assets/icons/icon_light.svg',
        height: 28,
      ),
      showBack: false,
      actions: [
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () => context.push(Routes.notifications),
            ),
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.colorScheme.surface,
                    width: 1,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(feedPostsProvider);
          ref.invalidate(storiesProvider);
          ref.invalidate(suggestedPagesProvider);
          ref.invalidate(nearbyPagesProvider);
          ref.invalidate(feedItemsProvider);
          ref.invalidate(reorderableRequestsProvider);
        },
        child: feedAsync.when(
          loading: () => const _FeedSkeleton(),
          error: (error, _) => ErrorView(
            message: error.toString(),
            onRetry: () {
              ref.invalidate(feedItemsProvider);
              ref.invalidate(storiesProvider);
            },
          ),
          data: (items) {
            if (items.isEmpty) {
              return EmptyState(
                icon: Icons.dynamic_feed_outlined,
                title: context.l10n.feedEmpty,
                subtitle: context.l10n.feedEmptySubtitle,
              );
            }

            // Separate posts from nearby section
            final posts = <FeedPost>[];
            List<FeedNearYou>? nearbySection;
            for (final item in items) {
              if (item is FeedPost) {
                posts.add(item);
              } else if (item is FeedNearYou) {
                nearbySection = [item];
              }
            }

            return CustomScrollView(
              slivers: [
                // 1. Stories bar
                SliverToBoxAdapter(
                  child: storiesAsync.when(
                    loading: () => const SizedBox.shrink(),
                    error: (_, __) => const SizedBox.shrink(),
                    data: (stories) => stories.isEmpty
                        ? const SizedBox.shrink()
                        : Column(
                            children: [
                              StoriesBar(
                                stories: stories,
                                onStoryTap: (index) =>
                                    openStoryViewer(context, ref, index: index),
                              ),
                              SizedBox(height: AppSpacing.md),
                            ],
                          ),
                  ),
                ),

                // 2. Guest welcome banner (only if guest)
                if (isGuest)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const GuestWelcomeBanner(),
                        SizedBox(height: AppSpacing.md),
                      ],
                    ),
                  ),

                // 2b. Reorder section (authenticated users only)
                if (!isGuest)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const ReorderSection(),
                        SizedBox(height: AppSpacing.md),
                      ],
                    ),
                  ),

                // 3. Quick categories
                const SliverToBoxAdapter(child: QuickCategories()),

                // 4. Promo banner carousel
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      SizedBox(height: AppSpacing.md),
                      const PromoBannerCarousel(),
                      SizedBox(height: AppSpacing.md),
                    ],
                  ),
                ),

                // 5. First batch of posts (0-2)
                if (posts.isNotEmpty)
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final post = posts[index].post;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Column(
                          children: [
                            PostCard(
                              post: post,
                              onPageTap: () =>
                                  context.push(Routes.pagePath(post.page.slug)),
                              onPostTap: () =>
                                  context.push(Routes.postPath(post.id)),
                              onProductTap: post.metadata?['item_id'] != null
                                  ? () => context.push(
                                      Routes.productPath(
                                        post.metadata!['item_id'] as String,
                                      ),
                                    )
                                  : null,
                            ),
                            SizedBox(height: AppSpacing.md),
                          ],
                        ),
                      );
                    }, childCount: posts.length < 3 ? posts.length : 3),
                  ),

                // 6. Nearby pages card (if exists)
                if (nearbySection != null && nearbySection.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        NearbyPagesCard(pages: nearbySection.first.pages),
                        SizedBox(height: AppSpacing.md),
                      ],
                    ),
                  ),

                // 7. Remaining posts (3+)
                if (posts.length > 3)
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final post = posts[index + 3].post;
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                        ),
                        child: Column(
                          children: [
                            PostCard(
                              post: post,
                              onPageTap: () =>
                                  context.push(Routes.pagePath(post.page.slug)),
                              onPostTap: () =>
                                  context.push(Routes.postPath(post.id)),
                              onProductTap: post.metadata?['item_id'] != null
                                  ? () => context.push(
                                      Routes.productPath(
                                        post.metadata!['item_id'] as String,
                                      ),
                                    )
                                  : null,
                            ),
                            SizedBox(height: AppSpacing.md),
                          ],
                        ),
                      );
                    }, childCount: posts.length - 3),
                  ),

                // Bottom padding
                SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FeedSkeleton extends StatelessWidget {
  const _FeedSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(child: SkeletonFeedPost(count: 4));
  }
}
