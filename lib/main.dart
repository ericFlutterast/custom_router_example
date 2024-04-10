import 'package:deeplinks_app/custom_router/custom_router_delegate.dart';
import 'package:deeplinks_app/custom_router/custom_router_parser.dart';
import 'package:deeplinks_app/custom_router/navigation_state.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _routerDelegate = CustomRouterDelegate(
    state: CustomNavigationState.root(),
  );
  final _routerInformationParser = CustomRouterInformationParser();

  //Миграция на навигатор 2.0
  //MaterialApp -> MaterialApp.router
  //RouterDelegate<T>
  //RouterParser
  //T = something navigationState
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routerInformationParser,
    );
  }
}
