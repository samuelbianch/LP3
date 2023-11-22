import 'package:flutter/material.dart';

class ReceitasFavoritasPage extends StatefulWidget {
  ReceitasFavoritasPage({super.key});

  @override
  State<ReceitasFavoritasPage> createState() => _ReceitasFavoritasPage();
}

class _ReceitasFavoritasPage extends State<ReceitasFavoritasPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        elevation: 1.0,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 15,
          ),
          child: Row(children: [
            ClipOval(child: Text("Texto")),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Texto"),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
