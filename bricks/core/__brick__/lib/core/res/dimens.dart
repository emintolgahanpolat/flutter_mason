import 'package:flutter/material.dart';

class Dimens {
  /// 2.0
  static const double xxs = 2.0;

  /// 4.0
  static const double xs = 4.0;

  /// 8.0
  static const double s = 8.0;

  /// 16.0
  static const double m = 16.0;

  /// 24.0
  static const double l = 24.0;

  /// 32.0
  static const double xl = 32.0;

  /// 48.0
  static const double xxl = 48.0;
}

enum Gap { vertical, horizontal }

extension GapEx on Gap {
  Widget get xxs => _build(2);
  Widget get xs => _build(4);
  Widget get s => _build(8);
  Widget get m => _build(16);
  Widget get l => _build(24);
  Widget get xl => _build(32);
  Widget get xxl => _build(48);
  Widget _build(double size) => this == Gap.vertical
      ? SizedBox(
          height: size,
        )
      : SizedBox(
          width: size,
        );
}
