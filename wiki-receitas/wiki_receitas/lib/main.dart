import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wiki_receitas/login/login.dart';
import 'package:wiki_receitas/pages/home/home.dart';
import 'package:wiki_receitas/pages/main/main_page.dart';
import 'package:wiki_receitas/login/sign_up.dart';
import 'package:wiki_receitas/pages/receita/create_receita.dart';
import 'package:wiki_receitas/pages/receita/minhas_receitas.dart';
import 'package:wiki_receitas/pages/receita/receita.dart';
import 'package:wiki_receitas/pages/userprofile/userprofile.dart';
import 'package:wiki_receitas/pages/userprofile/user_profile_edit_page.dart';
import 'package:wiki_receitas/services/users/users_services.dart';
import 'package:provider/provider.dart';
import 'commons/mypicked_image.dart';
import 'package:wiki_receitas/models/users/users.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var options = const FirebaseOptions(
      apiKey: "AIzaSyDtqc7QAOUWxwFDEmS28-tMnR8D8ITchMg",
      authDomain: "flutter-lp3.firebaseapp.com",
      projectId: "flutter-lp3",
      storageBucket: "flutter-lp3.appspot.com",
      messagingSenderId: "125950087820",
      appId: "1:125950087820:web:991723730f1d4fb3f9e1a9",
      measurementId: "G-0HVSN9N091");
  if (kIsWeb) {
    await Firebase.initializeApp(options: options);
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersServices>(
          create: (_) => UsersServices(),
          lazy: false,
        ),
        ChangeNotifierProvider<MyPickedImage>(
          create: (context) => MyPickedImage(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorSchemeSeed: const Color.fromARGB(255, 1, 25, 3),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/home': (context) => const HomePage(),
          '/mainpage': (context) => MainPage(),
          '/userprofile': (context) => const UserProfilePage(),
          '/userprofileedit': (context) => UserProfileEditPage(),
          '/signup': (context) => const SignUpPage(),
          '/receita': (context) => ReceitaPage(),
          '/receita/add': (context) => const CreateReceitaPage(),
          '/minhasreceitas': (context) => MinhasReceitasPage(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => LoginPage());
            case '/home':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case '/mainpage':
              return MaterialPageRoute(builder: (_) => MainPage());
            case '/userprofile':
              return MaterialPageRoute(builder: (_) => const UserProfilePage());
            case '/signup':
              return MaterialPageRoute(builder: (_) => const SignUpPage());
            case '/receita':
              return MaterialPageRoute(builder: (_) => ReceitaPage());
            case '/minhasreceitas':
              return MaterialPageRoute(builder: (_) => MinhasReceitasPage());
            case '/receita/add':
              return MaterialPageRoute(
                  builder: (_) => const CreateReceitaPage());
            case '/userprofileedit':
              return MaterialPageRoute(
                  builder: (_) =>
                      UserProfileEditPage(users: settings.arguments as Users));
          }
        },
      ),
    );
  }
}
