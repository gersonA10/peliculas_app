import 'package:flutter/material.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:peliculas_app/search/search_delegate.dart';
import 'package:peliculas_app/theme/app_theme.dart';
import 'package:peliculas_app/widgets/card_swiper.dart';
import 'package:peliculas_app/widgets/movie_slider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //Traer mi instancia de moviesProvider
    final moviesProvider = Provider.of<MoviesProvider>(context);
    //print(moviesProvider.imagesOnDisplay);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Peliculas App"),
        backgroundColor: AppTheme.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: (() => showSearch(
                  context: context,
                  delegate: MovieSearchDelegate(),
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //tarjetas principales
            CardSwiper(
              movies: moviesProvider.imagesOnDisplay,
            ),
            //listado horizontal de peliculas
            MovieSlider(
              moviesPopular: moviesProvider.popularsMovies,
              title: "Populares!",
              onNextPage: () {
                //
                moviesProvider.getPopularMovies();
                print("HOLA");
              },
            ),
          ],
        ),
      ),
    );
  }
}
