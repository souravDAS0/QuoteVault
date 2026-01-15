import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/sharing_constants.dart';
import '../../../home_feed/domain/entities/quote.dart';
import '../../domain/entities/share_template.dart';
import '../../application/providers/share_providers.dart';
import '../widgets/quote_card_template_classic.dart';
import '../widgets/quote_card_template_minimal.dart';
import '../widgets/quote_card_template_gradient.dart';

/// Bottom sheet for sharing quotes
class ShareQuoteSheet extends ConsumerStatefulWidget {
  final Quote quote;

  const ShareQuoteSheet({super.key, required this.quote});

  /// Shows the share sheet
  static Future<void> show(BuildContext context, {required Quote quote}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ShareQuoteSheet(quote: quote),
    );
  }

  @override
  ConsumerState<ShareQuoteSheet> createState() => _ShareQuoteSheetState();
}

class _ShareQuoteSheetState extends ConsumerState<ShareQuoteSheet> {
  ShareTemplate? _selectedTemplate;
  bool _isSharing = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    // Default to classic template
    _selectedTemplate = const ShareTemplate.minimal();
  }

  Future<void> _handleShareAsText() async {
    setState(() => _isSharing = true);
    try {
      final service = ref.read(shareServiceProvider);
      await service.shareAsText(widget.quote);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(SharingConstants.sharingFailed)));
      }
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  Future<void> _handleShareAsImage() async {
    if (_selectedTemplate == null) return;

    setState(() => _isSharing = true);
    try {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final service = ref.read(shareServiceProvider);
      await service.shareAsImage(
        widget.quote,
        _selectedTemplate!,
        isDark: isDark,
      );
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(SharingConstants.sharingFailed)));
      }
    } finally {
      if (mounted) {
        setState(() => _isSharing = false);
      }
    }
  }

  Future<void> _handleSaveImage() async {
    if (_selectedTemplate == null) return;

    setState(() => _isSaving = true);
    try {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      final service = ref.read(shareServiceProvider);
      final path = await service.saveImageToDevice(
        widget.quote,
        _selectedTemplate!,
        isDark: isDark,
      );
      if (mounted) {
        Navigator.pop(context);
        if (path != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Image saved to:\n$path'),
              duration: const Duration(seconds: 4),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(SharingConstants.imageSaveFailed)),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(SharingConstants.imageSaveFailed)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  /// Build preview widget based on selected template
  Widget _buildPreviewWidget(ShareTemplate template, bool isDark) {
    return template.map(
      classic: (_) =>
          QuoteCardTemplateClassic(quote: widget.quote, isDark: isDark),
      minimal: (_) =>
          QuoteCardTemplateMinimal(quote: widget.quote, isDark: isDark),
      gradient: (_) =>
          QuoteCardTemplateGradient(quote: widget.quote, isDark: isDark),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColorsDark.surface : AppColorsLight.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColorsDark.divider : AppColorsLight.divider,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Close button
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    color: isDark
                        ? AppColorsDark.textSecondary
                        : AppColorsLight.textSecondary,
                  ),
                ),
                Expanded(
                  child: Text(
                    SharingConstants.shareQuote,
                    style: AppTypography.headlineLarge(
                      color: isDark
                          ? AppColorsDark.textPrimary
                          : AppColorsLight.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 24), // Balance the close button
              ],
            ),
          ),
          // Preview Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 280,
                  maxHeight: 350,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: SizedBox(
                    width: 400,
                    height: 500,
                    child: _selectedTemplate != null
                        ? _buildPreviewWidget(_selectedTemplate!, isDark)
                        : const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Choose Style section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  SharingConstants.chooseStyle,
                  style: AppTypography.bodyLarge(
                    color: isDark
                        ? AppColorsDark.textPrimary
                        : AppColorsLight.textPrimary,
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Template selection
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _TemplateOption(
                        label: SharingConstants.templateMinimal,
                        isSelected: _selectedTemplate is MinimalTemplate,
                        onTap: () {
                          setState(
                            () => _selectedTemplate =
                                const ShareTemplate.minimal(),
                          );
                        },
                        isDark: isDark,
                        icon: const Text(
                          'Abc',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _TemplateOption(
                        label: SharingConstants.templateGradient,
                        isSelected: _selectedTemplate is GradientTemplate,
                        onTap: () {
                          setState(
                            () => _selectedTemplate =
                                const ShareTemplate.gradient(),
                          );
                        },
                        isDark: isDark,
                        showGradient: true,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _TemplateOption(
                        label: SharingConstants.templateClassic,
                        isSelected: _selectedTemplate is ClassicTemplate,
                        onTap: () {
                          setState(
                            () => _selectedTemplate =
                                const ShareTemplate.classic(),
                          );
                        },
                        isDark: isDark,
                        icon: const Text(
                          'BOLD',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Action buttons
          Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              MediaQuery.of(context).padding.bottom + 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (_isSaving || _isSharing)
                        ? null
                        : _handleShareAsImage,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: isDark
                          ? AppColorsDark.accentTeal
                          : AppColorsLight.secondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSharing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.drive_folder_upload,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                SharingConstants.shareAsImage,
                                style: AppTypography.bodyMedium(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 48,
                  child: Row(
                    children: [
                      // Share as Text
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: (_isSaving || _isSharing)
                                ? null
                                : _handleShareAsText,
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(
                                color: isDark
                                    ? AppColorsDark.border
                                    : AppColorsLight.border,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              SharingConstants.shareAsText,
                              style: AppTypography.bodyMedium(
                                color: isDark
                                    ? AppColorsDark.textSecondary
                                    : AppColorsLight.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            onPressed: (_isSaving || _isSharing)
                                ? null
                                : _handleSaveImage,
                            icon: Icon(
                              Icons.download,
                              size: 18,
                              color: isDark
                                  ? AppColorsDark.accentTeal
                                  : AppColorsLight.accentTeal,
                            ),
                            label: _isSaving
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.teal,
                                    ),
                                  )
                                : Text(
                                    SharingConstants.saveImage,
                                    style: AppTypography.bodyMedium(
                                      color: isDark
                                          ? AppColorsDark.accentTeal
                                          : AppColorsLight.accentTeal,
                                    ),
                                  ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(
                                color: isDark
                                    ? AppColorsDark.accentTeal
                                    : AppColorsLight.accentTeal,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TemplateOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;
  final Widget? icon;
  final bool showGradient;

  const _TemplateOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
    this.icon,
    this.showGradient = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          // Preview box
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              gradient: showGradient
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColorsDark.secondary,
                        AppColorsDark.accentTeal,
                      ],
                    )
                  : null,
              color: showGradient
                  ? null
                  : (isDark ? AppColorsDark.surface : AppColorsLight.surface),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? (isDark
                          ? AppColorsDark.accentTeal
                          : AppColorsLight.accentTeal)
                    : (isDark ? AppColorsDark.border : AppColorsLight.border),
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Center(
              child: icon != null
                  ? DefaultTextStyle(
                      style: TextStyle(
                        color: showGradient
                            ? Colors.white
                            : (isDark
                                  ? AppColorsDark.textPrimary
                                  : AppColorsLight.textPrimary),
                      ),
                      child: icon!,
                    )
                  : Icon(Icons.gradient_rounded, size: 32, color: Colors.white),
            ),
          ),
          const SizedBox(height: 8),
          // Label
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSelected)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Icon(
                    Icons.check_circle,
                    size: 16,
                    color: isDark
                        ? AppColorsDark.accentTeal
                        : AppColorsLight.accentTeal,
                  ),
                ),
              Text(
                label,
                textAlign: TextAlign.center,
                style:
                    AppTypography.caption(
                      color: isSelected
                          ? (isDark
                                ? AppColorsDark.accentTeal
                                : AppColorsLight.accentTeal)
                          : (isDark
                                ? AppColorsDark.textSecondary
                                : AppColorsLight.textSecondary),
                    ).copyWith(
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
