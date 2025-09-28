import 'package:flutter/material.dart';

/// Custom ValueNotifier to manage selected site ID and trigger refresh
class RefreshNotifier extends ValueNotifier<bool?> {
  static RefreshNotifier? _instance;

  RefreshNotifier(super.value);

  /// Singleton instance
  static RefreshNotifier getInstance({bool? initialValue}) {
    _instance ??= RefreshNotifier(initialValue);
    return _instance!;
  }

  /// Update the site ID and notify listeners
  void refresh(bool? canRefresh) {
    value = canRefresh;
    notifyListeners();
  }
}
