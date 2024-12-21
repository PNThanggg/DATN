import 'package:flutter/material.dart';

enum SnackBarType {
  success,
  error,
  warning,
  info;

  Color get iconColor {
    switch (this) {
      case error:
        return const Color(0xFFEC4040);

      case warning:
        return const Color(0xFFFFB525);

      case info:
        return const Color(0xFF2CA2E0);

      default:
        return const Color(0xFF14B54A);
    }
  }

  Color get containerColor {
    switch (this) {
      case error:
        return const Color(0xFFFFD5D5);

      case warning:
        return const Color(0xFFFFF9E3);

      case info:
        return const Color(0xFFE3F5FF);

      default:
        return const Color(0xFFE1FFE3);
    }
  }

  IconData get icon {
    switch (this) {
      case error:
        return Icons.error_outline_rounded;

      case warning:
        return Icons.error_outline_rounded;

      case info:
        return Icons.error_outline_rounded;

      default:
        return Icons.check_circle_outline_rounded;
    }
  }

  String title(BuildContext context) {
    switch (this) {
      case error:
        return "Error";

      case warning:
        return "Warning";

      case info:
        return "Info";

      default:
        return "Successful";
    }
  }
}

void showSnackBar(
  BuildContext context, {
  SnackBarType type = SnackBarType.success,
  String title = "Success Message!",
  String subtitle = "",
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      closeIconColor: const Color(0xFF6C757D),
      padding: EdgeInsets.zero,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      backgroundColor: type.containerColor,
      dismissDirection: DismissDirection.down,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      content: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          gradient: LinearGradient(
            colors: [
              type.iconColor,
              Colors.transparent,
            ],
            stops: const [
              0.015,
              0.015,
            ],
          ),
        ),
        child: Row(
          children: [
            Container(
              alignment: Alignment.center,
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: type.iconColor,
              ),
              child: Icon(
                type.icon,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type.title(context),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: type.iconColor,
                          fontSize: 14,
                        ),
                  ),
                  subtitle.isNotEmpty
                      ? Text(
                          subtitle,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontSize: 10,
                                color: const Color(0xFF6C757D),
                                fontWeight: FontWeight.w500,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
