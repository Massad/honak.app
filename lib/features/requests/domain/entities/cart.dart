import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:honak/shared/entities/money.dart';
import 'package:honak/shared/entities/selected_item.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';

/// A single item in the customer's cart (catalogOrder + menuOrder).
@freezed
class CartItem with _$CartItem {
  const CartItem._();

  const factory CartItem({
    required String itemId,
    required String name,
    @JsonKey(name: 'image_url') String? imageUrl,
    /// Unit price in piasters (item base + selected option modifiers).
    @JsonKey(name: 'unit_price_cents') required int unitPriceCents,
    @Default(1) int quantity,
    /// Display text for selected options (e.g. "كبير، إضافي جبنة").
    String? variation,
    /// Raw selected option IDs keyed by group ID.
    @Default({}) Map<String, List<String>> selectedOptions,
  }) = _CartItem;

  Money get unitPrice => Money(unitPriceCents);
  Money get lineTotal => Money(unitPriceCents * quantity);

  factory CartItem.fromSelectedItem(SelectedItem si) => CartItem(
        itemId: si.itemId,
        name: si.name,
        imageUrl: si.image,
        unitPriceCents: si.unitPriceCents,
        quantity: si.quantity,
        variation:
            si.optionsSummary.isNotEmpty ? si.optionsSummary : null,
        selectedOptions: si.selectedOptions.map(
          (k, v) => MapEntry(k, v.map((o) => o.id).toList()),
        ),
      );

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);
}

/// Full cart state for a single business page.
@freezed
class Cart with _$Cart {
  const Cart._();

  const factory Cart({
    @JsonKey(name: 'page_id') required String pageId,
    @JsonKey(name: 'page_name') required String pageName,
    @JsonKey(name: 'page_avatar_url') String? pageAvatarUrl,
    @Default([]) List<CartItem> items,
  }) = _Cart;

  int get itemCount => items.fold(0, (sum, i) => sum + i.quantity);

  Money get subtotal => items.fold(
        const Money.zero(),
        (sum, item) => sum + item.lineTotal,
      );

  bool get isEmpty => items.isEmpty;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
