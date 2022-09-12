import 'package:flutter/material.dart';
import 'package:reactive_forms_example/modules/user_form/presentation/page/user_form_screen.dart';
import 'package:reactive_forms_example/modules/users/services/users_service.dart';

import '../../../user_form/data/models/user_model.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<UserModel> users = [];
  Future<void> getUsers() async {
    users = await UsersService().getUsers();
    setState(() {});
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                UserFormScreen(isUpdateScreen: true, id: users[index].id ?? 0),
          ),
        ),
        child: Card(
          child: ListTile(
            leading: const CircleAvatar(),
            title: Text(users[index].firstName),
            subtitle: Text(users[index].email),
          ),
        ),
      ),
    );
  }
}
