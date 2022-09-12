import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms_example/modules/home/presentation/page/home_screen.dart';
import 'package:reactive_forms_example/modules/user_form/bloc/users_form_bloc.dart';
import 'package:reactive_forms_example/modules/users/services/users_service.dart';

import '../../data/models/user_model.dart';

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
                  const CountryInput(),
                  SubmitButton(widget: widget, signUpForm: _signUpForm),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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

class PasswordInput extends StatelessWidget {
  const PasswordInput({
    Key? key,
    required this.formControlName,
    required this.hintText,
    required this.label,
    required this.requiredValidationMessage,
    required this.mustMatchValidationMessage,
  }) : super(key: key);
  final String formControlName;
  final String hintText;
  final String label;
  final String requiredValidationMessage;
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
          ValidationMessage.mustMatch: (error) => mustMatchValidationMessage
        },
      ),
    );
  }
}

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

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.widget,
    required FormGroup signUpForm,
  })  : _signUpForm = signUpForm,
        super(key: key);

  final UserFormScreen widget;
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
        child: Text(widget.isUpdateScreen ? 'Update' : 'Create'),
      ),
    );
  }
}
