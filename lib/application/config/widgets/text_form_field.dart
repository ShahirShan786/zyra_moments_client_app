import 'package:flutter/material.dart';
import 'package:zyra_momments_app/application/config/theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final int maxLines;
  final int? maxLength;
  final bool readOnly;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry contentPadding;
  final Color? fillColor;
  final bool filled;
  final InputBorder border;

  const CustomTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.labelText = '',
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.fillColor,
    this.filled = true,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    this.border = const OutlineInputBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        maxLength: maxLength,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText.isNotEmpty ? labelText : null,
          hintStyle: TextStyle(color: AppTheme.darkTextColorSecondary),
          labelStyle: const TextStyle(color: Colors.white),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          filled: filled,
          fillColor: const Color.fromARGB(255, 38, 37, 37),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
          errorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}

class SecondaryTextFeild extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final int maxLines;
  final int? maxLength;
  final bool readOnly;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry contentPadding;
  final Color? fillColor;
  final bool filled;
  final InputBorder border;

  const SecondaryTextFeild({
    super.key,
    this.controller,
    required this.hintText,
    this.labelText = '',
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.fillColor,
    this.filled = true,
    this.contentPadding =
        const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
    this.border = const OutlineInputBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: AppTheme.darkTextColorSecondary),
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        maxLines: maxLines,
        maxLength: maxLength,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        onChanged: onChanged,
        onFieldSubmitted: onFieldSubmitted,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: labelText.isNotEmpty ? labelText : null,
          hintStyle: TextStyle(color: AppTheme.darkTextColorSecondary),
          labelStyle: TextStyle(color: AppTheme.darkTextColorSecondary),
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          filled: filled,
          fillColor: AppTheme.darkSecondaryColor,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          border: border,
          enabledBorder: border,
          focusedBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.white, width: 1),
          ),
          errorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: border.copyWith(
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
