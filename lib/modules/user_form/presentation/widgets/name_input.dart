import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class NameInput extends StatelessWidget {
  const NameInput({
    Key? key,
    required this.formControlName,
    required this.hintText,
    required this.label,
    required this.validationMessage,
  }) : super(key: key);
  final String formControlName;
  final String hintText;
  final String label;
  final String validationMessage;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ReactiveTextField(
          formControlName: formControlName,
          decoration: InputDecoration(
            hintText: hintText,
            label: Text(label),
          ),
          validationMessages: {
            ValidationMessage.required: (error) => validationMessage,
          }),
    );
  }
}
