import 'package:flutter/material.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:flutter/services.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
import 'package:honak/shared/widgets/app_direction.dart';
import 'package:honak/shared/widgets/app_image.dart';

// ── Constants ────────────────────────────────────────────────

const _primary = Color(0xFF1A73E8);
const _green = Color(0xFF43A047);

const _stepLabels = ['مقدمة', 'بياناتك', 'التحقق', 'مراجعة'];

const _roles = [
  (id: 'owner', label: 'صاحب النشاط', desc: 'أنا المالك الفعلي لهذا النشاط التجاري', icon: Icons.storefront),
  (id: 'manager', label: 'مدير', desc: 'أدير هذا النشاط بتفويض من المالك', icon: Icons.work_outline),
  (id: 'representative', label: 'ممثل مفوّض', desc: 'لدي تفويض رسمي لإدارة الصفحة', icon: Icons.person_outline),
];

const _verificationMethods = [
  (id: 'in_person', label: 'زيارة ميدانية', desc: 'فريقنا يزوركم بالمحل — نتحقق ونساعدكم تفعّلوا الصفحة', icon: Icons.directions_car_outlined, recommended: true),
  (id: 'document', label: 'مستند رسمي', desc: 'ارفع سجل تجاري، رخصة مهن، عقد إيجار، أو تفويض', icon: Icons.description_outlined, recommended: false),
  (id: 'video_call', label: 'مكالمة فيديو', desc: 'مكالمة قصيرة من المحل — نتحقق من الموقع مباشرة', icon: Icons.videocam_outlined, recommended: false),
];

const _documentTypes = [
  (id: 'commercial_reg', label: 'سجل تجاري', desc: 'صادر من وزارة الصناعة والتجارة', icon: Icons.description_outlined),
  (id: 'profession_license', label: 'رخصة مهن', desc: 'صادرة من البلدية أو الأمانة', icon: Icons.verified_outlined),
  (id: 'lease_agreement', label: 'عقد إيجار المحل', desc: 'عقد إيجار ساري المفعول باسمك', icon: Icons.apartment_outlined),
  (id: 'authorization_letter', label: 'تفويض رسمي', desc: 'رسالة تفويض من الملك أو الشركة الأم', icon: Icons.description_outlined),
];

const _visitTimes = [
  (id: 'morning', label: 'صباحاً (٩ - ٢)', desc: 'أيام الأحد - الخميس'),
  (id: 'afternoon', label: 'بعد الظهر (٢ - ٤)', desc: 'أيام الأحد - الخميس'),
  (id: 'evening', label: 'مساءً (٤ - ٨)', desc: 'كل يوم'),
  (id: 'weekend', label: 'الجمعة أو السبت', desc: 'نهاية الأسبوع'),
];

/// Full-screen 4-step claim wizard matching Figma's ClaimRequestFlow.
class ClaimRequestPage extends StatefulWidget {
  final PageDetail page;

  const ClaimRequestPage({super.key, required this.page});

  @override
  State<ClaimRequestPage> createState() => _ClaimRequestPageState();
}

class _ClaimRequestPageState extends State<ClaimRequestPage> {
  // Step: 1-4 or 0 for 'done'
  int _step = 1;

  // Form fields
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  String _selectedRole = '';
  bool _otpSent = false;
  String _otpCode = '';
  bool _otpVerified = false;
  int _otpTimer = 0;
  String _verificationMethod = '';
  String _selectedDocType = '';
  bool _documentUploaded = false;
  bool _gpsCapturing = false;
  bool _gpsCaptured = false;
  String _preferredVisitTime = '';
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _startOtpTimer() {
    setState(() {
      _otpTimer = 59;
      _otpSent = true;
      _otpCode = '';
      _otpVerified = false;
    });
    _tickTimer();
  }

