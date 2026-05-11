import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─── Brand ────────────────────────────────────────────────────────────────
  static const Color primary = Color(0xFF1A6B3C); // SocaLoca green
  static const Color primaryLight = Color(0xFF2E8B57);
  static const Color primaryDark = Color(0xFF0F4526);
  static const Color accent = Color(0xFFFFC107); // Amber highlight

  // ─── Status ───────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // ─── Match states ─────────────────────────────────────────────────────────
  static const Color liveRed = Color(0xFFE53935);
  static const Color upcomingBlue = Color(0xFF1565C0);
  static const Color playedGray = Color(0xFF757575);

  // ─── Backgrounds ──────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color inputBackground = Color(0xFFFAFAFA);
  static const Color cardBackground = Color(0xFFFFFFFF);

  // ─── Text ─────────────────────────────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ─── Borders & Dividers ───────────────────────────────────────────────────
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFEEEEEE);

  // ─── SocaLoca brand (direct from Android new_* color values) ─────────────
  static const Color socaBlack =
      Color(0xFF1C1C1C); // new_black  — text, buttons, strokes
  static const Color socaYellow =
      Color(0xFFEEFF41); // new_yellow — CTA text on black buttons
  static const Color socaPageBg =
      Color(0xFFF6F6F6); // new_white  — screen background
  static const Color socaGrey =
      Color(0xFFEAEAE8); // new_grey   — input box fill

  // ─── User type badge colours ──────────────────────────────────────────────
  static const Color playerBadge = Color(0xFF1565C0);
  static const Color coachBadge = Color(0xFF6A1B9A);
  static const Color refereeBadge = Color(0xFFFF8F00);
  static const Color clubBadge = Color(0xFF1A6B3C);
  static const Color fanBadge = Color(0xFF0277BD);
  static const Color academyBadge = Color(0xFF00695C);
  static const Color faBadge = Color(0xFF283593);
  static const Color confedBadge = Color(0xFF880E4F);
  static const Color sponsorBadge = Color(0xFFF9A825);
  static const Color charityBadge = Color(0xFF558B2F);
}
