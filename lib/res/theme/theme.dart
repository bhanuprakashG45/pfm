import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class MaterialTheme {
  const MaterialTheme();

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFFD32F2F),
      surfaceTint: Color(0xFF9A1D1D),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFFFFDAD6),
      onPrimaryContainer: Color(0xFF68000A),
      secondary: Color(0xFF6B5B5B),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFF3D9DC),
      onSecondaryContainer: Color(0xFF4A3C3D),
      tertiary: Color(0xFF7B5733),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFDDB8),
      onTertiaryContainer: Color(0xFF3F2A0C),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF93000A),
      surface: Color(0xFFFFF7F8),
      onSurface: Color(0xFF1F1A1B),
      onSurfaceVariant: Color(0xFF4F4344),
      outline: Color(0xFF827374),
      outlineVariant: Color(0xFFD5C2C3),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF352F30),
      inversePrimary: Color(0xFFFFB3B3),
      primaryFixed: Color(0xFFFFDAD6),
      onPrimaryFixed: Color(0xFF3B000D),
      primaryFixedDim: Color(0xFFFFB3B3),
      onPrimaryFixedVariant: Color(0xFF8B1E2E),
      secondaryFixed: Color(0xFFF3D9DC),
      onSecondaryFixed: Color(0xFF2A1618),
      secondaryFixedDim: Color(0xFFD7BEC0),
      onSecondaryFixedVariant: Color(0xFF534243),
      tertiaryFixed: Color(0xFFFFDDB8),
      onTertiaryFixed: Color(0xFF281500),
      tertiaryFixedDim: Color(0xFFE8BE8F),
      onTertiaryFixedVariant: Color(0xFF5D401B),
      surfaceDim: Color(0xFFE4D6D7),
      surfaceBright: Color(0xFFFFF7F8),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFFFF0F1),
      surfaceContainer: Color(0xFFFAEAEB),
      surfaceContainerHigh: Color(0xFFF4E4E5),
      surfaceContainerHighest: Color(0xFFEEDFE0),
    );
  }

  ThemeData light() => theme(lightScheme());

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFFB3B3),
      surfaceTint: Color(0xFF8B1E2E),
      onPrimary: Color(0xFF4C0F1A),
      primaryContainer: Color(0xFF8B1E2E),
      onPrimaryContainer: Color(0xFFFFDAD6),
      secondary: Color(0xFFD7BEC0),
      onSecondary: Color(0xFF3D2B2C),
      secondaryContainer: Color(0xFF534243),
      onSecondaryContainer: Color(0xFFF3D9DC),
      tertiary: Color(0xFFE8BE8F),
      onTertiary: Color(0xFF4A2F0B),
      tertiaryContainer: Color(0xFF5D401B),
      onTertiaryContainer: Color(0xFFFFDDB8),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      errorContainer: Color(0xFF93000A),
      onErrorContainer: Color(0xFFFFDAD6),
      surface: Color(0xFF171112),
      onSurface: Color(0xFFEEDFE0),
      onSurfaceVariant: Color(0xFFD5C2C3),
      outline: Color(0xFF9E8B8D),
      outlineVariant: Color(0xFF4F4344),
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFEEDFE0),
      inversePrimary: Color(0xFFD32F2F),
      primaryFixed: Color(0xFFFFDAD6),
      onPrimaryFixed: Color(0xFF3B000D),
      primaryFixedDim: Color(0xFFFFB3B3),
      onPrimaryFixedVariant: Color(0xFF8B1E2E),
      secondaryFixed: Color(0xFFF3D9DC),
      onSecondaryFixed: Color(0xFF2A1618),
      secondaryFixedDim: Color(0xFFD7BEC0),
      onSecondaryFixedVariant: Color(0xFF534243),
      tertiaryFixed: Color(0xFFFFDDB8),
      onTertiaryFixed: Color(0xFF281500),
      tertiaryFixedDim: Color(0xFFE8BE8F),
      onTertiaryFixedVariant: Color(0xFF5D401B),
      surfaceDim: Color(0xFF171112),
      surfaceBright: Color(0xFF3E3536),
      surfaceContainerLowest: Color(0xFF120C0D),
      surfaceContainerLow: Color(0xFF1F1A1B),
      surfaceContainer: Color(0xFF231E1F),
      surfaceContainerHigh: Color(0xFF2E292A),
      surfaceContainerHighest: Color(0xFF3A3132),
    );
  }

  ThemeData dark() => theme(darkScheme());

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.poppinsTextTheme().apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );
}
