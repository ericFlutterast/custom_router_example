import 'package:deeplinks_app/custom_router/navigation_state.dart';
import 'package:deeplinks_app/domain/items_repository.dart';
import 'package:deeplinks_app/domain/models/routes.dart';
import 'package:flutter/material.dart';

final class CustomRouterInformationParser extends RouteInformationParser<CustomNavigationState> {
  //RouterInformation -> Navigation
  @override
  Future<CustomNavigationState> parseRouteInformation(RouteInformation routeInformation) async {
    final List<String> pathSegments = routeInformation.uri.pathSegments;

    if (pathSegments.isEmpty) {
      return CustomNavigationState.root();
    }

    if (pathSegments.length == 2) {
      final itemId = pathSegments[1];

      if (pathSegments[0] == Routes.item && ItemsRepository.items.any((item) => item.id == itemId)) {
        return CustomNavigationState.item(itemId);
      }

      return CustomNavigationState.unknown();
    }

    if (pathSegments.length == 1) {
      if (pathSegments.first == Routes.cart) {
        return CustomNavigationState.cart();
      }
    }

    return CustomNavigationState.root();
  }

  //Navigation -> RouterInformation
  @override
  RouteInformation? restoreRouteInformation(CustomNavigationState configuration) {
    if (configuration.isCart) {
      return RouteInformation(location: '/${Routes.cart}');
    }

    if (configuration.isDetailScreen) {
      return RouteInformation(location: '/${Routes.item}/${configuration.selectedItemId}');
    }

    if (configuration.isUnknown) {
      return null;
    }

    return RouteInformation(location: '/');
  }
}
