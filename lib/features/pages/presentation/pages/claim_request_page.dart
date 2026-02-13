import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:honak/features/pages/domain/entities/page_detail.dart';
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
      backgroundColor: Colors.white,
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
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // Title row (LTR: back on left, title center)
          Row(
            textDirection: TextDirection.ltr,
            children: [
              GestureDetector(
                onTap: _handleBack,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: Icon(Icons.arrow_back_ios_new, size: 20, color: Colors.grey.shade600),
                  ),
                ),
              ),
              const Expanded(
                child: Text(
                  'إثبات ملكية',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Color(0xFF111827)),
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
                          color: isActive ? _primary : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _stepLabels[i],
                        style: TextStyle(
                          fontSize: 9,
                          color: isCurrent ? _primary : Colors.grey.shade400,
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
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade100)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          color: _canProceed ? _primary : Colors.grey.shade200,
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
                    Icon(Icons.shield_outlined, size: 16, color: _canProceed ? Colors.white : Colors.grey.shade400),
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
                      color: _canProceed ? Colors.white : Colors.grey.shade400,
                    ),
                  ),
                  if (_step > 1 && _step < 4) ...[
                    const SizedBox(width: 4),
                    Icon(Icons.chevron_left, size: 16, color: _canProceed ? Colors.white : Colors.grey.shade400),
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
      backgroundColor: Colors.white,
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

                const Text(
                  'تم إرسال طلبك بنجاح',
                  style: TextStyle(fontSize: 20, color: Color(0xFF111827)),
                ),
                const SizedBox(height: 8),
                Text(
                  isInPerson
                      ? 'سنتواصل معك لتأكيد موعد الزيارة.\nفريقنا سيساعدك بتفعيل الصفحة بالكامل.'
                      : 'سيراجع فريق هناك طلبك خلال ٢٤ ساعة.\nسنتواصل معك عبر الرقم المسجل.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6B7280),
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
                    color: const Color(0xFFF9FAFB),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0xFFF3F4F6)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ماذا بعد؟',
                        style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
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
                              style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '@${widget.page.handle ?? widget.page.slug}',
                              style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280)),
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
          child: Text(text, style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
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
                    color: Colors.white,
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
                        style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '@${page.handle ?? page.slug}',
                        style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
                      ),
                      if (page.location?.label != null) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 10, color: Colors.grey.shade400),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                page.location!.label!,
                                style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
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

          const Text(
            'إثبات ملكية هذه الصفحة',
            style: TextStyle(fontSize: 18, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 8),
          const Text(
            'تم إنشاء هذه الصفحة تلقائياً من بيانات عامة.\nإذا كنت صاحب هذا النشاط أو مفوّضاً بإدارته،\nيمكنك إثبات ملكيتك للتحكم الكامل بالصفحة.',
            style: TextStyle(fontSize: 14, color: Color(0xFF6B7280), height: 1.6),
          ),
          const SizedBox(height: 24),

          // What you get
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF3F4F6)),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
                  ),
                  child: const Text(
                    'بعد إثبات الملكية ستتمكن من:',
                    style: TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      _benefitRow(Icons.storefront, 'إدارة معلومات الصفحة وتحديثها'),
                      const SizedBox(height: 12),
                      _benefitRow(Icons.description_outlined, 'إضافة منتجاتك أو خدماتك أو قائمتك'),
                      const SizedBox(height: 12),
                      _benefitRow(Icons.shield_outlined, 'تفعيل استقبال الطلبات عبر هناك'),
                      const SizedBox(height: 12),
                      _benefitRow(Icons.person_outline, 'إدارة فريق العمل والصلاحيات'),
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
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'نجي نزورك!',
                        style: TextStyle(fontSize: 14, color: Color(0xFF111827)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'فريقنا بزور المحلات لمساعدة أصحابها بتفعيل صفحاتهم.\nبنتحقق منك شخصياً وبنساعدك تعبّي كل شي.',
                        style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.5),
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
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'العملية بسيطة ومجانية',
                        style: TextStyle(fontSize: 14, color: Color(0xFF111827)),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'بياناتك + تحقق من الرقم + إثبات بسيط = صفحتك جاهزة.',
                        style: TextStyle(fontSize: 12, color: Color(0xFF6B7280), height: 1.5),
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

  Widget _benefitRow(IconData icon, String text) {
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
          child: Text(text, style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
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
          const Text('بياناتك الشخصية', style: TextStyle(fontSize: 18, color: Color(0xFF111827))),
          const SizedBox(height: 4),
          const Text('حدّثنا عنك وعن علاقتك بهذا النشاط', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 24),

          // Full Name
          const Text('الاسم الكامل', style: TextStyle(fontSize: 14, color: Color(0xFF374151))),
          const SizedBox(height: 8),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'كما هو في الهوية الشخصية',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              prefixIcon: Icon(Icons.person_outline, size: 16, color: Colors.grey.shade400),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _primary),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 20),

          // Phone
          const Text('رقم الهاتف', style: TextStyle(fontSize: 14, color: Color(0xFF374151))),
          const SizedBox(height: 8),
          Directionality(
            textDirection: TextDirection.ltr,
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
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      prefixIcon: Icon(Icons.phone_outlined, size: 16, color: Colors.grey.shade400),
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: _primary),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade200),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                    style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
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
              textDirection: TextDirection.rtl,
              child: Text(
                'أدخل الرمز المرسل إلى ${phoneController.text}',
                style: const TextStyle(fontSize: 11, color: Color(0xFF6B7280)),
              ),
            ),
            const SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: onOtpChanged,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: '------',
                        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14, letterSpacing: 8),
                        filled: true,
                        fillColor: const Color(0xFFF9FAFB),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: _primary),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      ),
                      style: const TextStyle(fontSize: 14, letterSpacing: 8, color: Color(0xFF111827)),
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
              textDirection: TextDirection.rtl,
              child: Text(
                'في النسخة التجريبية: أي ٦ أرقام مقبولة',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
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
          const Text('علاقتك بالنشاط', style: TextStyle(fontSize: 14, color: Color(0xFF374151))),
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
          const Text('إثبات الملكية', style: TextStyle(fontSize: 18, color: Color(0xFF111827))),
          const SizedBox(height: 4),
          const Text('اختر طريقة التحقق المناسبة لك', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
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
                      const Text('تحديد الموقع', style: TextStyle(fontSize: 14, color: Color(0xFF111827))),
                      const SizedBox(height: 4),
                      const Text(
                        'شارك موقعك الحالي لنتأكد إنك بالمحل. هالخطوة إلزامية لجميع الأنشطة.',
                        style: TextStyle(fontSize: 11, color: Color(0xFF6B7280), height: 1.5),
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
          const Text('اختر طريقة التحقق', style: TextStyle(fontSize: 14, color: Color(0xFF374151))),
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
                  const Text('متى نزوركم؟', style: TextStyle(fontSize: 14, color: Color(0xFF111827))),
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
                                      Text(time.label, style: const TextStyle(fontSize: 14, color: Color(0xFF111827))),
                                      Text(time.desc, style: TextStyle(fontSize: 10, color: Colors.grey.shade500)),
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
                    style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
                  ),
                ],
              ),
            ),
          ],

          // Document Upload
          if (verificationMethod == 'document') ...[
            Text('اختر نوع المستند', style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
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
                style: const TextStyle(fontSize: 14, color: Color(0xFF374151)),
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
                      border: Border.all(color: Colors.grey.shade300, width: 2),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade100,
                          ),
                          child: Icon(Icons.upload_outlined, size: 18, color: Colors.grey.shade400),
                        ),
                        const SizedBox(height: 8),
                        Text('اضغط لرفع صورة أو مستند', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                        const SizedBox(height: 4),
                        Text('JPG, PNG, PDF — حتى ١٠ ميغابايت', style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
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
                              style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
                            ),
                            const Text('تم الرفع بنجاح', style: TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onDocumentUploaded(false),
                        child: Icon(Icons.close, size: 16, color: Colors.grey.shade400),
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('مكالمة فيديو قصيرة', style: TextStyle(fontSize: 14, color: Color(0xFF111827))),
                        SizedBox(height: 4),
                        Text(
                          'سنتصل بك مكالمة فيديو وأنت بالمحل. نشوف المكان ونتحقق\nمن هويتك — مدة المكالمة ٢-٣ دقائق فقط.',
                          style: TextStyle(fontSize: 11, color: Color(0xFF6B7280), height: 1.5),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'سنتواصل معك لتحديد الموعد بعد إرسال الطلب',
                          style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
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
              const Text('ملاحظات إضافية', style: TextStyle(fontSize: 14, color: Color(0xFF374151))),
              const SizedBox(width: 4),
              Text('(اختياري)', style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
            ],
          ),
          const SizedBox(height: 8),
          TextField(
            controller: notes,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'أي معلومات تساعدنا...',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade200),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: _primary),
              ),
              contentPadding: const EdgeInsets.all(12),
            ),
            style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
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
          const Text('مراجعة وإرسال', style: TextStyle(fontSize: 18, color: Color(0xFF111827))),
          const SizedBox(height: 4),
          const Text('تأكد من صحة البيانات قبل الإرسال', style: TextStyle(fontSize: 14, color: Color(0xFF6B7280))),
          const SizedBox(height: 20),

          // Summary card
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                // Page
                _reviewSection(
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
                            Text(page.name, style: const TextStyle(fontSize: 14, color: Color(0xFF111827))),
                            Text('@${page.handle ?? page.slug}', style: const TextStyle(fontSize: 10, color: Color(0xFF6B7280))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Personal info
                _reviewSection(
                  'بياناتك',
                  hasBorder: true,
                  child: Column(
                    children: [
                      _reviewRow('الاسم', fullName),
                      const SizedBox(height: 6),
                      _reviewRow('الهاتف', phone, trailing: const Icon(Icons.check_circle, size: 10, color: _green)),
                      const SizedBox(height: 6),
                      _reviewRow('الصفة', _roleName),
                    ],
                  ),
                ),

                // Verification
                _reviewSection(
                  'التحقق',
                  child: Column(
                    children: [
                      _reviewRow(
                        'الموقع (GPS)',
                        gpsCaptured ? 'تم التحديد' : 'لم يُحدد',
                        trailing: gpsCaptured ? const Icon(Icons.check_circle, size: 12, color: _green) : null,
                        valueColor: gpsCaptured ? _green : Colors.grey.shade400,
                      ),
                      const SizedBox(height: 6),
                      _reviewRow('طريقة التحقق', _methodName),
                      if (verificationMethod == 'document' && _docName.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        _reviewRow('المستند', _docName, trailing: const Icon(Icons.check_circle, size: 12, color: _green), valueColor: _green),
                      ],
                      if (verificationMethod == 'in_person' && preferredVisitTime.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        _reviewRow('وقت الزيارة', _visitTimeName),
                      ],
                      if (notes.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Divider(color: Colors.grey.shade100, height: 1),
                        const SizedBox(height: 8),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('ملاحظات', style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
                              const SizedBox(height: 4),
                              Text(notes, style: const TextStyle(fontSize: 14, color: Color(0xFF374151))),
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
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: onEditInfo,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text('تعديل البيانات', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Material(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: onEditVerify,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text('تعديل التحقق', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: Color(0xFF4B5563))),
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
              color: const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFF3F4F6)),
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
                      color: agreedToTerms ? _primary : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: agreedToTerms ? _primary : Colors.grey.shade300,
                        width: 2,
                      ),
                    ),
                    child: agreedToTerms ? const Icon(Icons.check, size: 12, color: Colors.white) : null,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'أقر بأن المعلومات المقدمة صحيحة وأنني صاحب هذا النشاط أو مفوّض رسمياً بإدارته. أوافق على ',
                        style: TextStyle(fontSize: 12, color: Color(0xFF4B5563), height: 1.5),
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
                const Expanded(
                  child: Text(
                    'تقديم معلومات كاذبة لإثبات ملكية صفحة لا تخصك يُعتبر مخالفة صريحة ويؤدي لحظر حسابك نهائياً مع إمكانية اتخاذ إجراء قانوني.',
                    style: TextStyle(fontSize: 10, color: Color(0xFF4B5563), height: 1.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Icon(Icons.access_time, size: 12, color: Colors.grey.shade400),
              const SizedBox(width: 8),
              Text(
                verificationMethod == 'in_person'
                    ? 'سنتواصل معك خلال ٢٤ ساعة لتأكيد الزيارة'
                    : 'مدة المراجعة: ٢٤ ساعة',
                style: TextStyle(fontSize: 10, color: Colors.grey.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _reviewSection(String title, {required Widget child, bool hasBorder = false}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: hasBorder ? Border(bottom: BorderSide(color: Colors.grey.shade100)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 10, color: Colors.grey.shade400)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _reviewRow(String label, String value, {Widget? trailing, Color? valueColor}) {
    return Row(
      children: [
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade500)),
        const Spacer(),
        if (trailing != null) ...[trailing, const SizedBox(width: 4)],
        Text(value, style: TextStyle(fontSize: 14, color: valueColor ?? const Color(0xFF111827))),
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
      color: isSelected ? _primary.withValues(alpha: 0.05) : const Color(0xFFF9FAFB),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(compact ? 12 : 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? _primary : Colors.grey.shade200,
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
                  color: isSelected ? _primary.withValues(alpha: 0.1) : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(compact ? 8 : 10),
                ),
                child: Icon(
                  icon,
                  size: compact ? 16 : 18,
                  color: isSelected ? _primary : Colors.grey.shade400,
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
                            color: isSelected ? _primary : const Color(0xFF111827),
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
                      style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
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
