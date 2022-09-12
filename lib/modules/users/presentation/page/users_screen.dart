import 'package:flutter/material.dart';
import 'package:reactive_forms_example/modules/users/presentation/widgets/users_list.dart';

import '../../../user_form/presentation/page/user_form_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reactive Forms"),
      ),
      body: const UsersList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => UserFormScreen(),
          ),
        ),
        child: const Text("Add"),
      ),
    );
  }
}
