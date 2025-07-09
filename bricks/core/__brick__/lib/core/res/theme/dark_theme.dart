import 'package:flutter/material.dart';
import '../assets.gen.dart';
import '../colors.gen.dart';
import '../theme/theme.dart';

class DarkTheme extends AppTheme {
  @override
  Color get scaffoldBackgroundColor => const Color(0xFF1c1c1e);

  @override
  PlaceholderTheme get placeholderTheme => PlaceholderTheme(
    image: AppAssets.images.placeholderDark,
    baseColor: const Color(0xFF3a3a3a),
    highlightColor: const Color(0xFF4a4a4a),
  );

  @override
  ColorScheme get colorScheme => const ColorScheme.dark(
    primary: AppColors.primarySwatch,
    secondary: Colors.orange,
    outline: Colors.grey,
  );
}
