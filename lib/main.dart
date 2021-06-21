import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thingz_evignette/authentication_service.dart';
import 'package:thingz_evignette/screens/login/login_screen.dart';
import 'package:thingz_evignette/theme.dart';
import 'package:thingz_evignette/screens/main_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) {
            return AuthenticationService(FirebaseAuth.instance);
          },
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: lightThemeData(context),
        darkTheme: darkThemeData(context),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) return MainScreen();
    return LoginScreen();
  }
}
