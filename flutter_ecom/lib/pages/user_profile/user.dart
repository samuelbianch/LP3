import 'package:flutter/material.dart';
import 'package:flutter_ecom/services/users_services.dart';
import 'package:provider/provider.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersServices>(
      builder: (context, usersServices, _) {
        return Column(
          children: [
            Text("Nome: ${usersServices.users!.userName}"),
            Text("Telefone: ${usersServices.users!.phone}"),
            Text("Email: ${usersServices.users!.email}"),
            Text("Data Nascimento: ${usersServices.users!.birthday}"),
          ],
        );
      },
    );
  }
}
