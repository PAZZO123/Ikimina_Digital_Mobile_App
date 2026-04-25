import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand
  static const Color primary = Color(0xFF00A86B);       // Rwandan green
  static const Color primaryDark = Color(0xFF007A4D);
  static const Color primaryLight = Color(0xFF4DC494);
  static const Color primarySurface = Color(0xFFE6F7F1);

  // Secondary
  static const Color secondary = Color(0xFF1A3C5E);     // Deep navy
  static const Color secondaryLight = Color(0xFF2E5F8A);
  static const Color secondarySurface = Color(0xFFE8EFF5);

  // Accent
  static const Color accent = Color(0xFFF5A623);        // Gold/amber
  static const Color accentLight = Color(0xFFFFF3DC);

  // Semantic
  static const Color success = Color(0xFF00C896);
  static const Color successLight = Color(0xFFE6FAF5);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFEF5350);
  static const Color errorLight = Color(0xFFFFF0F0);
  static const Color info = Color(0xFF29B6F6);

  // Neutral
  static const Color background = Color(0xFFF8FAFB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF0F4F7);
  static const Color border = Color(0xFFE0E8EE);
  static const Color divider = Color(0xFFEEF2F5);

  // Text
  static const Color textPrimary = Color(0xFF0D1B2A);
  static const Color textSecondary = Color(0xFF526070);
  static const Color textHint = Color(0xFF9EB0BE);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00A86B), Color(0xFF007A4D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A3C5E), Color(0xFF2E5F8A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFF5A623), Color(0xFFE8920A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// Convenience helper — replaces GoogleFonts.sora(...) everywhere.
// Uses the 'Sora' family declared in pubspec (or falls back to Roboto
// on Android / SF Pro on iOS) with zero network calls.
TextStyle _s({
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w400,
  Color color = AppColors.textPrimary,
}) =>
    TextStyle(
      fontFamily: 'Sora',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );

// Dark-mode adaptive color palette — used by AppTheme.darkTheme.
class _DarkColors {
  static const bg           = Color(0xFF0F1117);
  static const surface      = Color(0xFF1A1D2E);
  static const surfaceVar   = Color(0xFF252840);
  static const border       = Color(0xFF2E3250);
  static const textPrimary  = Color(0xFFE8EAED);
  static const textSecondary= Color(0xFF9AA0B4);
  static const textHint     = Color(0xFF5A6180);
}

TextStyle _sd({
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w400,
  Color color = _DarkColors.textPrimary,
}) =>
    TextStyle(
      fontFamily: 'Sora',
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );

/// Context extension — returns the right colour for the current theme brightness.
/// Use `context.bg`, `context.surface`, etc. everywhere instead of AppColors.*
extension AppColorsX on BuildContext {
  bool get _isDark => Theme.of(this).brightness == Brightness.dark;

  Color get bg            => _isDark ? _DarkColors.bg          : AppColors.background;
  Color get cardSurface   => _isDark ? _DarkColors.surface     : AppColors.surface;
  Color get surfaceVar    => _isDark ? _DarkColors.surfaceVar  : AppColors.surfaceVariant;
  Color get borderColor   => _isDark ? _DarkColors.border      : AppColors.border;
  Color get textPrim      => _isDark ? _DarkColors.textPrimary : AppColors.textPrimary;
  Color get textSec       => _isDark ? _DarkColors.textSecondary : AppColors.textSecondary;
  Color get textHintColor => _isDark ? _DarkColors.textHint   : AppColors.textHint;
  Color get primarySurf   => _isDark
      ? AppColors.primary.withOpacity(0.18)
      : AppColors.primarySurface;
  Color get errorSurf     => _isDark
      ? AppColors.error.withOpacity(0.15)
      : AppColors.errorLight;
  Color get warningSurf   => _isDark
      ? AppColors.warning.withOpacity(0.15)
      : AppColors.accentLight;
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.light,
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        background: AppColors.background,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Sora',

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.border,
        centerTitle: false,
        titleTextStyle: _s(fontSize: 18, fontWeight: FontWeight.w600),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: _s(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: _s(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: _s(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        labelStyle: _s(fontSize: 14, color: AppColors.textSecondary),
        hintStyle: _s(fontSize: 14, color: AppColors.textHint),
      ),

      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textHint,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: AppColors.primarySurface,
        selectedColor: AppColors.primary,
        labelStyle: _s(fontSize: 12, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 0,
      ),

      textTheme: TextTheme(
        displayLarge:  _s(fontSize: 32, fontWeight: FontWeight.w700),
        displayMedium: _s(fontSize: 28, fontWeight: FontWeight.w700),
        displaySmall:  _s(fontSize: 24, fontWeight: FontWeight.w600),
        headlineLarge: _s(fontSize: 22, fontWeight: FontWeight.w600),
        headlineMedium:_s(fontSize: 20, fontWeight: FontWeight.w600),
        headlineSmall: _s(fontSize: 18, fontWeight: FontWeight.w600),
        titleLarge:    _s(fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium:   _s(fontSize: 15, fontWeight: FontWeight.w500),
        titleSmall:    _s(fontSize: 14, fontWeight: FontWeight.w500),
        bodyLarge:     _s(fontSize: 15, fontWeight: FontWeight.w400),
        bodyMedium:    _s(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
        bodySmall:     _s(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textSecondary),
        labelLarge:    _s(fontSize: 13, fontWeight: FontWeight.w600),
        labelMedium:   _s(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary),
        labelSmall:    _s(fontSize: 11, fontWeight: FontWeight.w500, color: AppColors.textHint),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        brightness: Brightness.dark,
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: _DarkColors.surface,
        error: AppColors.error,
      ),
      scaffoldBackgroundColor: _DarkColors.bg,
      fontFamily: 'Sora',

      appBarTheme: AppBarTheme(
        backgroundColor: _DarkColors.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: _DarkColors.border,
        centerTitle: false,
        titleTextStyle: _sd(fontSize: 18, fontWeight: FontWeight.w600),
        iconTheme: const IconThemeData(color: _DarkColors.textPrimary),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          textStyle: _sd(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14)),
          textStyle: _sd(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: _sd(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: _DarkColors.surfaceVar,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: _DarkColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              const BorderSide(color: AppColors.error, width: 1.5),
        ),
        labelStyle: _sd(fontSize: 14, color: _DarkColors.textSecondary),
        hintStyle: _sd(fontSize: 14, color: _DarkColors.textHint),
      ),

      cardTheme: CardThemeData(
        color: _DarkColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: _DarkColors.border, width: 1),
        ),
        margin: EdgeInsets.zero,
      ),

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _DarkColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: _DarkColors.textHint,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: _DarkColors.surfaceVar,
        selectedColor: AppColors.primary,
        labelStyle: _sd(fontSize: 12, fontWeight: FontWeight.w500),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
      ),

      dividerTheme: const DividerThemeData(
        color: _DarkColors.border,
        thickness: 1,
        space: 0,
      ),

      dialogTheme: DialogThemeData(
        backgroundColor: _DarkColors.surface,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
      ),

      textTheme: TextTheme(
        displayLarge:   _sd(fontSize: 32, fontWeight: FontWeight.w700),
        displayMedium:  _sd(fontSize: 28, fontWeight: FontWeight.w700),
        displaySmall:   _sd(fontSize: 24, fontWeight: FontWeight.w600),
        headlineLarge:  _sd(fontSize: 22, fontWeight: FontWeight.w600),
        headlineMedium: _sd(fontSize: 20, fontWeight: FontWeight.w600),
        headlineSmall:  _sd(fontSize: 18, fontWeight: FontWeight.w600),
        titleLarge:     _sd(fontSize: 16, fontWeight: FontWeight.w600),
        titleMedium:    _sd(fontSize: 15, fontWeight: FontWeight.w500),
        titleSmall:     _sd(fontSize: 14, fontWeight: FontWeight.w500),
        bodyLarge:      _sd(fontSize: 15, fontWeight: FontWeight.w400),
        bodyMedium:     _sd(fontSize: 14, fontWeight: FontWeight.w400,
                            color: _DarkColors.textSecondary),
        bodySmall:      _sd(fontSize: 12, fontWeight: FontWeight.w400,
                            color: _DarkColors.textSecondary),
        labelLarge:     _sd(fontSize: 13, fontWeight: FontWeight.w600),
        labelMedium:    _sd(fontSize: 12, fontWeight: FontWeight.w500,
                            color: _DarkColors.textSecondary),
        labelSmall:     _sd(fontSize: 11, fontWeight: FontWeight.w500,
                            color: _DarkColors.textHint),
      ),
    );
  }
}
