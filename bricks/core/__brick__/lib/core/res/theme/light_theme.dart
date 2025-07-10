import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../assets.gen.dart';
import '../colors.dart';
import '../colors.gen.dart';
import '../theme/theme.dart';

class LightTheme extends AppTheme {
  @override
  ColorScheme get colorScheme => const ColorScheme.light(
    primary: AppColors.primarySwatch,
    secondary: Color.fromARGB(255, 235, 106, 37),
    outline: CupertinoColors.systemGrey5,
    outlineVariant: CupertinoColors.systemGrey2,
    surfaceContainerHighest: CupertinoColors.systemGrey5,
  );

  @override
  Color get scaffoldBackgroundColor => CupertinoColors.systemGrey6;

  @override
  PlaceholderTheme get placeholderTheme => PlaceholderTheme(
    image: AppAssets.images.placeholderLight,
    baseColor: colorScheme.surface.darken(),
    highlightColor: colorScheme.surface,
  );
}
