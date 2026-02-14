import 'package:flutter/material.dart';
import 'package:honak/features/business/directory_management/presentation/widgets/tenant_directory.dart';

/// Main management page for the directory archetype — shown in the
/// Manage tab of [BusinessShell] when the page archetype is `directory`.
///
/// Delegates all logic to [TenantDirectory].
class DirectoryManagePage extends StatelessWidget {
  const DirectoryManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TenantDirectory();
  }
}
