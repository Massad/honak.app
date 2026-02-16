import 'package:flutter/material.dart';
import 'package:honak/core/theme/app_spacing.dart';
import 'package:honak/features/requests/domain/entities/cart.dart';
import 'package:honak/features/requests/presentation/widgets/order_sheet_sections.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/core/extensions/context_ext.dart';
import 'package:honak/shared/widgets/button.dart' as btn;

/// Bottom sheet for catalog_order + menu_order archetypes.
///
/// Shows cart summary, delivery/pickup toggle, payment method display,
/// optional note, and submit button with total price.
class OrderRequestSheet extends StatefulWidget {
  final Cart cart;
  final String pageName;
  final List<String> paymentMethods;
  final String? deliveryFee;
  final List<Map<String, dynamic>> locations;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const OrderRequestSheet({
    super.key,
    required this.cart,
    required this.pageName,
    this.paymentMethods = const ['نقداً'],
    this.deliveryFee,
    this.locations = const [],
    required this.onSubmit,
  });

  /// Show this sheet as a modal bottom sheet.
  static Future<void> show({
    required BuildContext context,
    required Cart cart,
    required String pageName,
    List<String> paymentMethods = const ['نقداً'],
    String? deliveryFee,
    List<Map<String, dynamic>> locations = const [],
    required ValueChanged<Map<String, dynamic>> onSubmit,
  }) {
    return showAppSheet(
      context,
      builder: (_) => _OrderBody(
        cart: cart,
        pageName: pageName,
        paymentMethods: paymentMethods,
        deliveryFee: deliveryFee,
        locations: locations,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  State<OrderRequestSheet> createState() => _OrderRequestSheetState();
}

class _OrderRequestSheetState extends State<OrderRequestSheet> {
  @override
  Widget build(BuildContext context) {
    return _OrderBody(
      cart: widget.cart,
      pageName: widget.pageName,
      paymentMethods: widget.paymentMethods,
      deliveryFee: widget.deliveryFee,
      locations: widget.locations,
      onSubmit: widget.onSubmit,
    );
  }
}

class _OrderBody extends StatefulWidget {
  final Cart cart;
  final String pageName;
  final List<String> paymentMethods;
  final String? deliveryFee;
  final List<Map<String, dynamic>> locations;
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const _OrderBody({
    required this.cart,
    required this.pageName,
    required this.paymentMethods,
    this.deliveryFee,
    required this.locations,
    required this.onSubmit,
  });

  @override
  State<_OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<_OrderBody> {
  bool _isDelivery = true;
  int _selectedLocationIdx = 0;
  int _selectedPaymentIdx = 0;
  final _noteController = TextEditingController();

  List<Map<String, dynamic>> get _enabledLocations =>
      widget.locations.where((l) => l['enabled'] != false).toList();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _submit() {
    widget.onSubmit({
      'delivery_method': _isDelivery ? 'delivery' : 'pickup',
      'payment_method': widget.paymentMethods.isNotEmpty
          ? widget.paymentMethods[_selectedPaymentIdx]
          : 'نقداً',
      'note': _noteController.text.trim(),
      if (!_isDelivery && _enabledLocations.isNotEmpty)
        'pickup_location': _enabledLocations[_selectedLocationIdx]['name'],
      'cart_items': widget.cart.items
          .map((i) => {
                'item_id': i.itemId,
                'name': i.name,
                'quantity': i.quantity,
                'unit_price_cents': i.unitPriceCents,
              })
          .toList(),
      'total_cents': widget.cart.subtotal.cents,
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDragHandle(),
        _buildHeader(theme),
        Flexible(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.xl, AppSpacing.lg, AppSpacing.xl, AppSpacing.lg,
            ),
            children: [
              _buildBusinessLabel(theme),
              const SizedBox(height: AppSpacing.xl),
              OrderCartSummary(cart: widget.cart),
              const SizedBox(height: AppSpacing.xl),
              DeliveryToggle(
                isDelivery: _isDelivery,
                onChanged: (v) => setState(() => _isDelivery = v),
              ),
              const SizedBox(height: AppSpacing.xl),
              if (_isDelivery) ...[
                DeliveryAddressSection(deliveryFee: widget.deliveryFee),
                const SizedBox(height: AppSpacing.xl),
              ] else if (_enabledLocations.length > 1) ...[
                OrderBranchSelector(
                  locations: _enabledLocations,
                  selectedIndex: _selectedLocationIdx,
                  onChanged: (i) =>
                      setState(() => _selectedLocationIdx = i),
                ),
                const SizedBox(height: AppSpacing.xl),
              ] else if (_enabledLocations.length == 1) ...[
                OrderSingleBranch(location: _enabledLocations.first),
                const SizedBox(height: AppSpacing.xl),
              ],
              OrderPaymentMethods(
                paymentMethods: widget.paymentMethods,
                selectedIndex: _selectedPaymentIdx,
                onChanged: (i) =>
                    setState(() => _selectedPaymentIdx = i),
              ),
              const SizedBox(height: AppSpacing.xl),
              OrderNoteField(controller: _noteController),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
        _buildSubmitButton(theme),
      ],
    );
  }

  Widget _buildDragHandle() {
    return Padding(
      padding:
          const EdgeInsets.only(top: AppSpacing.md, bottom: AppSpacing.sm),
      child: Center(
        child: Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: context.colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.xl, 0, AppSpacing.xl, AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('تأكيد الطلب', style: theme.textTheme.titleMedium),
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, size: 20),
            style: IconButton.styleFrom(
              foregroundColor: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessLabel(ThemeData theme) {
    return Row(
      children: [
        Text(
          'الطلب من',
          style: theme.textTheme.bodySmall
              ?.copyWith(color: context.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(
          widget.pageName,
          style: theme.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(ThemeData theme) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.xl, AppSpacing.sm, AppSpacing.xl, AppSpacing.lg,
        ),
        child: SizedBox(
          width: double.infinity,
          child: btn.Button(
            onPressed: _submit,
            label: 'إرسال طلب الشراء — ${widget.cart.subtotal.toFormattedArabic()}',
            icon: const btn.ButtonIcon(Icons.send),
            size: btn.ButtonSize.large,
            expand: true,
          ),
        ),
      ),
    );
  }
}
