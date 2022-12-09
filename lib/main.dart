import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/screens/details_page.dart';
import 'package:peliculas_app/screens/home_page.dart';
import 'package:peliculas_app/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Cuando necesitemos mas de un provider
        //inicializamos la instancia de nuestro MoviesProvider
        ChangeNotifierProvider(
          //con esto esperamos que nuestro MoviesProvider que apareciera
          create: ((context) => MoviesProvider()),
          //apenas se defina mi MoviesProvider se ejecute mi constructor
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: 'home',
      theme: AppTheme.themeDataLight,
      routes: {
        "home": (context) => const HomePage(),
        "details": (context) => const DetailsPage(),
      },
    );
  }
}
