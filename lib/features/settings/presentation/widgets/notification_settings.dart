import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/settings_constants.dart';
import '../../../../core/providers/notification_manager_provider.dart';
import '../../application/controllers/settings_controller.dart';

/// Notification settings with toggle and time picker
class NotificationSettings extends ConsumerWidget {
  const NotificationSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsControllerProvider);
    final settings = settingsState.settings;
    final controller = ref.read(settingsControllerProvider.notifier);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final primaryColor = colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Daily Quote toggle row
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      SettingsConstants.dailyQuoteLabel,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      SettingsConstants.dailyQuoteDescription,
                      style: TextStyle(
                        fontSize: 13,
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Switch.adaptive(
                value: settings.notificationsEnabled,
                onChanged: (value) {
                  controller.setNotificationsEnabled(value);
                },
                activeTrackColor: primaryColor.withValues(alpha: 0.5),
                activeThumbColor: primaryColor,
              ),
            ],
          ),
          // Time picker (only shown when enabled)
          if (settings.notificationsEnabled) ...[
            const SizedBox(height: 16),
            _TimePicker(
              hour: settings.notificationHour,
              minute: settings.notificationMinute,
              onTimeChanged: (hour, minute) {
                controller.setNotificationTime(hour, minute);
              },
              color: primaryColor,
            ),
            const SizedBox(height: 12),
            // Test notification button
            _TestNotificationButton(color: primaryColor),
          ],
        ],
      ),
    );
  }
}

class _TimePicker extends StatelessWidget {
  final int hour;
  final int minute;
  final void Function(int hour, int minute) onTimeChanged;
  final Color color;

  const _TimePicker({
    required this.hour,
    required this.minute,
    required this.onTimeChanged,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isAM = hour < 12;
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

    // Text styles for picker
    final selectedStyle = TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: colorScheme.onSurface,
    );

    final unselectedStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: colorScheme.onSurface.withValues(alpha: 0.3),
    );

    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Hour picker
          SizedBox(
            width: 70,
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                initialItem: displayHour - 1,
              ),
              onSelectedItemChanged: (index) {
                final newHour = index + 1;
                final actualHour = isAM
                    ? (newHour == 12 ? 0 : newHour)
                    : (newHour == 12 ? 12 : newHour + 12);
                onTimeChanged(actualHour, minute);
              },
              selectionOverlay: Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: color.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                ),
              ),
              children: List.generate(12, (index) {
                final h = index + 1;
                final isSelected = h == displayHour;
                return Center(
                  child: Text(
                    h.toString().padLeft(2, '0'),
                    style: isSelected ? selectedStyle : unselectedStyle,
                  ),
                );
              }),
            ),
          ),
          // Minute picker
          SizedBox(
            width: 70,
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                initialItem: minute ~/ 5,
              ),
              onSelectedItemChanged: (index) {
                onTimeChanged(hour, index * 5);
              },
              selectionOverlay: Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: color.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                ),
              ),
              children: List.generate(12, (index) {
                final m = index * 5;
                final isSelected = m == minute;
                return Center(
                  child: Text(
                    m.toString().padLeft(2, '0'),
                    style: isSelected ? selectedStyle : unselectedStyle,
                  ),
                );
              }),
            ),
          ),
          // AM/PM picker
          SizedBox(
            width: 70,
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(
                initialItem: isAM ? 0 : 1,
              ),
              onSelectedItemChanged: (index) {
                final newIsAM = index == 0;
                int newHour;
                if (newIsAM && !isAM) {
                  // PM to AM
                  newHour = hour - 12;
                  if (newHour < 0) newHour += 24;
                } else if (!newIsAM && isAM) {
                  // AM to PM
                  newHour = hour + 12;
                  if (newHour >= 24) newHour -= 24;
                } else {
                  newHour = hour;
                }
                onTimeChanged(newHour, minute);
              },
              selectionOverlay: Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                      color: color.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                ),
              ),
              children: [
                Center(
                  child: Text(
                    SettingsConstants.amLabel,
                    style: isAM ? selectedStyle : unselectedStyle,
                  ),
                ),
                Center(
                  child: Text(
                    SettingsConstants.pmLabel,
                    style: !isAM ? selectedStyle : unselectedStyle,
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

class _TestNotificationButton extends ConsumerWidget {
  final Color color;

  const _TestNotificationButton({required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton.icon(
      onPressed: () async {
        final notificationService = ref.read(notificationServiceProvider);
        await notificationService.showImmediateNotification(
          title: 'Test Notification 🔔',
          body: 'If you see this, notifications are working!',
        );

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Test notification sent!'),
              backgroundColor: color,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      icon: Icon(Icons.notifications_active, color: color, size: 18),
      label: Text(
        'Test Notification',
        style: TextStyle(
          color: color,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color.withValues(alpha: 0.3)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }
}
