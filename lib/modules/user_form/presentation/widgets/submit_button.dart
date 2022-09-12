import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../data/models/user_model.dart';
import '../bloc/users_form_bloc.dart';
import '../page/user_form_screen.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.isUpdateScreen,
    required FormGroup signUpForm,
  })  : _signUpForm = signUpForm,
        super(key: key);

  final bool isUpdateScreen;
  final FormGroup _signUpForm;

  void _onFormSubmit(BuildContext context) {
    context.read<UsersFormBloc>().add(
          FormSubmitted(
            user: UserModel(
              id: 10,
              country: _signUpForm.control('country').value,
              email: _signUpForm.control('email').value,
              firstName: _signUpForm.control('firstName').value,
              lastName: _signUpForm.control('lastName').value,
              gender: _signUpForm.control('gender').value,
              password: _signUpForm.control('password').value,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: MediaQuery.of(context).size.width - 20,
      child: ElevatedButton(
        onPressed: ReactiveForm.of(context)!.invalid
            ? null
            : () => _onFormSubmit(context),
        child: Text(isUpdateScreen ? 'Update' : 'Create'),
      ),
    );
  }
}
