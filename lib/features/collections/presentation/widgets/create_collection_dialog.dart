import 'package:flutter/material.dart';

import '../../../../core/config/theme/app_typography.dart';
import '../../../../core/constants/collections_constants.dart';

/// Dialog for creating a new collection
class CreateCollectionDialog extends StatefulWidget {
  const CreateCollectionDialog({super.key});

  /// Shows the dialog and returns the collection name if created
  static Future<String?> show(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) => const CreateCollectionDialog(),
    );
  }

  @override
  State<CreateCollectionDialog> createState() => _CreateCollectionDialogState();
}

class _CreateCollectionDialogState extends State<CreateCollectionDialog> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      backgroundColor: colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        CollectionsConstants.createCollection,
        style: AppTypography.headlineLarge(color: colorScheme.onSurface),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Name field
            TextFormField(
              controller: _nameController,
              autofocus: true,
              style: AppTypography.bodyLarge(color: colorScheme.onSurface),
              decoration: InputDecoration(
                labelText: CollectionsConstants.collectionName,
                hintText: CollectionsConstants.collectionNameHint,
                labelStyle: AppTypography.bodyMedium(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                hintStyle: AppTypography.bodyMedium(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.error),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.error, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return CollectionsConstants.collectionNameRequired;
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Description field (optional)
            TextFormField(
              controller: _descriptionController,
              maxLines: 2,
              style: AppTypography.bodyLarge(color: colorScheme.onSurface),
              decoration: InputDecoration(
                labelText: CollectionsConstants.descriptionOptional,
                hintText: CollectionsConstants.descriptionHint,
                labelStyle: AppTypography.bodyMedium(
                  color: colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                hintStyle: AppTypography.bodyMedium(
                  color: colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            CollectionsConstants.cancel,
            style: AppTypography.bodyMedium(
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ),
        FilledButton(
          onPressed: _handleCreate,
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            CollectionsConstants.create,
            style: AppTypography.bodyMedium(color: colorScheme.onSecondary),
          ),
        ),
      ],
    );
  }

  void _handleCreate() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.pop(context, _nameController.text.trim());
    }
  }
}
