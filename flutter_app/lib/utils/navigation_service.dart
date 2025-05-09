import 'package:flutter/material.dart';

class NavigationService {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static navigateTo(String routeName) {
    navigatorKey.currentState?.pushNamed(routeName);
  }

  static goBack() {
    navigatorKey.currentState?.pop();
  }
}