import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:honak/core/theme/app_colors.dart';
import 'package:honak/features/business/page_settings/presentation/widgets/sub_screen_app_bar.dart';

export 'availability_tabs.dart';
export 'blocked_dates_tab.dart';

import 'availability_tabs.dart';
import 'blocked_dates_tab.dart';

class AvailabilityManager extends ConsumerStatefulWidget {
  final VoidCallback onClose;

  const AvailabilityManager({
    super.key,
    required this.onClose,
  });

  @override
  ConsumerState<AvailabilityManager> createState() =>
      _AvailabilityManagerState();
}

class _AvailabilityManagerState
    extends ConsumerState<AvailabilityManager>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubScreenAppBar(
          title: 'الجدول والمواعيد',
          onClose: widget.onClose,
        ),
        // Inner tabs
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey.shade400,
            indicatorColor: AppColors.primary,
            labelStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 12,
            ),
            tabs: const [
              Tab(text: 'الجدول'),
              Tab(text: 'أيام محظورة'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              ScheduleTab(),
              BlockedDatesTab(),
            ],
          ),
        ),
      ],
    );
  }
}
