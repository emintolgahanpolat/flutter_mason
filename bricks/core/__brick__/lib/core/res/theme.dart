import '../res/colors.dart';
import '../res/icons.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ColorScheme darkColorScheme = ColorScheme.dark(
      secondary: AppColors.primarySwatch,
      primary: AppColors.primarySwatch,
      outlineVariant: AppColors.grey);

  static ColorScheme lightColorScheme = ColorScheme.light(
      primary: AppColors.primarySwatch, outlineVariant: AppColors.grey);

  static ColorScheme currentColorScheme(bool isDark) =>
      isDark ? darkColorScheme : lightColorScheme;
  static ThemeData theme({bool isDark = false}) {
    return ThemeData(
        useMaterial3: true,
        colorScheme: currentColorScheme(isDark),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          scrolledUnderElevation: 0,
        ),
        dividerTheme: DividerThemeData(
          space: 1,
          color: currentColorScheme(isDark).onSurface.withOpacity(0.1),
        ),
        cardTheme: CardTheme(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              side: BorderSide(
                  color: currentColorScheme(isDark).onSurface.withOpacity(0.8),
                  width: 6)),
        ),
        textTheme:
            const TextTheme(titleLarge: TextStyle(fontWeight: FontWeight.w700)),
        listTileTheme: ListTileThemeData(
          iconColor: currentColorScheme(isDark).onSurface.withOpacity(
                0.5,
              ),
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: currentColorScheme(isDark).onSurface,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
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
        iconButtonTheme: IconButtonThemeData(
            style: IconButton.styleFrom(
                backgroundColor:
                    currentColorScheme(isDark).onPrimary.withOpacity(0.5))),
        iconTheme: IconThemeData(
            color: currentColorScheme(isDark).onSurface.withOpacity(
                  0.5,
                ),
            size: 18),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.primarySwatch),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarySwatch,
                foregroundColor: currentColorScheme(isDark).onPrimary,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ))),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle: TextStyle(fontSize: 12),
          unselectedLabelStyle: TextStyle(
            fontSize: 12,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          focusedBorder: inputBorder,
          border: inputBorder,
          filled: true,
          alignLabelWithHint: true,
          fillColor: currentColorScheme(isDark).onPrimary,
          enabledBorder: inputBorder,
          disabledBorder: inputBorder,
        ));
  }

  static var inputBorder = OutlineInputBorder(
    gapPadding: 4,
    borderSide: const BorderSide(color: AppColors.grey),
    borderRadius: BorderRadius.circular(8),
  );
}
