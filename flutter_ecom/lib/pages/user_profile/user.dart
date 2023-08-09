import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text("Nome: Samuel Oliveira Silva Bianch"),
        Text("Telefone: (65) 9 9907-3569"),
        Text("Email: samuelbianch38@gmail.com"),
        Text("Data Nascimento: 05/07/2002"),
      ],
    );
  }
}