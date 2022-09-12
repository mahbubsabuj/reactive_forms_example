import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../data/models/user_model.dart';

class AutoCompleteInput extends StatelessWidget {
  AutoCompleteInput({Key? key, required this.formControlName})
      : super(key: key);
  final String formControlName;

  final List<UserModel> _userOptions = [
    const UserModel(
        firstName: 'Mahbubul',
        lastName: 'Alam',
        country: 'Bangladesh',
        email: 'mahbubalam@gmail.com',
        gender: 'Male'),
    const UserModel(
        firstName: 'Salman',
        lastName: 'Ahmed',
        country: 'India',
        email: 'salman@gmail.com',
        gender: 'Male'),
    const UserModel(
        firstName: 'Charlie',
        lastName: 'Rodd',
        country: 'USA',
        email: 'charlierodd@gmail.com',
        gender: 'Male'),
    const UserModel(
        firstName: 'John',
        lastName: 'Doe',
        country: 'Irland',
        email: 'john@gmail.com',
        gender: 'Male'),
    const UserModel(
        firstName: 'Raihan',
        lastName: 'Karim',
        country: 'Bangladesh',
        email: 'raihan@gmail.com',
        gender: 'Male'),
    const UserModel(
        firstName: 'Charlie',
        lastName: 'Hopkin',
        country: 'USA',
        email: 'charlie@gmail.com',
        gender: 'Male'),
  ];

  String _displayStringForOption(UserModel user) {
    return user.firstName;
  }

  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<String>(
      formControlName: 'userName',
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "User Auto Complete",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
              ),
            ),
            Autocomplete<UserModel>(
              optionsMaxHeight: 20,
              displayStringForOption: _displayStringForOption,
              initialValue: TextEditingValue(
                  text: _displayStringForOption(_userOptions[0])),
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text == '') {
                  return _userOptions;
                }
                return _userOptions.where((UserModel option) {
                  return option.firstName
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()) ||
                      option.lastName
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()) ||
                      option.country
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()) ||
                      option.email
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                });
              },
              optionsViewBuilder: (context, onSelected, options) => Align(
                alignment: Alignment.topLeft,
                child: Material(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(4.0),
                    ),
                  ),
                  child: SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: options.length,
                      padding: EdgeInsets.zero,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final UserModel user = options.elementAt(index);
                        return GestureDetector(
                          onTap: () => onSelected(user),
                          child: Card(
                            color: Colors.grey.shade300,
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.account_circle),
                              ),
                              title: Text(user.firstName),
                              subtitle: Text(user.lastName),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              onSelected: (UserModel selection) {
                value.updateValue(_displayStringForOption(selection));
              },
            ),
          ],
        );
      },
    );
  }
}
