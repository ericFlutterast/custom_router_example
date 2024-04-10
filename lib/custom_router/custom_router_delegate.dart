import 'package:deeplinks_app/custom_router/navigation_state.dart';
import 'package:deeplinks_app/ui/cart_screen.dart';
import 'package:deeplinks_app/ui/item_details_screen.dart';
import 'package:deeplinks_app/ui/item_list_screen.dart';
import 'package:deeplinks_app/ui/unknown_screen.dart';
import 'package:flutter/material.dart';

//addListener -> mixin ChangeNotifierMixin
//removeListener -> mixin ChangeNotifierMixin
//popRoute -> mixin PopNavigatorRouterDelegateMixin

/// NavigatorState – модель, которая определяет состояние навигации, мы ее создаем сами
/// ChangeNotifier – помогает оповещать об изменениях подписчиков, заодно реализует необходимые методы для RouterDelegate: addListener, removerListener
/// PopNavigatorRouterDelegateMixin – помогает управлять возвращением назад, в том числе системным, заодно реализуеи необходимые методы
final class CustomRouterDelegate extends RouterDelegate<CustomNavigationState>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  CustomRouterDelegate({required CustomNavigationState state}) : _state = state;

  @override
  GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  CustomNavigationState _state;

  bool? _isCart;
  String? _selectedItemId;

  @override
  CustomNavigationState? get currentConfiguration {
    if (_isCart == true) {
      return CustomNavigationState.cart();
    }

    if (_selectedItemId != null) {
      return CustomNavigationState.item(_selectedItemId);
    }

    return CustomNavigationState.root();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          child: ItemListScreen(
            onTapToCart: _showCart,
            onTapToItemDetails: _showItemDetails,
          ),
        ),
        if (_isCart == true)
          const MaterialPage(
            child: CartScreen(),
          ),
        if (_selectedItemId != null)
          MaterialPage(
            child: ItemDetailsScreen(
              itemId: _state.selectedItemId,
            ),
          ),
        if (_selectedItemId == null && _isCart == false)
          const MaterialPage(
            child: UnknownScreen(
              '404',
            ),
          ),
      ],
      onPopPage: (rout, resal) {
        if (!rout.didPop(resal)) {
          return false;
        }

        if (_isCart == true) {
          _isCart = false;
        }

        if (_selectedItemId != null) {
          _selectedItemId = null;
        }

        notifyListeners();
        _isCart = null;
        _selectedItemId = null;
        return true;
      },
    );
  }

  ///Вызывается [Router], когда [Router.routeInformationProvider] сообщает,
  ///что операционная система отправила приложению новый маршрут.
  @override
  Future<void> setNewRoutePath(CustomNavigationState configuration) async {
    if (configuration.isDetailScreen) {
      _selectedItemId = configuration.selectedItemId;
    } else if (configuration.isCart) {
      _isCart = true;
    } else {
      _selectedItemId = null;
      _isCart = false;
    }

    notifyListeners();
  }

  void _showCart() {
    _isCart = true;
    notifyListeners();
  }

  void _showItemDetails(String itemId) {
    _selectedItemId = itemId;
    notifyListeners();
  }
}
