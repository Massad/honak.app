import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:honak/features/business/page_settings/domain/entities/alert_model.dart';
import 'package:honak/features/business/page_settings/domain/entities/branch.dart';
import 'package:honak/features/business/page_settings/domain/entities/business_hours.dart';
import 'package:honak/features/business/page_settings/domain/entities/coverage_zone.dart';
import 'package:honak/features/business/page_settings/domain/entities/intake_question.dart';
import 'package:honak/features/business/page_settings/domain/entities/package_model.dart';
import 'package:honak/features/business/page_settings/domain/entities/page_settings.dart';
import 'package:honak/features/business/page_settings/domain/entities/team_member.dart';
import 'package:honak/features/business/page_settings/domain/entities/tenant.dart';

class SettingsRepository {
  Future<List<TeamMember>> getTeamMembers({String? pageType}) async {
    // Try pageType-specific fixture first, fallback to generic
    String assetPath;
    if (pageType != null) {
      assetPath = 'assets/api/settings/team_$pageType.json';
      try {
        final raw = await rootBundle.loadString(assetPath);
        final json = jsonDecode(raw) as Map<String, dynamic>;
        final list = json['data'] as List;
        return list
            .map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {
        // Fallback to generic
      }
    }
    final raw = await rootBundle.loadString('assets/api/settings/team.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = json['data'] as List;
    return list
        .map((e) => TeamMember.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<BusinessHours>> getBusinessHours() async {
    final raw = await rootBundle.loadString('assets/api/settings/hours.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;
    final list = data['schedule'] as List;
    return list
        .map((e) => BusinessHours.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<BlockedDate>> getBlockedDates() async {
    final raw = await rootBundle.loadString('assets/api/settings/hours.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;
    final list = data['blocked_dates'] as List? ?? [];
    return list
        .map((e) => BlockedDate.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Branch>> getBranches() async {
    final raw =
        await rootBundle.loadString('assets/api/settings/branches.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = json['data'] as List;
    return list
        .map((e) => Branch.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PageSettings> getPageSettings() async {
    final raw =
        await rootBundle.loadString('assets/api/settings/policies.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return PageSettings.fromJson(json['data'] as Map<String, dynamic>);
  }

  Future<Map<String, dynamic>> getPageInfo() async {
    final raw =
        await rootBundle.loadString('assets/api/settings/page_info.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return json['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getTemplates() async {
    final raw =
        await rootBundle.loadString('assets/api/settings/templates.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return json['data'] as Map<String, dynamic>;
  }

  Future<({int defaultFee, List<CoverageZone> zones})>
      getCoverageZones() async {
    final raw =
        await rootBundle.loadString('assets/api/settings/coverage.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final data = json['data'] as Map<String, dynamic>;
    final defaultFee = data['default_delivery_fee'] as int;
    final list = data['zones'] as List;
    final zones = list
        .map((e) => CoverageZone.fromJson(e as Map<String, dynamic>))
        .toList();
    return (defaultFee: defaultFee, zones: zones);
  }

  Future<List<BusinessPackage>> getPackages() async {
    final raw =
        await rootBundle.loadString('assets/api/settings/packages.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = json['data'] as List;
    return list
        .map((e) => BusinessPackage.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<IntakeQuestion>> getIntakeQuestions(
      {required String type}) async {
    final raw = await rootBundle
        .loadString('assets/api/settings/intake_questions_$type.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = json['data'] as List;
    return list
        .map((e) => IntakeQuestion.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Tenant>> getTenants() async {
    final raw =
        await rootBundle.loadString('assets/api/settings/tenants.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = json['data'] as List;
    return list
        .map((e) => Tenant.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<BusinessAlert>> getAlerts() async {
    final raw =
        await rootBundle.loadString('assets/api/settings/alerts.json');
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final list = json['data'] as List;
    return list
        .map((e) => BusinessAlert.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
