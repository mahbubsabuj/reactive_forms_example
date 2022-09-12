import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/user_form/presentation/bloc/users_form_bloc.dart';
import 'modules/users/presentation/page/users_screen.dart';

void main() {
  runApp(const Root());
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UsersFormBloc(),
        ),
      ],
      child: const MaterialApp(
        home: UsersScreen(),
      ),
    );
  }
}
