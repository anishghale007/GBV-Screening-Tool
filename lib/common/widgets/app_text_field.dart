import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gbv/core/core.dart';

/// Reusable text input field with theme-consistent styling, validation,
/// and accessibility support.
class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.initialValue,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.semanticLabel,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLines;
  final int? maxLength;
  final String? semanticLabel;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleObscure() {
    setState(() => _obscureText = !_obscureText);
  }

  @override
  Widget build(BuildContext context) {
    final effectiveSuffixIcon = widget.isPassword
        ? IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: context.colorScheme.onSurfaceVariant,
            ),
            onPressed: _toggleObscure,
          )
        : widget.suffixIcon;

    return Semantics(
      label: widget.semanticLabel ?? widget.labelText ?? widget.hintText,
      textField: true,
      enabled: widget.enabled,
      child: TextFormField(
        controller: widget.controller,
        initialValue: widget.initialValue,
        focusNode: widget.focusNode,
        obscureText: _obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        inputFormatters: widget.inputFormatters,
        enabled: widget.enabled,
        readOnly: widget.readOnly,
        autofocus: widget.autofocus,
        maxLines: widget.isPassword ? 1 : widget.maxLines,
        maxLength: widget.maxLength,
        style: AppTextStyles.bodyMedium.copyWith(
          color: context.colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          helperText: widget.helperText,
          errorText: widget.errorText,
          prefixIcon: widget.prefixIcon,
          suffixIcon: effectiveSuffixIcon,
          filled: true,
          fillColor: widget.enabled
              ? context.colorScheme.surface
              : context.colorScheme.surfaceContainerHighest,
        ),
      ),
    );
  }
}
