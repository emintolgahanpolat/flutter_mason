import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double kCompactSize = 600;

enum WindowsWidthType {
  /// Width <= 600
  compact,

  /// 600 < width <= 840
  medium,

  /// 840 < width <= 1200
  expanded,

  /// 1200 < width <= 1600
  large,

  /// width > 1600
  extraLarge,
}

extension _Size on Size {
  WindowsWidthType get windowsWidthType {
    if (width < 600) {
      return WindowsWidthType.compact;
    } else if (width < 840) {
      return WindowsWidthType.medium;
    } else if (width < 1200) {
      return WindowsWidthType.expanded;
    } else if (width < 1600) {
      return WindowsWidthType.large;
    } else {
      return WindowsWidthType.extraLarge;
    }
  }

  WindowsHeightType get windowsHeightType {
    if (height < 480) {
      return WindowsHeightType.compact;
    } else if (height < 900) {
      return WindowsHeightType.medium;
    } else {
      return WindowsHeightType.expanded;
    }
  }
}

enum WindowsHeightType {
  /// Width <= 480
  compact,

  /// 480 < width <= 900
  medium,

  ///  width  > 900
  expanded,
}

extension ScreenUtil on BuildContext {
  WindowsWidthType get windowsWidthType =>
      MediaQuery.of(this).size.windowsWidthType;
  WindowsHeightType get windowsHeightType =>
      MediaQuery.of(this).size.windowsHeightType;

  Size get screenSize => MediaQuery.of(this).size;

  bool get isCompact => windowsWidthType == WindowsWidthType.compact;
  bool get isMedium => windowsWidthType == WindowsWidthType.medium;
  bool get isExpanded => windowsWidthType == WindowsWidthType.expanded;
  bool get isLarge => windowsWidthType == WindowsWidthType.large;
  bool get isExtraLarge => windowsWidthType == WindowsWidthType.extraLarge;

  bool get isHeightCompact => windowsHeightType == WindowsHeightType.compact;
  bool get isHeightMedium => windowsHeightType == WindowsHeightType.medium;
  bool get isHeightExpanded => windowsHeightType == WindowsHeightType.expanded;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  T autoLayout<T>({
    required T compact,
    T? medium,
    T? expanded,
    T? large,
    T? extraLarge,
  }) {
    switch (windowsWidthType) {
      case WindowsWidthType.extraLarge:
        return extraLarge ?? large ?? expanded ?? medium ?? compact;
      case WindowsWidthType.large:
        return large ?? expanded ?? medium ?? compact;
      case WindowsWidthType.expanded:
        return expanded ?? medium ?? compact;
      case WindowsWidthType.medium:
        return medium ?? compact;
      default:
        return compact;
    }
  }

  T? showByType<T>({
    T? compact,
    T? medium,
    T? expanded,
    T? large,
    T? extraLarge,
  }) {
    switch (windowsWidthType) {
      case WindowsWidthType.extraLarge:
        return extraLarge;
      case WindowsWidthType.large:
        return large;
      case WindowsWidthType.expanded:
        return expanded;
      case WindowsWidthType.medium:
        return medium;
      default:
        return compact;
    }
  }
}

extension BoxConstraintsEx on BoxConstraints {
  WindowsWidthType get windowsType {
    if (maxWidth <= kCompactSize) {
      return WindowsWidthType.compact;
    } else if (maxWidth <= 1024) {
      return WindowsWidthType.medium;
    } else {
      return WindowsWidthType.expanded;
    }
  }

  bool get isCompact => windowsType == WindowsWidthType.compact;
  bool get isMedium => windowsType == WindowsWidthType.medium;
  bool get isExpanded => windowsType == WindowsWidthType.expanded;
  T autoLayout<T>({required T compact, T? medium, T? expanded}) {
    if (maxWidth <= kCompactSize) {
      return compact;
    } else if (maxWidth <= 1024) {
      return medium ?? compact;
    } else {
      return expanded ?? medium ?? compact;
    }
  }

  T? showByType<T>({T? compact, T? medium, T? expanded}) {
    if (maxWidth <= kCompactSize) {
      return compact;
    } else if (maxWidth <= 1024) {
      return medium;
    } else {
      return expanded;
    }
  }
}

extension DoubleEx on double {
  T? showByType<T>({T? compact, T? medium, T? expanded}) {
    if (this <= 600) {
      return compact;
    } else if (this <= 1024) {
      return medium;
    } else {
      return expanded;
    }
  }

  T autoLayout<T>({required T compact, T? medium, T? expanded}) {
    if (this >= 1024) {
      return expanded ?? medium ?? compact;
    } else if (this >= 600) {
      return medium ?? compact;
    } else {
      return compact;
    }
  }
}

bool get isMobile => !kIsWeb;
