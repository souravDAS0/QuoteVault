import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/config/theme/app_typography.dart';
import '../../../auth/domain/entities/qv_user.dart';
import '../../application/controllers/profile_controller.dart';

/// Bottom sheet for editing user profile
class EditProfileSheet extends ConsumerStatefulWidget {
  final QvUser user;

  const EditProfileSheet({super.key, required this.user});

  @override
  ConsumerState<EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends ConsumerState<EditProfileSheet> {
  late TextEditingController _nameController;
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.displayName);
    _nameController.addListener(_checkForChanges);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _checkForChanges() {
    setState(() {
      _hasChanges =
          _nameController.text.trim() != widget.user.displayName ||
          _selectedImage != null;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _hasChanges = true;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
      }
    }
  }

  void _showImageSourceSelector(ColorScheme colorScheme) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.photo_library, color: colorScheme.tertiary),
              title: Text(
                'Choose from Gallery',
                style: AppTypography.bodyLarge(color: colorScheme.onSurface),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt, color: colorScheme.tertiary),
              title: Text(
                'Take Photo',
                style: AppTypography.bodyLarge(color: colorScheme.onSurface),
              ),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSave() async {
    final controller = ref.read(profileControllerProvider.notifier);

    // Update avatar if selected
    if (_selectedImage != null) {
      await controller.updateAvatar(_selectedImage!.path);
    }

    // Update display name if changed
    if (_nameController.text.trim() != widget.user.displayName) {
      await controller.updateDisplayName(_nameController.text.trim());
    }

    final state = ref.read(profileControllerProvider);
    if (state.updateError == null && mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final profileState = ref.watch(profileControllerProvider);

    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom + 36,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: colorScheme.outline,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            'Edit Profile',
            style: AppTypography.headlineMedium(color: colorScheme.onSurface),
          ),
          const SizedBox(height: 32),

          // Avatar
          Stack(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.tertiary.withValues(alpha: 0.2),
                ),
                child: _selectedImage != null
                    ? ClipOval(
                        child: Image.file(_selectedImage!, fit: BoxFit.cover),
                      )
                    : widget.user.photoUrl != null
                    ? ClipOval(
                        child: Image.network(
                          widget.user.photoUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildDefaultAvatar(colorScheme),
                        ),
                      )
                    : _buildDefaultAvatar(colorScheme),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => _showImageSourceSelector(colorScheme),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.tertiary,
                      border: Border.all(color: colorScheme.surface, width: 3),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: colorScheme.surface,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Display Name Field
          TextField(
            controller: _nameController,
            style: AppTypography.bodyLarge(color: colorScheme.onSurface),
            cursorColor: colorScheme.tertiary,
            decoration: InputDecoration(
              labelText: 'Display Name',
              labelStyle: AppTypography.bodyMedium(
                color: colorScheme.onSurfaceVariant,
              ),
              filled: true,
              fillColor: colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colorScheme.outline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: colorScheme.tertiary, width: 2),
              ),
            ),
          ),

          // Error message
          if (profileState.updateError != null) ...[
            const SizedBox(height: 16),
            Text(
              profileState.updateError!,
              style: AppTypography.caption(color: colorScheme.error),
            ),
          ],

          const SizedBox(height: 24),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    onPressed: profileState.isUpdating
                        ? null
                        : () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: colorScheme.outline),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTypography.bodyLarge(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: (_hasChanges && !profileState.isUpdating)
                        ? _handleSave
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.tertiary,
                      disabledBackgroundColor: colorScheme.outline,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: profileState.isUpdating
                        ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                colorScheme.surface,
                              ),
                            ),
                          )
                        : Text(
                            'Save',
                            style: AppTypography.bodyLarge(
                              color: colorScheme.surface,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultAvatar(ColorScheme colorScheme) {
    return Center(
      child: Icon(Icons.person, size: 50, color: colorScheme.tertiary),
    );
  }
}
