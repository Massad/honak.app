import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/core/router/routes.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/explore/domain/entities/page_summary.dart';
import 'package:honak/features/explore/presentation/providers/explore_providers.dart';

class ExploreSearchPage extends ConsumerStatefulWidget {
  const ExploreSearchPage({super.key});

  @override
  ConsumerState<ExploreSearchPage> createState() => _ExploreSearchPageState();
}

class _ExploreSearchPageState extends ConsumerState<ExploreSearchPage> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _controller,
          autofocus: true,
          onChanged: (value) => setState(() => _query = value),
          decoration: InputDecoration(
            hintText: context.l10n.exploreSearchHint,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.md,
            ),
          ),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _controller.clear();
                setState(() => _query = '');
              },
            ),
        ],
      ),
      body: _query.isEmpty
          ? _RecentSearches(
              onTap: (term) {
                _controller.text = term;
                setState(() => _query = term);
              },
            )
          : _SearchResults(query: _query),
    );
  }
}

class _RecentSearches extends StatelessWidget {
  final ValueChanged<String> onTap;

  const _RecentSearches({required this.onTap});

  // Placeholder recent searches — in production these come from local storage
  static const _recent = ['مطاعم', 'كهربائي', 'سوبرماركت', 'مصفف شعر'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.recentSearches,
                style: context.textTheme.titleSmall,
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  context.l10n.clearAll,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        ..._recent.map(
          (term) => ListTile(
            leading: const Icon(Icons.history, size: 20),
            title: Text(term, style: context.textTheme.bodyMedium),
            dense: true,
            onTap: () => onTap(term),
          ),
        ),
      ],
    );
  }
}

class _SearchResults extends ConsumerWidget {
  final String query;

  const _SearchResults({required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagesAsync = ref.watch(searchPagesProvider(query));

    return pagesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Text(context.l10n.searchNoResults(query)),
      ),
      data: (pages) {
        if (pages.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.search_off,
                  size: 48,
                  color: context.colorScheme.outline,
                ),
                SizedBox(height: AppSpacing.md),
                Text(context.l10n.searchNoResults(query)),
              ],
            ),
          );
        }

        return DefaultTabController(
          length: 3,
          child: Column(
            children: [
              TabBar(
                tabs: [
                  Tab(text: context.l10n.all),
                  Tab(text: context.l10n.pages),
                  Tab(text: context.l10n.products),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _PageResultsList(pages: pages),
                    _PageResultsList(pages: pages),
                    // Products tab — placeholder for now
                    Center(child: Text(context.l10n.noProducts)),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PageResultsList extends StatelessWidget {
  final List<PageSummary> pages;

  const _PageResultsList({required this.pages});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      itemCount: pages.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final page = pages[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: context.colorScheme.surfaceContainerHighest,
            backgroundImage:
                page.avatarUrl != null ? NetworkImage(page.avatarUrl!) : null,
          ),
          title: Row(
            children: [
              Flexible(
                child: Text(
                  page.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (page.isVerified) ...[
                SizedBox(width: AppSpacing.xxs),
                Icon(Icons.verified, size: 16, color: context.colorScheme.primary),
              ],
            ],
          ),
          subtitle: page.businessTypeName != null
              ? Text(
                  page.businessTypeName!,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                )
              : null,
          onTap: () => context.push(Routes.pagePath(page.slug)),
        );
      },
    );
  }
}
