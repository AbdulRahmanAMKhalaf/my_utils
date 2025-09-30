import 'package:flutter/material.dart';
// import 'package:my_messanger_app/l10n/app_localizations.dart';

class CustomPasswordTextField extends StatelessWidget {
  const CustomPasswordTextField({
    super.key,
    this.sufIcon,
    required this.controller,
    this.onFieldSubmitted,
    this.secureText = true,
    this.suffixButton,
  });

  final TextEditingController controller;
  final void Function(String)? onFieldSubmitted;
  final bool secureText;

  final IconData? sufIcon;

  final void Function()? suffixButton;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableSuggestions: true,
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Password'),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,

        ///--------------------[ Icons ]---------------------///
        suffixIcon: sufIcon != null
            ? IconButton(onPressed: suffixButton, icon: Icon(sufIcon))
            : SizedBox(),
        prefixIcon: Icon(Icons.key_rounded),
      ),

      keyboardType: TextInputType.visiblePassword,

      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Password';
          // } if (!MyRegex.passwordValidate(value)) {
          //   return MyRegex.passwordConstraints;
        } else {
          return null;
        }
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
