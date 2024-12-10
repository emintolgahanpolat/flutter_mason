import '../res/colors.gen.dart';
import '../res/icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme extends AppTheme {
  @override
  ColorScheme get colorScheme => const ColorScheme.light(
      primary: AppColors.primarySwatch, outlineVariant: AppColors.grey);
}

class DarkTheme extends AppTheme {
  @override
  ColorScheme get colorScheme => const ColorScheme.dark(
      secondary: AppColors.primarySwatch,
      primary: AppColors.primarySwatch,
      outlineVariant: AppColors.grey);
}

class AppTheme {
  ColorScheme colorScheme = const ColorScheme.light(
      primary: AppColors.primarySwatch, outlineVariant: AppColors.grey);

  ThemeData theme() {
    return ThemeData(
      colorScheme: colorScheme,
      fontFamily: GoogleFonts.poppins(fontWeight: FontWeight.w500).fontFamily,
      dividerTheme: const DividerThemeData(space: 0),
      appBarTheme: AppBarTheme(
          centerTitle: false,
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: colorScheme.onBrightness,
            statusBarBrightness: colorScheme.brightness,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
          )),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
        ),
      ),
      actionIconTheme: ActionIconThemeData(
        drawerButtonIconBuilder: (context) {
          return const Icon(AppIcons.menu);
        },
        endDrawerButtonIconBuilder: (context) {
          return const Icon(AppIcons.menu);
        },
        backButtonIconBuilder: (context) {
          return const Icon(AppIcons.chevronLeft);
        },
        closeButtonIconBuilder: (context) {
          return const Icon(AppIcons.xmark);
        },
      ),
    );
  }
}

extension ColorsSchemeEx on ColorScheme {
  Brightness get onBrightness =>
      brightness == Brightness.light ? Brightness.dark : Brightness.light;
}
