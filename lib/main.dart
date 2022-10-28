import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prueba_de_proyecto/screens/screens.dart';
import 'package:prueba_de_proyecto/services/services.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp()
    );
  }
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
       'login': (_)=> const LoginScreen(),
       'home' : (_)=> const HomeScreen(),
      }, 
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white
      ),
    );
  }
}