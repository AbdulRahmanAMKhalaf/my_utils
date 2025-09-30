import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Title widget (can be Text, Image, or any widget)
  final String title;

  // Actions to display on the right side
  final List<Widget>? actions;

  // Whether to automatically show back button
  final bool automaticallyImplyLeading;

  // Custom callback for back button press
  final VoidCallback? onBack;

  // Custom leading widget (overrides automatic back button)
  final Widget? leading;

  // Preferred height of the app bar
  final double? preferredHeight;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.onBack,
    this.leading,
    this.preferredHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Title displayed in the app bar
      title: Text(title),

      // Actions displayed on the right side
      actions: actions,

      // Controls automatic back button visibility
      automaticallyImplyLeading: automaticallyImplyLeading,

      // Leading widget (back button or custom)
      leading: _buildLeadingWidget(context),
    );
  }

  // Build the leading widget based on configuration
  Widget? _buildLeadingWidget(BuildContext context) {
    // If custom leading is provided, use it
    if (leading != null) {
      return leading;
    }

    // If automatically implying leading and we can pop
    if (automaticallyImplyLeading && Navigator.canPop(context)) {
      return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: onBack ?? () => Navigator.of(context).pop(),
      );
    }

    // No leading widget
    return null;
  }

  // Required property for PreferredSizeWidget
  @override
  Size get preferredSize => Size.fromHeight(preferredHeight ?? kToolbarHeight);
}
