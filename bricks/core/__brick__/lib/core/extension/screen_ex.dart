import 'package:flutter/material.dart';

const double kCompactSize = 600;

enum WindowsType {
  /// Width <= 600
  /// Phone in portrait
  compact,

  /// 600 < width <? 1024
  /// Tablet in portrait
  /// Foldable in portrait (unfolded)
  medium,

  /// Width > 2024
  /// Phone in landscape
  /// Tablet in landscape
  /// Foldable in landscape (unfolded)
  /// Desktop
  expanded
}

extension ScreenUtil on BuildContext {
  WindowsType get windowsType {
    if (MediaQuery.of(this).size.width <= 600) {
      return WindowsType.compact;
    } else if (MediaQuery.of(this).size.width <= 1024) {
      return WindowsType.medium;
    } else {
      return WindowsType.expanded;
    }
  }

  Size get screenSize => MediaQuery.of(this).size;

  bool get isCompact => windowsType == WindowsType.compact;
  bool get isMedium => windowsType == WindowsType.medium;
  bool get isExpanded => windowsType == WindowsType.expanded;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  T autoLayout<T>({required T compact, T? medium, T? expanded}) {
    if (windowsType == WindowsType.expanded) {
      return expanded ?? medium ?? compact;
    } else if (windowsType == WindowsType.medium) {
      return medium ?? compact;
    } else {
      return compact;
    }
  }

  T? showByType<T>({T? compact, T? medium, T? expanded}) {
    if (windowsType == WindowsType.expanded) {
      return expanded;
    } else if (windowsType == WindowsType.medium) {
      return medium;
    } else {
      return compact;
    }
  }
}
