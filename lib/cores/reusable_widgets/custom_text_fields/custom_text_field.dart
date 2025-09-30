import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.sufIcon,
    this.preIcon,
    required this.controller,
    this.onFieldSubmitted,
    this.secureText = false,
    required this.label,
    this.suffixButton,
    this.onTap,
    this.readOnly = false,
  });

  final String label;
  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final bool secureText;

  final IconData? preIcon;
  final IconData? sufIcon;

  final void Function()? suffixButton;
  final void Function()? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      enableSuggestions: true,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      decoration: InputDecoration(
        label: Padding(padding: const EdgeInsets.all(8.0), child: Text(label)),
        floatingLabelBehavior: FloatingLabelBehavior.never,

        ///--------------------[ Icons ]---------------------///
        suffixIcon: sufIcon != null
            ? IconButton(onPressed: suffixButton, icon: Icon(sufIcon))
            : null,
        prefixIcon: preIcon != null ? Icon(preIcon) : null,
      ),
      keyboardType: TextInputType.text,
      onTap: onTap,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter your $label';
        }
        return null;
      },
      onFieldSubmitted: onFieldSubmitted,
      controller: controller,
      autocorrect: true,
      cursorColor: Theme.of(context).brightness == Brightness.light
          ? Colors.black
          : Colors.white,
      textAlignVertical: TextAlignVertical.center,
      showCursor: true,
      obscureText: secureText,
    );
  }
}
