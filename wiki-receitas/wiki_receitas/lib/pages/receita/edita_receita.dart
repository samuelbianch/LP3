import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wiki_receitas/commons/custom_textformfield.dart';
import 'package:wiki_receitas/commons/mypicked_image.dart';
import 'package:wiki_receitas/models/receita/receita.dart';
import 'package:wiki_receitas/pages/home/home.dart';
import 'package:wiki_receitas/services/receita/receita.dart';
import 'package:provider/provider.dart';

class EditaReceitaPage extends StatefulWidget {
  const EditaReceitaPage({super.key});

  @override
  State<EditaReceitaPage> createState() => _EditaReceitaPageState();
}

class _EditaReceitaPageState extends State<EditaReceitaPage> {
  final TextEditingController _nomeReceita = TextEditingController();
  final TextEditingController _tipoReceita = TextEditingController();
  final TextEditingController _tempoDePreparo = TextEditingController();
  final TextEditingController _modoPreparo = TextEditingController();
  final TextEditingController _ingredientes = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var queryParams = ModalRoute.of(context)!.settings.arguments;
    var receitaID = queryParams
        .toString()
        .replaceFirstMapped("{receitaID: ", (m) => "")
        .replaceFirstMapped("}", (m) => "");

    debugPrint(receitaID);
    ReceitaService receitaService = ReceitaService();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 45,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Edite sua receita",
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.green,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Consumer<MyPickedImage>(
                  builder: (context, myPickedImage, child) {
                    if (myPickedImage.pickImage == null ||
                        myPickedImage.webImage!.isEmpty) {
                      return dottedBorder(color: Colors.green);
                    } else {
                      return GestureDetector(
                        onTap: () {
                          Provider.of<MyPickedImage>(context, listen: false)
                              .myPickedImage();
                        },
                        child: ClipOval(
                          child: kIsWeb
                              ? Image.memory(
                                  myPickedImage.webImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  myPickedImage.pickImage!,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    }
                  },
                )
              ]),
              const SizedBox(
                height: 25.0,
              ),
              StreamBuilder(
                  stream: receitaService.getReceitaById(receitaID),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      DocumentSnapshot docSnapshot = snapshot.data!.docs[0];
                      return Column(
                        children: [
                          TextFormField(
                            controller: _nomeReceita,
                            initialValue: docSnapshot['nome'] ?? "",
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person),
                                label: Text("Nome da receita"),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.5))),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            controller: _ingredientes,
                            initialValue: docSnapshot['ingredintes'] ?? "",
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.food_bank_rounded),
                                label: Text("Ingredientes"),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.3),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.5))),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            enabled: true,
                            initialValue: docSnapshot['modoPreparo'] ?? "",
                            decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.do_disturb_alt_outlined),
                                label: Text("Modo de Preparo"),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 1.3)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 3))),
                            controller: _modoPreparo,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          CustomTextFormField(
                            enabled: true,
                            labelText: const Text('Tempo de Preparo'),
                            controller: _tempoDePreparo,
                            prefixIcon: Icons.time_to_leave_outlined,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          CustomTextFormField(
                            readOnly: true,
                            enabled: true,
                            labelText: const Text('Tipo da Receita'),
                            controller: _tipoReceita,
                            prefixIcon: Icons.calendar_month,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Consumer<MyPickedImage>(
                                builder: (context, myPickedImage, child) {
                                  return ElevatedButton(
                                    onPressed: () async {
                                      ReceitaService receitaService =
                                          ReceitaService();
                                      Receita receita = Receita();
                                      receita.nome = _nomeReceita.text;
                                      receita.ingredientes = _ingredientes.text;
                                      receita.modoDePreparo = _modoPreparo.text;
                                      receita.tempoDePreparo =
                                          docSnapshot['tempoPreparo'] ?? "";
                                      receita.tipoReceita =
                                          docSnapshot['tipoReceita'] ?? "";
                                      receita.dataCriacao =
                                          docSnapshot['dataCriacao'] ??
                                              DateTime.now();
                                      receita.userID = auth.currentUser!.uid;

                                      if (await receitaService.update(
                                          '', receita, kIsWeb)) {
                                        if (context.mounted) const HomePage();
                                      } else {
                                        if (context.mounted) {
                                          var snackBar = const SnackBar(
                                            content: Text(
                                                'Algum erro aconteceu no registro'),
                                            backgroundColor: Color.fromARGB(
                                                255, 161, 71, 66),
                                            behavior: SnackBarBehavior.floating,
                                            margin: EdgeInsets.all(50),
                                            elevation: 20,
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                        elevation: 1.5,
                                        minimumSize: const Size.fromHeight(50),
                                        shape: LinearBorder.bottom()),
                                    child: const Text(
                                      'Cadastrar Nova Receita',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      );
                    } else {
                      return const Text("Erro ao buscar receita");
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget dottedBorder({Color? color}) {
    return DottedBorder(
        dashPattern: const [5],
        color: color!,
        child: Column(
          children: [
            IconButton(
              iconSize: 80,
              icon: const Icon(Icons.image_search_rounded),
              onPressed: () {
                Provider.of<MyPickedImage>(context, listen: false)
                    .myPickedImage();
              },
            ),
            Text(
              "Foto",
              style: TextStyle(color: color),
            )
          ],
        ));
  }
}
