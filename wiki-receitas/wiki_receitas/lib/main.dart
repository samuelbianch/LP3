import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wiki_receitas/login/login.dart';
import 'package:wiki_receitas/pages/home/home.dart';
import 'package:wiki_receitas/pages/main/main_page.dart';
import 'package:wiki_receitas/login/sign_up.dart';
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
          '/': (context) => const HomePage(),
          '/login': (context) => LoginPage(),
          '/mainpage': (context) => MainPage(),
          '/userprofile': (context) => const UserProfilePage(),
          '/userprofileedit': (context) => UserProfileEditPage(),
          '/signup': (context) => const SignUpPage(),
        },
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (_) => const HomePage());
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginPage());
            case '/mainpage':
              return MaterialPageRoute(builder: (_) => MainPage());
            case '/userprofile':
              return MaterialPageRoute(builder: (_) => const UserProfilePage());
            case '/signup':
              return MaterialPageRoute(builder: (_) => const SignUpPage());
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
