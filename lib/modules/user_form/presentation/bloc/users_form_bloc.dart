import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';

part 'users_form_event.dart';
part 'users_form_state.dart';

class UsersFormBloc extends Bloc<UsersFormEvent, UsersFormState> {
  UsersFormBloc() : super(const UsersFormState()) {
    on<FormSubmitted>(_onFormSubmitted);
  }
  Future<void> _onFormSubmitted(
      FormSubmitted event, Emitter<UsersFormState> emit) async {
    final UserModel user = event.user;
    emit(
      state.copyWith(
        user: user,
        status: FormStatus.submissionInProgress,
      ),
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
    emit(
      state.copyWith(
          status: FormStatus.submissionSuccess,
          message: 'Form submitted successfully,'),
    );
  }
}
