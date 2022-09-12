import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/modules/home/presentation/page/home_screen.dart';
import 'package:reactive_forms_example/modules/users/services/users_service.dart';

import '../../data/models/user_model.dart';
import '../bloc/users_form_bloc.dart';
import '../widgets/auto_complete_input.dart';
import '../widgets/country_input.dart';
import '../widgets/email_input.dart';
import '../widgets/gender_input.dart';
import '../widgets/name_input.dart';
import '../widgets/password_input.dart';
import '../widgets/submit_button.dart';

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({Key? key, this.isUpdateScreen = false, this.id = 0})
      : super(key: key);
  final bool isUpdateScreen;
  final int id;

  @override
  State<UserFormScreen> createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _signUpForm = FormGroup({
    'firstName':
        FormControl<String>(value: '', validators: [Validators.required]),
    'lastName':
        FormControl<String>(value: '', validators: [Validators.required]),
    'email': FormControl<String>(
        value: '', validators: [Validators.required, Validators.email]),
    'confirmEmail': FormControl<String>(
        value: '', validators: [Validators.required, Validators.email]),
    'password':
        FormControl<String>(value: '', validators: [Validators.required]),
    'confirmPassword':
        FormControl<String>(value: '', validators: [Validators.required]),
    'gender': FormControl<String>(value: '', validators: [Validators.required]),
    'country':
        FormControl<String>(value: '', validators: [Validators.required]),
    'userName':
        FormControl<String>(value: '', validators: [Validators.required]),
  }, validators: [
    Validators.mustMatch('password', 'confirmPassword'),
    Validators.mustMatch('email', 'confirmEmail'),
  ]);
  Future<void> _getUser() async {
    UserModel user = await UsersService().getUser(widget.id);
    _updateForm(user);
  }

  void _updateForm(UserModel user) {
    _signUpForm.control('firstName').updateValue(user.firstName);
    _signUpForm.control('lastName').updateValue(user.lastName);
    _signUpForm.control('email').updateValue(user.email);
    _signUpForm.control('gender').updateValue(user.gender);
    _signUpForm.control('country').updateValue(user.country);
  }

  @override
  void initState() {
    if (widget.isUpdateScreen) {
      _getUser();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdateScreen ? 'Update User' : 'Create User'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: SingleChildScrollView(
          reverse: true,
          child: BlocListener<UsersFormBloc, UsersFormState>(
            listener: (context, state) {
              debugPrint(state.status.toString());
              if (state.status == FormStatus.submissionSuccess) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
              }
              if (state.status == FormStatus.submissionInProgress) {
                showDialog<void>(
                  context: context,
                  barrierDismissible: true,
                  barrierColor: Colors.transparent,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
              }
              if (state.status == FormStatus.submissionFailure) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
              }
            },
            child: ReactiveForm(
              formGroup: _signUpForm,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NameInput(
                    formControlName: 'firstName',
                    hintText: 'Enter your first name',
                    label: 'First Name',
                    validationMessage: 'this field must not be empty',
                  ),
                  const NameInput(
                    formControlName: 'lastName',
                    hintText: 'Enter your last name',
                    label: 'Last Name',
                    validationMessage: 'this field must not be empty',
                  ),
                  const EmailInput(
                    formControlName: 'email',
                    hintText: 'Enter your email',
                    label: 'Email',
                    requiredValidationMessage: 'Email Field must not be empty',
                    emailValidationMessage: 'Email value must be a valid email',
                    mustMatchValidationMessage:
                        'email and confirm email should be same.',
                  ),
                  const EmailInput(
                    formControlName: 'confirmEmail',
                    hintText: 'Enter your email again',
                    label: 'Confirm Email',
                    requiredValidationMessage:
                        'Confirm email Field must not be empty',
                    emailValidationMessage:
                        'Confirm email value must be a valid email',
                    mustMatchValidationMessage:
                        'email and confirm email should be same.',
                  ),
                  const PasswordInput(
                    formControlName: 'password',
                    hintText: 'Enter your password',
                    label: 'Password',
                    requiredValidationMessage:
                        'Password field must not be empty',
                    mustMatchValidationMessage:
                        'password and confirm password should be same.',
                  ),
                  const PasswordInput(
                    formControlName: 'confirmPassword',
                    hintText: 'Enter your password again',
                    label: 'Confirm Password',
                    requiredValidationMessage:
                        'Confirm password field must not be empty',
                    mustMatchValidationMessage:
                        'password and confirm password should be same.',
                  ),
                  GenderInput(signUpForm: _signUpForm),
                  AutoCompleteInput(
                    formControlName: 'userName',
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const CountryInput(),
                  const SizedBox(
                    height: 5,
                  ),
                  SubmitButton(
                      isUpdateScreen: widget.isUpdateScreen,
                      signUpForm: _signUpForm),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
