import 'package:flutter/material.dart';
import 'package:flutter_ecom/pages/mainpage.dart';
import 'package:flutter_ecom/pages/signup_page.dart';
import 'package:flutter_ecom/services/users_services.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  UsersServices _usersServices = UsersServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(35.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35),
                  child: Image.asset(
                    'assets/images/logo_flutter.png',
                    height: 100,
                  ),
                ),
                const Text(
                  "Bem-vindo de Volta",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 213, 107, 8),
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Roboto',
                  ),
                ),
                const Text(
                  'aplicativo multi-funcional',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 213, 93, 8),
                  ),
                ),
                const SizedBox(
                  height: 25.0,
                ),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      label: Text("E-mail"),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.3),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'O email deve conter um valor';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _password,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.fingerprint),
                      label: Text("Senha"),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1.3),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1.5))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'A senha deve conter um valor';
                    }
                    return null;
                  },
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 8.0),
                  child: const Text(
                    'Esqueceu a senha?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (await _usersServices.signIn(
                          email: _email.text,
                          password: _password.text,
                          onSucess: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainPage()));
                          },
                          onFail: (e) {
                            var snack = SnackBar(
                              content: Text(e),
                              backgroundColor: Colors.red,
                              elevation: 15,
                              behavior: SnackBarBehavior.floating,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                          },
                        )) {}
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 1.5,
                          minimumSize: const Size.fromHeight(50),
                          shape: LinearBorder.bottom()),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'Ou',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      onPressed: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            height: 50,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Login com Google",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('Ainda não tem conta?'),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Registre-se',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
