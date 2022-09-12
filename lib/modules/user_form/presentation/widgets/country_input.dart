import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CountryInput extends StatelessWidget {
  const CountryInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Country",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
          ),
        ),
        ReactiveDropdownField(
          validationMessages: {
            ValidationMessage.required: (error) => 'please select a country',
          },
          hint: const Text("Select your country"),
          formControlName: 'country',
          items: const [
            DropdownMenuItem(
              value: 'Bangladesh',
              child: Text("Bangladesh"),
            ),
            DropdownMenuItem(
              value: 'India',
              child: Text("India"),
            ),
            DropdownMenuItem(
              value: 'Sri Lanka',
              child: Text("Sri Lanka"),
            ),
          ],
        ),
      ],
    );
  }
}