  void _tickTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted || _otpTimer <= 0) return;
      setState(() => _otpTimer--);
      if (_otpTimer > 0) _tickTimer();
    });
  }

  bool get _canProceed => switch (_step) {
        1 => true,
        2 => _nameController.text.length >= 2 && _otpVerified && _selectedRole.isNotEmpty,
        3 => _verificationMethodValid,
        4 => _agreedToTerms,
        _ => false,
      };

  bool get _verificationMethodValid {
    if (_verificationMethod.isEmpty) return false;
    if (_verificationMethod == 'document') return _selectedDocType.isNotEmpty && _documentUploaded;
    if (_verificationMethod == 'in_person') return _preferredVisitTime.isNotEmpty;
    if (_verificationMethod == 'video_call') return true;
    return false;
  }

  void _handleNext() {
    if (_step == 4) {
      setState(() => _step = 0); // done
    } else {
      setState(() => _step++);
    }
  }

  void _handleBack() {
    if (_step == 1) {
      Navigator.pop(context);
    } else if (_step > 1) {
      setState(() => _step--);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_step == 0) return _buildDoneScreen(context);
    return _buildStepScreen(context);
  }

  // ── Step Screen ─────────────────────────────────────────────

  Widget _buildStepScreen(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),
            // Content
            Expanded(
              child: SingleChildScrollView(
                child: switch (_step) {
                  1 => _StepIntro(page: widget.page),
                  2 => _StepInfo(
                      nameController: _nameController,
                      phoneController: _phoneController,
                      selectedRole: _selectedRole,
                      otpSent: _otpSent,
                      otpCode: _otpCode,
                      otpVerified: _otpVerified,
                      otpTimer: _otpTimer,
                      onRoleSelected: (r) => setState(() => _selectedRole = r),
                      onSendOtp: () {
                        if (_phoneController.text.length < 9) return;
                        _startOtpTimer();
                      },
                      onOtpChanged: (code) => setState(() => _otpCode = code),
                      onVerifyOtp: () {
                        if (_otpCode.length == 6) {
                          setState(() => _otpVerified = true);
                        }
                      },
                      onPhoneChanged: () {
                        if (_otpVerified) {
                          setState(() {
                            _otpVerified = false;
                            _otpSent = false;
                            _otpCode = '';
                          });
                        }
                      },
                    ),
                  3 => _StepVerify(
                      verificationMethod: _verificationMethod,
                      selectedDocType: _selectedDocType,
                      documentUploaded: _documentUploaded,
                      gpsCapturing: _gpsCapturing,
                      gpsCaptured: _gpsCaptured,
                      preferredVisitTime: _preferredVisitTime,
                      notes: _notesController,
                      onMethodSelected: (m) => setState(() {
                        _verificationMethod = m;
                        if (m != 'document') {
                          _selectedDocType = '';
                          _documentUploaded = false;
                        }
                      }),
                      onDocTypeSelected: (d) => setState(() {
                        _selectedDocType = d;
                        _documentUploaded = false;
                      }),
                      onDocumentUploaded: (v) => setState(() => _documentUploaded = v),
                      onCaptureGps: () {
                        setState(() => _gpsCapturing = true);
                        Future.delayed(const Duration(milliseconds: 1500), () {
                          if (mounted) {
                            setState(() {
                              _gpsCapturing = false;
                              _gpsCaptured = true;
                            });
                          }
                        });
                      },
                      onVisitTimeSelected: (t) => setState(() => _preferredVisitTime = t),
                    ),
                  4 => _StepReview(
                      page: widget.page,
                      fullName: _nameController.text,
                      phone: _phoneController.text,
                      selectedRole: _selectedRole,
                      verificationMethod: _verificationMethod,
                      selectedDocType: _selectedDocType,
                      gpsCaptured: _gpsCaptured,
                      preferredVisitTime: _preferredVisitTime,
                      notes: _notesController.text,
                      agreedToTerms: _agreedToTerms,
                      onAgreedChanged: (v) => setState(() => _agreedToTerms = v),
                      onEditInfo: () => setState(() => _step = 2),
                      onEditVerify: () => setState(() => _step = 3),
                    ),
                  _ => const SizedBox.shrink(),
                },
              ),
            ),
            // Bottom action
            _buildBottomAction(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(bottom: BorderSide(color: context.colorScheme.outlineVariant)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Title row (LTR: back on left, title center)
          Row(
            textDirection: Directionality.of(context),
            children: [
              GestureDetector(
                onTap: _handleBack,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    AppDirection.backIcon(context),
                    size: 20,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  'إثبات ملكية',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface),
                ),
              ),
              const SizedBox(width: 28), // balance
            ],
          ),
          // Progress bar
          const SizedBox(height: 12),
          Row(
            children: List.generate(4, (i) {
              final stepNum = i + 1;
              final isActive = stepNum <= _step;
              final isCurrent = stepNum == _step;
              return Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: i == 0 ? 0 : 3,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: isActive ? _primary : context.colorScheme.surfaceContainer,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _stepLabels[i],
                        style: TextStyle(
                          fontSize: 9,
                          color: isCurrent ? _primary : context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border(top: BorderSide(color: context.colorScheme.outlineVariant)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: _canProceed ? _primary : context.colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: _canProceed ? _handleNext : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_step == 4) ...[
                    Icon(Icons.shield_outlined, size: 16, color: _canProceed ? Colors.white : context.colorScheme.onSurfaceVariant),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    _step == 4
                        ? 'إرسال طلب إثبات الملكية'
                        : _step == 1
                            ? 'ابدأ عملية الإثبات'
                            : 'التالي',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _canProceed ? Colors.white : context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (_step > 1 && _step < 4) ...[
                    const SizedBox(width: 4),
                    Icon(
                      AppDirection.forwardIcon(context),
                      size: 16,
                      color: _canProceed
                          ? Colors.white
                          : context.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ── Done Screen ────────────────────────────────────────────

  Widget _buildDoneScreen(BuildContext context) {
    final isInPerson = _verificationMethod == 'in_person';
    return Scaffold(
      backgroundColor: context.colorScheme.surface,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Green checkmark
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.shade50,
                    border: Border.all(color: Colors.green.shade200, width: 2),
                  ),
                  child: const Icon(Icons.check_circle, size: 40, color: _green),
                ),
                const SizedBox(height: 20),

                Text(
                  'تم إرسال طلبك بنجاح',
                  style: TextStyle(fontSize: 20, color: context.colorScheme.onSurface),
                ),
                const SizedBox(height: 8),
                Text(
                  isInPerson
                      ? 'سنتواصل معك لتأكيد موعد الزيارة.\nفريقنا سيساعدك بتفعيل الصفحة بالكامل.'
                      : 'سيراجع فريق هناك.app طلبك خلال ٢٤ ساعة.\nسنتواصل معك عبر الرقم المسجل.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.colorScheme.onSurfaceVariant,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),

                // What happens next
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 340),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLowest,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.colorScheme.outlineVariant),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ماذا بعد؟',
                        style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant),
                      ),
                      const SizedBox(height: 12),
                      ...(isInPerson
                          ? [
                              _nextStep('٢', 'فريقنا يزورك بالمحل ويتحقق'),
                              const SizedBox(height: 12),
                              _nextStep('٣', 'نفعّل الصفحة ونساعدك تعبّيها'),
                            ]
                          : [
                              _nextStep('٢', 'قد نتواصل معك للتحقق من بيانات إضافية'),
                              const SizedBox(height: 12),
                              _nextStep('٣', 'بعد الموافقة، ستتحكم بالصفحة بالكامل'),
                            ]),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Page being claimed
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 340),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF6FF),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFDBEAFE)),
                  ),
                  child: Row(
                    children: [
                      // Avatar
                      AppImage(
                        url: widget.page.avatarUrl,
                        width: 40,
                        height: 40,
                        borderRadius: BorderRadius.circular(12),
                        placeholderIcon: Icons.storefront,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.page.name,
                              style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '@${widget.page.handle ?? widget.page.slug}',
                              style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'قيد المراجعة',
                          style: TextStyle(fontSize: 10, color: Colors.amber.shade800),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Back button
                SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: _primary,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.pop(context),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        child: Text(
                          'العودة للصفحة',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nextStep(String num, String text) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _primary.withValues(alpha: 0.1),
          ),
          child: Center(
            child: Text(num, style: const TextStyle(fontSize: 12, color: _primary)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// STEP 1: Introduction
// ════════════════════════════════════════════════════════════════

class _StepIntro extends StatelessWidget {
  final PageDetail page;
  const _StepIntro({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page being claimed
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFDBEAFE)),
            ),
            child: Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: context.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 4),
                    ],
                  ),
                  child: AppImage(
                    url: page.avatarUrl,
                    width: 56,
                    height: 56,
                    borderRadius: BorderRadius.circular(12),
                    placeholderIcon: Icons.storefront,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        page.name,
                        style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '@${page.handle ?? page.slug}',
                        style: TextStyle(fontSize: 11, color: context.colorScheme.onSurfaceVariant),
                      ),
                      if (page.location?.label != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 10, color: context.colorScheme.onSurfaceVariant),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                page.location!.label!,
                                style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'إثبات ملكية هذه الصفحة',
            style: TextStyle(fontSize: 18, color: context.colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          Text(
            'تم إنشاء هذه الصفحة تلقائياً من بيانات عامة.\nإذا كنت صاحب هذا النشاط أو مفوّضاً بإدارته،\nيمكنك إثبات ملكيتك للتحكم الكامل بالصفحة.',
            style: TextStyle(fontSize: 14, color: context.colorScheme.onSurfaceVariant, height: 1.6),
          ),
          const SizedBox(height: 24),

          // What you get
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: context.colorScheme.surfaceContainerLowest,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    border: Border(bottom: BorderSide(color: context.colorScheme.outlineVariant)),
                  ),
                  child: Text(
                    'بعد إثبات الملكية ستتمكن من:',
                    style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _benefitRow(context, Icons.storefront, 'إدارة معلومات الصفحة وتحديثها'),
                      const SizedBox(height: 12),
                      _benefitRow(context, Icons.description_outlined, 'إضافة منتجاتك أو خدماتك أو قائمتك'),
                      const SizedBox(height: 12),
                      _benefitRow(context, Icons.shield_outlined, 'تفعيل استقبال الطلبات عبر هناك.app'),
                      const SizedBox(height: 12),
                      _benefitRow(context, Icons.person_outline, 'إدارة فريق العمل والصلاحيات'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // In-person visit highlight
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade100),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.directions_car_outlined, size: 16, color: _green),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'نجي نزورك!',
                        style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'فريقنا بزور المحلات لمساعدة أصحابها بتفعيل صفحاتهم.\nبنتحقق منك شخصياً وبنساعدك تعبّي كل شي.',
                        style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Process
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade50,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.amber.shade100),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.amber.shade700),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'العملية بسيطة ومجانية',
                        style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'بياناتك + تحقق من الرقم + إثبات بسيط = صفحتك جاهزة.',
                        style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _benefitRow(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: _primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: _primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(text, style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
        ),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// STEP 2: Personal Info + Phone OTP
// ════════════════════════════════════════════════════════════════

class _StepInfo extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final String selectedRole;
  final bool otpSent;
  final String otpCode;
  final bool otpVerified;
  final int otpTimer;
  final ValueChanged<String> onRoleSelected;
  final VoidCallback onSendOtp;
  final ValueChanged<String> onOtpChanged;
  final VoidCallback onVerifyOtp;
  final VoidCallback onPhoneChanged;

  const _StepInfo({
    required this.nameController,
    required this.phoneController,
    required this.selectedRole,
    required this.otpSent,
    required this.otpCode,
    required this.otpVerified,
    required this.otpTimer,
    required this.onRoleSelected,
    required this.onSendOtp,
    required this.onOtpChanged,
    required this.onVerifyOtp,
    required this.onPhoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('بياناتك الشخصية', style: TextStyle(fontSize: 18, color: context.colorScheme.onSurface)),
          const SizedBox(height: 4),
          Text('حدّثنا عنك وعن علاقتك بهذا النشاط', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 24),

          // Full Name
          Text('الاسم الكامل', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
          const SizedBox(height: 8),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'كما هو في الهوية الشخصية',
              hintStyle: TextStyle(color: context.colorScheme.onSurfaceVariant, fontSize: 14),
              prefixIcon: Icon(Icons.person_outline, size: 16, color: context.colorScheme.onSurfaceVariant),
              filled: true,
              fillColor: context.colorScheme.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: context.colorScheme.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: context.colorScheme.outlineVariant),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _primary),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface),
          ),
          const SizedBox(height: 20),

          // Phone
          Text('رقم الهاتف', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
          const SizedBox(height: 8),
          Directionality(
            textDirection: Directionality.of(context),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    enabled: !otpVerified,
                    onChanged: (_) => onPhoneChanged(),
                    decoration: InputDecoration(
                      hintText: '07XXXXXXXX',
                      hintStyle: TextStyle(color: context.colorScheme.onSurfaceVariant, fontSize: 14),
                      prefixIcon: Icon(Icons.phone_outlined, size: 16, color: context.colorScheme.onSurfaceVariant),
                      filled: true,
                      fillColor: context.colorScheme.surfaceContainerLowest,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: _primary),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                  ),
                ),
                const SizedBox(width: 8),
                if (!otpVerified)
                  Material(
                    color: _primary,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: phoneController.text.length >= 9 && (!otpSent || otpTimer == 0) ? onSendOtp : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        child: Text(
                          otpSent && otpTimer > 0
                              ? '$otpTimerث'
                              : otpSent
                                  ? 'إعادة'
                                  : 'أرسل رمز',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: phoneController.text.length >= 9 ? 1.0 : 0.4),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (otpVerified)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, size: 16, color: _green),
                        const SizedBox(width: 4),
                        Text('تم', style: TextStyle(fontSize: 12, color: _green)),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // OTP input
          if (otpSent && !otpVerified) ...[
            const SizedBox(height: 12),
            Directionality(
              textDirection: Directionality.of(context),
              child: Text(
                'أدخل الرمز المرسل إلى ${phoneController.text}',
                style: TextStyle(fontSize: 11, color: context.colorScheme.onSurfaceVariant),
              ),
            ),
            const SizedBox(height: 8),
            Directionality(
              textDirection: Directionality.of(context),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: onOtpChanged,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '------',
                        hintStyle: TextStyle(color: context.colorScheme.onSurfaceVariant, fontSize: 14, letterSpacing: 8),
                        filled: true,
                        fillColor: context.colorScheme.surfaceContainerLowest,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: context.colorScheme.outlineVariant),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: _primary),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      style: TextStyle(fontSize: 14, letterSpacing: 8, color: context.colorScheme.onSurface),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(6)],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Material(
                    color: _green,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: otpCode.length >= 6 ? onVerifyOtp : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        child: Text(
                          'تحقق',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: otpCode.length >= 6 ? 1.0 : 0.4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
            Directionality(
              textDirection: Directionality.of(context),
              child: Text(
                'في النسخة التجريبية: أي ٦ أرقام مقبولة',
                style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
              ),
            ),
          ],

          if (otpVerified) ...[
            const SizedBox(height: 6),
            const Row(
              children: [
                Icon(Icons.check_circle, size: 10, color: _green),
                SizedBox(width: 4),
                Text('تم التحقق من الرقم بنجاح', style: TextStyle(fontSize: 10, color: _green)),
              ],
            ),
          ],
          const SizedBox(height: 24),

          // Role Selection
          Text('علاقتك بالنشاط', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
          const SizedBox(height: 8),
          ...List.generate(_roles.length, (i) {
            final role = _roles[i];
            final isSelected = selectedRole == role.id;
            return Padding(
              padding: EdgeInsets.only(bottom: i < _roles.length - 1 ? 8 : 0),
              child: _SelectableCard(
                icon: role.icon,
                label: role.label,
                description: role.desc,
                isSelected: isSelected,
                onTap: () => onRoleSelected(role.id),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// STEP 3: Verification Method
// ════════════════════════════════════════════════════════════════

class _StepVerify extends StatelessWidget {
  final String verificationMethod;
  final String selectedDocType;
  final bool documentUploaded;
  final bool gpsCapturing;
  final bool gpsCaptured;
  final String preferredVisitTime;
  final TextEditingController notes;
  final ValueChanged<String> onMethodSelected;
  final ValueChanged<String> onDocTypeSelected;
  final ValueChanged<bool> onDocumentUploaded;
  final VoidCallback onCaptureGps;
  final ValueChanged<String> onVisitTimeSelected;

  const _StepVerify({
    required this.verificationMethod,
    required this.selectedDocType,
    required this.documentUploaded,
    required this.gpsCapturing,
    required this.gpsCaptured,
    required this.preferredVisitTime,
    required this.notes,
    required this.onMethodSelected,
    required this.onDocTypeSelected,
    required this.onDocumentUploaded,
    required this.onCaptureGps,
    required this.onVisitTimeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('إثبات الملكية', style: TextStyle(fontSize: 18, color: context.colorScheme.onSurface)),
          const SizedBox(height: 4),
          Text('اختر طريقة التحقق المناسبة لك', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 20),

          // GPS capture
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFDBEAFE)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.navigation_outlined, size: 18, color: _primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('تحديد الموقع', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
                      const SizedBox(height: 4),
                      Text(
                        'شارك موقعك الحالي لنتأكد إنك بالمحل. هالخطوة إلزامية لجميع الأنشطة.',
                        style: TextStyle(fontSize: 11, color: context.colorScheme.onSurfaceVariant, height: 1.5),
                      ),
                      const SizedBox(height: 12),
                      if (!gpsCaptured)
                        Material(
                          color: _primary,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: gpsCapturing ? null : onCaptureGps,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (gpsCapturing)
                                    const SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  else
                                    const Icon(Icons.location_on, size: 12, color: Colors.white),
                                  const SizedBox(width: 6),
                                  Text(
                                    gpsCapturing ? 'جاري التحديد...' : 'شارك موقعك',
                                    style: const TextStyle(fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      else
                        const Row(
                          children: [
                            Icon(Icons.check_circle, size: 14, color: _green),
                            SizedBox(width: 6),
                            Text(
                              'تم تحديد موقعك — على بعد ٥٠م من العنوان المسجّل',
                              style: TextStyle(fontSize: 12, color: _green),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Verification method selection
          Text('اختر طريقة التحقق', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
          const SizedBox(height: 12),
          ...List.generate(_verificationMethods.length, (i) {
            final method = _verificationMethods[i];
            final isSelected = verificationMethod == method.id;
            return Padding(
              padding: EdgeInsets.only(bottom: i < _verificationMethods.length - 1 ? 8 : 0),
              child: _SelectableCard(
                icon: method.icon,
                label: method.label,
                description: method.desc,
                isSelected: isSelected,
                badge: method.recommended ? 'ننصح فيها' : null,
                onTap: () => onMethodSelected(method.id),
              ),
            );
          }),
          const SizedBox(height: 20),

          // In-Person Visit Details
          if (verificationMethod == 'in_person') ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('متى نزوركم؟', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
                  const SizedBox(height: 12),
                  ..._visitTimes.map((time) {
                    final isSelected = preferredVisitTime == time.id;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Material(
                        color: isSelected ? Colors.green.shade100.withValues(alpha: 0.5) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () => onVisitTimeSelected(time.id),
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? _green : Colors.green.shade200,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(time.label, style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
                                      Text(time.desc, style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant)),
                                    ],
                                  ),
                                ),
                                if (isSelected) const Icon(Icons.check_circle, size: 16, color: _green),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                  Text(
                    'سنتصل بك قبل الزيارة لتأكيد الموعد بالضبط',
                    style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],

          // Document Upload
          if (verificationMethod == 'document') ...[
            Text('اختر نوع المستند', style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            ...List.generate(_documentTypes.length, (i) {
              final doc = _documentTypes[i];
              final isSelected = selectedDocType == doc.id;
              return Padding(
                padding: EdgeInsets.only(bottom: i < _documentTypes.length - 1 ? 8 : 0),
                child: _SelectableCard(
                  icon: doc.icon,
                  label: doc.label,
                  description: doc.desc,
                  isSelected: isSelected,
                  compact: true,
                  onTap: () => onDocTypeSelected(doc.id),
                ),
              );
            }),
            if (selectedDocType.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'رفع ${_documentTypes.firstWhere((d) => d.id == selectedDocType).label}',
                style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface),
              ),
              const SizedBox(height: 8),
              if (!documentUploaded)
                GestureDetector(
                  onTap: () => onDocumentUploaded(true),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: context.colorScheme.outline, width: 2),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colorScheme.surfaceContainerLow,
                          ),
                          child: Icon(Icons.upload_outlined, size: 18, color: context.colorScheme.onSurfaceVariant),
                        ),
                        const SizedBox(height: 8),
                        Text('اضغط لرفع صورة أو مستند', style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant)),
                        const SizedBox(height: 4),
                        Text('JPG, PNG, PDF — حتى ١٠ ميغابايت', style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.check_circle, size: 20, color: _green),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _documentTypes.firstWhere((d) => d.id == selectedDocType).label,
                              style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface),
                            ),
                            Text('تم الرفع بنجاح', style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onDocumentUploaded(false),
                        child: Icon(Icons.close, size: 16, color: context.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
            ],
          ],

          // Video Call Info
          if (verificationMethod == 'video_call')
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.purple.shade100),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.videocam_outlined, size: 18, color: Colors.purple.shade600),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('مكالمة فيديو قصيرة', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
                        SizedBox(height: 4),
                        Text(
                          'سنتصل بك مكالمة فيديو وأنت بالمحل. نشوف المكان ونتحقق\nمن هويتك — مدة المكالمة ٢-٣ دقائق فقط.',
                          style: TextStyle(fontSize: 11, color: context.colorScheme.onSurfaceVariant, height: 1.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'سنتواصل معك لتحديد الموعد بعد إرسال الطلب',
                          style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Notes
          const SizedBox(height: 20),
          Row(
            children: [
              Text('ملاحظات إضافية', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
              const SizedBox(width: 4),
              Text('(اختياري)', style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: notes,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'أي معلومات تساعدنا...',
              hintStyle: TextStyle(color: context.colorScheme.onSurfaceVariant, fontSize: 14),
              filled: true,
              fillColor: context.colorScheme.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: context.colorScheme.outlineVariant),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: context.colorScheme.outlineVariant),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _primary),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
            style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════════
// STEP 4: Review & Submit
// ════════════════════════════════════════════════════════════════

class _StepReview extends StatelessWidget {
  final PageDetail page;
  final String fullName;
  final String phone;
  final String selectedRole;
  final String verificationMethod;
  final String selectedDocType;
  final bool gpsCaptured;
  final String preferredVisitTime;
  final String notes;
  final bool agreedToTerms;
  final ValueChanged<bool> onAgreedChanged;
  final VoidCallback onEditInfo;
  final VoidCallback onEditVerify;

  const _StepReview({
    required this.page,
    required this.fullName,
    required this.phone,
    required this.selectedRole,
    required this.verificationMethod,
    required this.selectedDocType,
    required this.gpsCaptured,
    required this.preferredVisitTime,
    required this.notes,
    required this.agreedToTerms,
    required this.onAgreedChanged,
    required this.onEditInfo,
    required this.onEditVerify,
  });

  String get _roleName => _roles.where((r) => r.id == selectedRole).firstOrNull?.label ?? '';
  String get _methodName => _verificationMethods.where((m) => m.id == verificationMethod).firstOrNull?.label ?? '';
  String get _docName => _documentTypes.where((d) => d.id == selectedDocType).firstOrNull?.label ?? '';
  String get _visitTimeName => switch (preferredVisitTime) {
        'morning' => 'صباحاً',
        'afternoon' => 'بعد الظهر',
        'evening' => 'مساءً',
        'weekend' => 'نهاية الأسبوع',
        _ => '',
      };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 96),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('مراجعة وإرسال', style: TextStyle(fontSize: 18, color: context.colorScheme.onSurface)),
          const SizedBox(height: 4),
          Text('تأكد من صحة البيانات قبل الإرسال', style: TextStyle(fontSize: 14, color: context.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 20),

          // Summary card
          Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colorScheme.outlineVariant),
            ),
            child: Column(
              children: [
                // Page
                _reviewSection(context, 
                  'الصفحة المطلوبة',
                  hasBorder: true,
                  child: Row(
                    children: [
                      AppImage(
                        url: page.avatarUrl,
                        width: 40,
                        height: 40,
                        borderRadius: BorderRadius.circular(12),
                        placeholderIcon: Icons.storefront,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(page.name, style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
                            Text('@${page.handle ?? page.slug}', style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Personal info
                _reviewSection(context, 
                  'بياناتك',
                  hasBorder: true,
                  child: Column(
                    children: [
                      _reviewRow(context, 'الاسم', fullName),
                      const SizedBox(height: 6),
                      _reviewRow(context, 'الهاتف', phone, trailing: const Icon(Icons.check_circle, size: 10, color: _green)),
                      const SizedBox(height: 6),
                      _reviewRow(context, 'الصفة', _roleName),
                    ],
                  ),
                ),

                // Verification
                _reviewSection(context, 
                  'التحقق',
                  child: Column(
                    children: [
                      _reviewRow(context, 
                        'الموقع (GPS)',
                        gpsCaptured ? 'تم التحديد' : 'لم يُحدد',
                        trailing: gpsCaptured ? const Icon(Icons.check_circle, size: 12, color: _green) : null,
                        valueColor: gpsCaptured ? _green : context.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(height: 6),
                      _reviewRow(context, 'طريقة التحقق', _methodName),
                      if (verificationMethod == 'document' && _docName.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        _reviewRow(context, 'المستند', _docName, trailing: const Icon(Icons.check_circle, size: 12, color: _green), valueColor: _green),
                      ],
                      if (verificationMethod == 'in_person' && preferredVisitTime.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        _reviewRow(context, 'وقت الزيارة', _visitTimeName),
                      ],
                      if (notes.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Divider(color: context.colorScheme.outlineVariant, height: 1),
                        const SizedBox(height: 8),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ملاحظات', style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant)),
                              const SizedBox(height: 4),
                              Text(notes, style: TextStyle(fontSize: 14, color: context.colorScheme.onSurface)),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Edit buttons
          Row(
            children: [
              Expanded(
                child: Material(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: onEditInfo,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text('تعديل البيانات', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Material(
                  color: context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: onEditVerify,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text('تعديل التحقق', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Terms
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.colorScheme.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: context.colorScheme.outlineVariant),
            ),
            child: GestureDetector(
              onTap: () => onAgreedChanged(!agreedToTerms),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: agreedToTerms ? _primary : context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: agreedToTerms ? _primary : context.colorScheme.outline,
                        width: 2,
                      ),
                    ),
                    child: agreedToTerms ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'أقر بأن المعلومات المقدمة صحيحة وأنني صاحب هذا النشاط أو مفوّض رسمياً بإدارته. أوافق على ',
                        style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant, height: 1.5),
                        children: [
                          TextSpan(text: 'شروط الاستخدام', style: TextStyle(color: _primary)),
                          TextSpan(text: ' و'),
                          TextSpan(text: 'سياسة الخصوصية', style: TextStyle(color: _primary)),
                          TextSpan(text: '.'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Anti-fraud notice
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade100),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.error_outline, size: 14, color: Colors.red.shade600),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'تقديم معلومات كاذبة لإثبات ملكية صفحة لا تخصك يُعتبر مخالفة صريحة ويؤدي لحظر حسابك نهائياً مع إمكانية اتخاذ إجراء قانوني.',
                    style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Icon(Icons.access_time, size: 12, color: context.colorScheme.onSurfaceVariant),
              const SizedBox(width: 8),
              Text(
                verificationMethod == 'in_person'
                    ? 'سنتواصل معك خلال ٢٤ ساعة لتأكيد الزيارة'
                    : 'مدة المراجعة: ٢٤ ساعة',
                style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reviewSection(BuildContext context, String title, {required Widget child, bool hasBorder = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: hasBorder ? Border(bottom: BorderSide(color: context.colorScheme.outlineVariant)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 10, color: context.colorScheme.onSurfaceVariant)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _reviewRow(BuildContext context, String label, String value, {Widget? trailing, Color? valueColor}) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: context.colorScheme.onSurfaceVariant)),
        const Spacer(),
        if (trailing != null) ...[trailing, const SizedBox(width: 4)],
        Text(value, style: TextStyle(fontSize: 14, color: valueColor ?? context.colorScheme.onSurface)),
      ],
    );
  }
}

// ════════════════════════════════════════════════════════════════
// Shared: Selectable Card (roles, methods, doc types)
// ════════════════════════════════════════════════════════════════

class _SelectableCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String description;
  final bool isSelected;
  final String? badge;
  final bool compact;
  final VoidCallback onTap;

  const _SelectableCard({
    required this.icon,
    required this.label,
    required this.description,
    required this.isSelected,
    this.badge,
    this.compact = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? _primary.withValues(alpha: 0.05) : context.colorScheme.surfaceContainerLowest,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(compact ? 12 : 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? _primary : context.colorScheme.surfaceContainer,
            ),
            boxShadow: isSelected
                ? [BoxShadow(color: _primary.withValues(alpha: 0.08), blurRadius: 4)]
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: compact ? 36 : 40,
                height: compact ? 36 : 40,
                decoration: BoxDecoration(
                  color: isSelected ? _primary.withValues(alpha: 0.1) : context.colorScheme.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(compact ? 8 : 10),
                ),
                child: Icon(
                  icon,
                  size: compact ? 16 : 18,
                  color: isSelected ? _primary : context.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          label,
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? _primary : context.colorScheme.onSurface,
                          ),
                        ),
                        if (badge != null) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              badge!,
                              style: const TextStyle(fontSize: 9, color: Colors.white),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      description,
                      style: TextStyle(fontSize: 11, color: context.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: _primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 12, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
