// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_form_bloc.dart';

enum FormStatus {
  pure,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
  submissionCanceled
}

class UsersFormState extends Equatable {
  final UserModel user;
  final FormStatus status;
  final String message;

  const UsersFormState({
    this.user = const UserModel(
      firstName: '',
      lastName: '',
      country: '',
      email: '',
      gender: '',
      password: '',
    ),
    this.status = FormStatus.pure,
    this.message = '',
  });
  @override
  List<Object> get props => [user, status, message];

  UsersFormState copyWith({
    UserModel? user,
    FormStatus? status,
    String? message,
  }) {
    return UsersFormState(
      user: user ?? this.user,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
