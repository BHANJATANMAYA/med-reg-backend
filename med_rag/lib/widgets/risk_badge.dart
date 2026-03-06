import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Coloured pill badge that displays the risk level.
class RiskBadge extends StatelessWidget {
  final String? riskLevel;

  const RiskBadge({super.key, required this.riskLevel});

  String get _label {
    switch (riskLevel?.toLowerCase()) {
      case 'low':
        return 'Low Risk';
      case 'moderate':
        return 'Moderate Risk';
      case 'high':
        return 'High Risk';
      default:
        return 'Unknown';
    }
  }

  IconData get _icon {
    switch (riskLevel?.toLowerCase()) {
      case 'low':
        return Icons.check_circle_outline;
      case 'moderate':
        return Icons.warning_amber_rounded;
      case 'high':
        return Icons.error_outline;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.riskColor(riskLevel);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: 18, color: color),
          const SizedBox(width: 8),
          Text(
            _label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
