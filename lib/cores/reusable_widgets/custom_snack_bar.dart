import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    bool showCloseIcon = false,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    IconData? prefixIcon,
    bool showPrefixIcon = true,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
    Color? backgroundColor,
  }) {
    // Determine colors
    final bgColor = backgroundColor ?? _getBackgroundColor(type);
    final txtColor = textColor ?? Colors.white;

    // Create content with icon
    Widget contentWidget = Text(
      message,
      style: TextStyle(
        color: txtColor,
        fontSize: fontSize ?? 14.5, // Slightly larger default
        fontWeight: fontWeight ?? FontWeight.w500,
      ),
    );

    // Add prefix icon if requested
    if (showPrefixIcon) {
      final iconData = prefixIcon ?? _getPrefixIcon(type);
      contentWidget = Row(
        children: [
          Icon(
            iconData,
            color: txtColor,
            size: fontSize != null
                ? fontSize + 3
                : 18, // Icon size relative to text
          ),
          const SizedBox(width: 12),
          Expanded(child: contentWidget),
        ],
      );
    }

    final snackBar = SnackBar(
      content: contentWidget,
      backgroundColor: bgColor,
      duration: duration,
      action: action,
      showCloseIcon: showCloseIcon,
      margin: margin ?? const EdgeInsets.all(16), // Updated margin
      padding:
          padding ??
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ), // Updated padding
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4, // Added subtle elevation
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return const Color(0xFF4CAF50); // Material green
      case SnackBarType.error:
        return const Color(0xFFF44336); // Material red
      case SnackBarType.warning:
        return const Color(0xFFFF9800); // Material orange
      case SnackBarType.info:
        return const Color(0xFF2196F3); // Material blue
    }
  }

  static IconData _getPrefixIcon(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Icons.check_circle_outline;
      case SnackBarType.error:
        return Icons.error_outline;
      case SnackBarType.warning:
        return Icons.warning_amber_outlined;
      case SnackBarType.info:
        return Icons.info_outline;
    }
  }

  // Convenience methods
  static void showSuccess({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    bool showCloseIcon = false,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
    Color? backgroundColor,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.success,
      duration: duration,
      action: action,
      showCloseIcon: showCloseIcon,
      margin: margin,
      padding: padding,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textColor: textColor,
      backgroundColor: backgroundColor,
    );
  }

  static void showError({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
    bool showCloseIcon = false,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
    Color? backgroundColor,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.error,
      duration: duration,
      action: action,
      showCloseIcon: showCloseIcon,
      margin: margin,
      padding: padding,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textColor: textColor,
      backgroundColor: backgroundColor,
    );
  }

  static void showWarning({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    bool showCloseIcon = false,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
    Color? backgroundColor,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
      action: action,
      showCloseIcon: showCloseIcon,
      margin: margin,
      padding: padding,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textColor: textColor,
      backgroundColor: backgroundColor,
    );
  }

  static void showInfo({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
    SnackBarAction? action,
    bool showCloseIcon = false,
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    double? fontSize,
    FontWeight? fontWeight,
    Color? textColor,
    Color? backgroundColor,
  }) {
    show(
      context: context,
      message: message,
      type: SnackBarType.info,
      duration: duration,
      action: action,
      showCloseIcon: showCloseIcon,
      margin: margin,
      padding: padding,
      fontSize: fontSize,
      fontWeight: fontWeight,
      textColor: textColor,
      backgroundColor: backgroundColor,
    );
  }
}

enum SnackBarType { success, error, warning, info }
