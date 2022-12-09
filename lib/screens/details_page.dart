import 'package:flutter/material.dart';
import 'package:peliculas_app/models/movie.dart';
import 'package:peliculas_app/theme/app_theme.dart';
import 'package:peliculas_app/widgets/casting_cards.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //recibir el argumento
    // ignore: todo
    //TODO: luego lo cambiaremos por una instancia de una pelicula
    // final String movie =
    //     ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;
    //que lo trate como pelicula
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //son widgets, que nos dan un comportamiento cuando hacemos scroll
          _CustomAppBar(
            movie: movie,
          ),
          //Cuando nosotros nos encontramos dentro de un CustomScrollView
          // mas especifico dentro de los slivers no podemos usar widgets normales como el Text por ejemplo

          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterAndTitle(
                  movie: movie,
                ),
                _Overview(
                  movie: movie,
                ),
                _Overview(
                  movie: movie,
                ),
                _Overview(
                  movie: movie,
                ),
                // const _Overview(),
                // const _Overview(),
                // const _Overview(),
                CastingCards(
                  movieId: movie.id,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      //es parecido al appbar pero nos da un comportamiento interesante con el scroll
      backgroundColor: AppTheme.primary,
      expandedHeight: 200,
      //para que nuestro sliver se quede ahi arriba como un appbar
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        //quitar el padding
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          color: Colors.black26,
          alignment: Alignment.bottomCenter,
          //margin: EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage("assets/loading.gif"),
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitle({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage("assets/no-image.jpg"),
                image: NetworkImage(movie.fullPosterImg),
                //tamano especifico
                height: 150,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  movie.originalTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_outline,
                      size: 15,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      movie.voteAverage.toString(),
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;
  const _Overview({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
