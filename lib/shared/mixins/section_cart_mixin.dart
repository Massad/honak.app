import 'package:flutter/material.dart';
import 'package:honak/features/catalog/domain/entities/item.dart';
import 'package:honak/features/requests/domain/entities/cart.dart';
import 'package:honak/features/requests/presentation/widgets/order_request_sheet.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/selected_item.dart';
import 'package:honak/shared/widgets/app_sheet.dart';
import 'package:honak/shared/widgets/item_selection/item_configuration_step.dart';

/// Shared cart management for catalog/menu sections.
///
/// Provides `cart` list, computed properties (`cartItemCount`, `cartTotal`,
/// `quantityForItem`), and actions (`handleQuantityChanged`,
/// `showItemConfigSheet`, `openOrderSheet`).
mixin SectionCartMixin<T extends StatefulWidget> on State<T> {
  final List<SelectedItem> cart = [];

  int get cartItemCount => cart.fold(0, (sum, si) => sum + si.quantity);

  Money get cartTotal =>
      Money(cart.fold(0, (sum, si) => sum + si.totalPriceCents));

  int quantityForItem(String itemId) =>
      cart.where((si) => si.itemId == itemId).fold(0, (sum, si) => sum + si.quantity);

  void handleQuantityChanged(Item item, int qty) {
    setState(() {
      if (qty <= 0) {
        cart.removeWhere((si) => si.itemId == item.id);
      } else {
        final idx = cart.indexWhere((si) => si.itemId == item.id);
        if (idx >= 0) {
          cart[idx] = cart[idx].copyWith(quantity: qty);
        } else {
          cart.add(SelectedItem(
            itemId: item.id,
            name: item.nameAr,
            image: item.images.isNotEmpty ? item.images.first : null,
            basePriceCents: item.price.cents,
            quantity: qty,
          ));
        }
      }
    });
  }

  void showItemConfigSheet(BuildContext context, Item item) {
    showAppSheet(
      context,
      maxHeightFraction: 0.85,
      builder: (ctx) => ItemConfigurationStep(
        item: item,
        confirmLabel: '\u0625\u0636\u0627\u0641\u0629 \u0644\u0644\u0633\u0644\u0629',
        onConfirm: (selectedItem) {
          Navigator.of(ctx).pop();
          setState(() => cart.add(selectedItem));
        },
        onBack: () => Navigator.of(ctx).pop(),
      ),
    );
  }

  void openOrderSheet(
    BuildContext context, {
    required String pageId,
    required String pageName,
    required List<String> paymentMethods,
  }) {
    final cartItems = cart.map((si) => CartItem.fromSelectedItem(si)).toList();
    final cartObj = Cart(
      pageId: pageId,
      pageName: pageName,
      items: cartItems,
    );
    OrderRequestSheet.show(
      context: context,
      cart: cartObj,
      pageName: pageName,
      paymentMethods: paymentMethods,
      onSubmit: (data) {
        Navigator.of(context).pop();
        setState(() => cart.clear());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              '\u062a\u0645 \u0625\u0631\u0633\u0627\u0644 \u0637\u0644\u0628\u0643 \u0628\u0646\u062c\u0627\u062d \u2014 \u0633\u064a\u062a\u0645 \u0627\u0644\u0631\u062f \u0642\u0631\u064a\u0628\u0627\u064b',
            ),
          ),
        );
      },
    );
  }
}
