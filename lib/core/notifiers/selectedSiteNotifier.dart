import 'package:flutter/material.dart';

/// Custom ValueNotifier to manage selected site ID and trigger refresh
class SelectedSiteNotifier extends ValueNotifier<int?> {
  static SelectedSiteNotifier? _instance;

  SelectedSiteNotifier(super.value);

  /// Singleton instance
  static SelectedSiteNotifier getInstance({int? initialValue}) {
    _instance ??= SelectedSiteNotifier(initialValue);
    return _instance!;
  }

  /// Update the site ID and notify listeners
  void updateSiteId(int? siteId) {
    value = siteId;
    notifyListeners();
  }
}
