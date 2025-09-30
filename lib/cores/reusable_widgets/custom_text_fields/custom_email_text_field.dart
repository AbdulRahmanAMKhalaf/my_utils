import 'package:flutter/material.dart';
// import 'package:my_messanger_app/l10n/app_localizations.dart';

class CustomEmailTextField extends StatelessWidget {
  const CustomEmailTextField({
    super.key,
    this.sufIcon,

    required this.controller,
    this.onFieldSubmitted,
    this.secureText = false,
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
      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Email Address'),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,

        ///--------------------[ Icons ]---------------------///
        suffixIcon: sufIcon != null
            ? IconButton(onPressed: suffixButton, icon: Icon(sufIcon))
            : SizedBox(),
        prefixIcon: Icon(Icons.email_outlined),
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter Email Address';
        }
        // if (!MyRegex.emailValidate(value)) {
        //   return MyRegex.emailConstraints;
        // }
        else {
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
