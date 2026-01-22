import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/domain/entities/log_entry.dart';
import '../../../../core/domain/entities/log_level.dart';

class LogEntryCard extends StatefulWidget {
  final LogEntry entry;

  const LogEntryCard({
    super.key,
    required this.entry,
  });

  @override
  State<LogEntryCard> createState() => _LogEntryCardState();
}

class _LogEntryCardState extends State<LogEntryCard> {
  bool _isExpanded = false;

  Color _getLevelColor(BuildContext context) {
    switch (widget.entry.level) {
      case LogLevel.debug:
        return Colors.blue.shade100;
      case LogLevel.info:
        return Colors.green.shade100;
      case LogLevel.warning:
        return Colors.orange.shade100;
      case LogLevel.error:
        return Colors.red.shade100;
    }
  }

  Color _getLevelTextColor(BuildContext context) {
    switch (widget.entry.level) {
      case LogLevel.debug:
        return Colors.blue.shade900;
      case LogLevel.info:
        return Colors.green.shade900;
      case LogLevel.warning:
        return Colors.orange.shade900;
      case LogLevel.error:
        return Colors.red.shade900;
    }
  }

  IconData _getLevelIcon() {
    switch (widget.entry.level) {
      case LogLevel.debug:
        return Icons.bug_report;
      case LogLevel.info:
        return Icons.info;
      case LogLevel.warning:
        return Icons.warning;
      case LogLevel.error:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, HH:mm:ss');
    final timestamp = dateFormat.format(widget.entry.timestamp);
    final hasStackTrace = widget.entry.stackTrace != null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: _getLevelColor(context),
        border: Border.all(
          color: _getLevelTextColor(context),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: hasStackTrace
            ? () => setState(() => _isExpanded = !_isExpanded)
            : null,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Level icon, source badge, and timestamp
              Row(
                children: [
                  Icon(
                    _getLevelIcon(),
                    color: _getLevelTextColor(context),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getLevelTextColor(context),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.entry.source,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    timestamp,
                    style: TextStyle(
                      color: _getLevelTextColor(context),
                      fontSize: 12,
                    ),
                  ),
                  if (hasStackTrace) ...[
                    const SizedBox(width: 8),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: _getLevelTextColor(context),
                      size: 20,
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              // Message
              Text(
                widget.entry.message,
                style: TextStyle(
                  color: _getLevelTextColor(context),
                  fontSize: 14,
                ),
              ),
              // Stack trace (expandable)
              if (hasStackTrace && _isExpanded) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.entry.stackTrace!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
