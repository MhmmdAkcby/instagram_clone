import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPass;
  final String hintText;
  final TextInputType textInputType;
  final IconData? icon;
  final Function()? onChange;
  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
    required this.textInputType,
    this.icon,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: textEditingController,
      decoration: _inputDec(inputBorder),
      keyboardType: textInputType,
      obscureText: isPass,
    );
  }

  InputDecoration _inputDec(OutlineInputBorder inputBorder) {
    return InputDecoration(
      hintText: hintText,
      border: inputBorder,
      focusedBorder: inputBorder,
      enabledBorder: inputBorder,
      filled: true,
      contentPadding: const _WidgetEdgeInsets.contentPadding(),
      suffixIcon: IconButton(onPressed: onChange, icon: Icon(icon)),
    );
  }
}

class _WidgetEdgeInsets extends EdgeInsets {
  const _WidgetEdgeInsets.contentPadding() : super.all(8.0);
}
