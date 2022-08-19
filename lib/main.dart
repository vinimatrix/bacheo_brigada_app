import 'package:bacheo_brigada/providers/app_state_provider.dart';
import 'package:bacheo_brigada/providers/auth_provider.dart';
import 'package:bacheo_brigada/providers/globals.dart';
import 'package:bacheo_brigada/screens/confirmacion.dart';
import 'package:bacheo_brigada/screens/fotos.dart';
import 'package:bacheo_brigada/screens/gretings.dart';
import 'package:bacheo_brigada/screens/login.dart';
import 'package:bacheo_brigada/screens/main.dart';
import 'package:bacheo_brigada/screens/mi_perfil.dart';
import 'package:bacheo_brigada/screens/reporte.dart';
import 'package:bacheo_brigada/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppStateProvider>.value(value: AppStateProvider()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppStateProvider(),
      child: OverlaySupport(
        child: MaterialApp(
          title: 'Bacheo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Montserrat',
          ),
          initialRoute: '/splash',
          routes: {
            '/splash': (context) => const SplashScreen(),
            '/login': (context) => const LoginScreen(),
            '/home': (context) => MainScreen(),
            '/reporte_2': ((context) => FotosScreen()),
            '/confirmacion': (context) => ConfirmacionScreen(),
            '/greetings': (context) => GrettingsScreen(
                  id: 0,
                ),
            '/profile': (context) => ProfileScreen()
          },
        ),
      ),
    );
  }
}
