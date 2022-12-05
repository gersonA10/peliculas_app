import 'package:flutter/material.dart';
import 'package:peliculas_app/theme/app_theme.dart';
import 'package:peliculas_app/widgets/card_swiper.dart';
import 'package:peliculas_app/widgets/movie_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peliculas App"),
        backgroundColor: AppTheme.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            //tarjetas principales
            CardSwiper(),
            //listado horizontal de peliculas
            MovieSlider(),
          ],
        ),
      ),
    );
  }
}
