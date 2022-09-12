part of 'users_form_bloc.dart';

abstract class UsersFormEvent extends Equatable {
  const UsersFormEvent();

  @override
  List<Object> get props => [];
}

class FormSubmitted extends UsersFormEvent {
  final UserModel user;
  const FormSubmitted({
    this.user = const UserModel(
      country: '',
      email: '',
      firstName: '',
      gender: '',
      lastName: '',
      password: '',
      avater: '',
    ),
  });
  @override
  List<Object> get props => [user];
}
