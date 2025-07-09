// Flutter imports:

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../assets.gen.dart';
import '../colors.gen.dart';

abstract class AppTheme {
  Color get scaffoldBackgroundColor;
  ColorScheme get colorScheme;
  PlaceholderTheme get placeholderTheme;
  ThemeData theme() {
    return ThemeData(
      extensions: [placeholderTheme],
      useMaterial3: true,
      colorScheme: colorScheme,
      visualDensity: VisualDensity.standard,
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        actionsPadding: const EdgeInsets.only(right: 16),
        backgroundColor: scaffoldBackgroundColor,
        foregroundColor: colorScheme.onSurface,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: colorScheme.onBrightness,
          statusBarBrightness: colorScheme.brightness,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarDividerColor: Colors.transparent,
        ),
      ),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      fontFamily: GoogleFonts.poppins().fontFamily,
      dividerTheme: DividerThemeData(space: 1, color: colorScheme.outline),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? colorScheme.primary
              : colorScheme.surface;
        }),
        trackColor: WidgetStateProperty.all(colorScheme.outline),
        overlayColor: WidgetStateProperty.all(
          colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
        linearTrackColor: colorScheme.surface,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      splashColor: colorScheme.surface.withValues(alpha: 0.2),
      splashFactory: InkSparkle.splashFactory,
      cardTheme: const CardThemeData(
        clipBehavior: Clip.antiAlias,
        elevation: 0,
      ),
      chipTheme: ChipThemeData(
        color: WidgetStateColor.resolveWith((states) {
          return states.contains(WidgetState.selected)
              ? colorScheme.primary.withValues(alpha: 0.2)
              : colorScheme.surface;
        }),
        labelStyle: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSurface),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        labelPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colorScheme.surfaceContainerHighest),
        ),
        elevation: 0,
      ),
      popupMenuTheme: PopupMenuThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: colorScheme.onSurface.withValues(alpha: 0.1)),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        splashFactory: NoSplash.splashFactory,
        labelColor: AppColors.primarySwatch,
        unselectedLabelColor: colorScheme.onSurface.withValues(alpha: 0.5),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        dividerColor: colorScheme.outline,
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        labelPadding: const EdgeInsets.symmetric(horizontal: 8),
        indicatorAnimation: TabIndicatorAnimation.elastic,
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      textTheme: textTheme,
      listTileTheme: ListTileThemeData(iconColor: colorScheme.onSurface),
      actionIconTheme: ActionIconThemeData(
        drawerButtonIconBuilder: (context) {
          return const Icon(Icons.menu);
        },
        endDrawerButtonIconBuilder: (context) {
          return const Icon(Icons.menu);
        },
        backButtonIconBuilder: (context) {
          return const Icon(Icons.chevron_left);
        },
        closeButtonIconBuilder: (context) {
          return const Icon(Icons.close);
        },
      ),
      iconTheme: IconThemeData(
        color: colorScheme.onSurface.withValues(alpha: 0.5),
        size: 24,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(padding: const EdgeInsets.all(2)),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          side: BorderSide(color: colorScheme.primary),
          padding: const EdgeInsets.all(16),
          iconColor: colorScheme.primary,
          foregroundColor: colorScheme.primary,
          surfaceTintColor: colorScheme.primary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: colorScheme.primary,
          elevation: 0,
          splashFactory: InkSparkle.splashFactory,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.all(16),
          foregroundColor: Colors.white,
          iconColor: Colors.white,
          textStyle: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: colorScheme.surface,
        indicatorColor: colorScheme.primary,
        selectedIconTheme: const IconThemeData(color: Colors.white, size: 24),
      ),
      navigationBarTheme: NavigationBarThemeData(
        height: 56,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          return IconThemeData(
            color: states.contains(WidgetState.selected)
                ? colorScheme.primary
                : colorScheme.onSurface.withValues(alpha: 0.5),
            size: 24,
          );
        }),
        indicatorColor: Colors.transparent,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        labelPadding: const EdgeInsets.all(0),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        elevation: 1,
        backgroundColor: colorScheme.surface,
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        checkColor: WidgetStateProperty.all(colorScheme.surface),
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primary;
          }
          return Colors.transparent;
        }),
        side: BorderSide(color: colorScheme.onSurface),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        focusedBorder: inputBorder,
        border: inputBorder,
        filled: true,
        errorMaxLines: 2,
        alignLabelWithHint: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        hintStyle: TextStyle(
          color: colorScheme.onSurface.withValues(alpha: 0.2),
        ),
        fillColor: colorScheme.surface,
        enabledBorder: inputBorder,
        disabledBorder: inputBorder,
      ),
    );
  }

  TextTheme get textTheme => const TextTheme(
    displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
    displayMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    displaySmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    headlineLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    headlineSmall: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    labelMedium: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
    labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
    titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
  );
  OutlineInputBorder get inputBorder => OutlineInputBorder(
    gapPadding: 4,
    borderSide: BorderSide(color: colorScheme.surfaceContainerHighest),
    borderRadius: BorderRadius.circular(8),
  );
}

class PlaceholderTheme extends ThemeExtension<PlaceholderTheme> {
  final AssetGenImage? image;
  final Color baseColor;
  final Color highlightColor;
  PlaceholderTheme({
    this.image,
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  ThemeExtension<PlaceholderTheme> copyWith({
    AssetGenImage? image,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return PlaceholderTheme(
      image: image ?? this.image,
      baseColor: baseColor ?? this.baseColor,
      highlightColor: highlightColor ?? this.highlightColor,
    );
  }

  @override
  ThemeExtension<PlaceholderTheme> lerp(
    covariant ThemeExtension<PlaceholderTheme>? other,
    double t,
  ) {
    if (other is! PlaceholderTheme) return this;
    return PlaceholderTheme(
      image: other.image,
      baseColor: other.baseColor,
      highlightColor: other.highlightColor,
    );
  }
}

extension ColorsSchemeEx on ColorScheme {
  Brightness get onBrightness =>
      brightness == Brightness.light ? Brightness.dark : Brightness.light;
}
