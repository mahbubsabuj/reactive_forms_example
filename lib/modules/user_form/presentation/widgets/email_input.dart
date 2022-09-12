import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    Key? key,
    required this.formControlName,
    required this.hintText,
    required this.label,
    required this.requiredValidationMessage,
    required this.emailValidationMessage,
    required this.mustMatchValidationMessage,
  }) : super(key: key);
  final String formControlName;
  final String hintText;
  final String label;
  final String requiredValidationMessage;
  final String emailValidationMessage;
  final String mustMatchValidationMessage;
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
          ValidationMessage.required: (error) => requiredValidationMessage,
          ValidationMessage.email: (error) => emailValidationMessage,
          ValidationMessage.mustMatch: (error) => mustMatchValidationMessage
        },
      ),
    );
  }
}
