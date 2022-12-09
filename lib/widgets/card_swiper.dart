import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peliculas_app/models/movie.dart';

class CardSwiper extends StatelessWidget {
  // nos creamos este final para pasar como parametros a nuestra clase CardSwiper
  // para luego llamarla en nuestro home
  final List<Movie> movies;
  //
  const CardSwiper({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //para manejar el ancho y alto de nuestra pantalla nos creamos
    //nuestro [size] para maneajarlo de una mejor manera
    final size = MediaQuery.of(context).size;

    if (movies.isEmpty) {
      return SizedBox(
        width: double.infinity,
        height: size.height * 0.5,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox(
      //color: Colors.red,
      width: double.infinity,
      //Indicamos que vamos a tomar el 50% de nuestra pantalla
      height: size.height * 0.5,
      //Utilizamos nuestro Widget con el paquete que acabamos de importar
      child: Swiper(
        //el layout nos indica de que manera mostraremos nuestro swiper
        layout: SwiperLayout.STACK,
        itemWidth: size.width * 0.7,
        itemHeight: size.height * 0.45,
        itemCount: movies.length,
        itemBuilder: (context, index) {
          //aca nos creamos otra variable donde le asignamos nuestra lista en su posicion index
          final movie = movies[index];

          movie.heroId = "swiper-${movie.id}";
          return GestureDetector(
            onTap: (() => Navigator.pushNamed(
                  context,
                  "details",
                  //mandar toda la pelicula a la cual hicimos click
                  arguments: movie,
                )),
            child: Hero(
              //puede ser lo que sea, pero tiene que ser unico
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: const AssetImage("assets/no-image.jpg"),
                  image: NetworkImage(movie.fullPosterImg),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
