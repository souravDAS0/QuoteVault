import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/settings_constants.dart';
import '../../domain/entities/user_settings.dart';
import '../../application/controllers/settings_controller.dart';

/// Preview card showing how quote will look with current settings
class QuotePreviewCard extends ConsumerWidget {
  const QuotePreviewCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final settings = settingsState.settings;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).primaryColor;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            isDark ? const Color(0xFF1A2F3A) : const Color(0xFF2A4A5A),
            isDark ? const Color(0xFF0F1A22) : const Color(0xFF1A3040),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Quote marks icon
          Icon(
            Icons.format_quote,
            color: primaryColor.withValues(alpha: 0.6),
            size: 28,
          ),
          const SizedBox(height: 16),
          // Quote text
          Text(
            SettingsConstants.previewQuote,
            style: _getQuoteTextStyle(settings),
          ),
          const SizedBox(height: 12),
          // Author row with heart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                SettingsConstants.previewAuthor,
                style: GoogleFonts.barlow(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.favorite, color: primaryColor, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  TextStyle _getQuoteTextStyle(UserSettings settings) {
    final fontSize = settings.fontSizePreset.value;

    return GoogleFonts.albertSans(
      fontSize: fontSize,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      height: 1.4,
    );
  }
}
