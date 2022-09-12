import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GenderInput extends StatelessWidget {
  const GenderInput({
    Key? key,
    required FormGroup signUpForm,
  })  : _signUpForm = signUpForm,
        super(key: key);

  final FormGroup _signUpForm;

  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<String>(
      formControlName: 'gender',
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Gender",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: _signUpForm.control('gender').value == 'Male',
                  onChanged: (_) => {
                    value.updateValue('Male'),
                  },
                ),
                const Text("Male"),
                Checkbox(
                  value: _signUpForm.control('gender').value == 'Female',
                  onChanged: (_) => {
                    value.updateValue('Female'),
                  },
                ),
                const Text("Female"),
                Checkbox(
                  value: _signUpForm.control('gender').value == 'Other',
                  onChanged: (_) => {
                    value.updateValue('Other'),
                  },
                ),
                const Text("Other"),
              ],
            ),
          ],
        );
      },
    );
  }
}
