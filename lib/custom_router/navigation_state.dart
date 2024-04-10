final class CustomNavigationState {
  CustomNavigationState.cart()
      : _cart = true,
        _unknown = false,
        selectedItemId = null;

  CustomNavigationState.item(this.selectedItemId)
      : _cart = false,
        _unknown = false;

  CustomNavigationState.root()
      : _cart = false,
        _unknown = false,
        selectedItemId = null;

  CustomNavigationState.unknown()
      : _cart = false,
        _unknown = true,
        selectedItemId = null;

  final bool? _unknown;
  final bool? _cart;
  final String? selectedItemId;

  bool get isCart => _cart == true;
  bool get isDetailScreen => selectedItemId != null;
  bool get isUnknown => _unknown == true;
  bool get isRoot => !isCart && !isDetailScreen && !isUnknown;
}
