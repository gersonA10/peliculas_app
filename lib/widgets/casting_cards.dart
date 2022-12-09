import 'package:flutter/material.dart';
import 'package:peliculas_app/models/credits_response.dart';
import 'package:peliculas_app/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    //algo que se ejecutara a diferente tiempo
    //mayormente con peticiones http
    //tarea asyncrona en destiempo
    return FutureBuilder(
      future: moviesProvider.getMovieCast(movieId),
      builder: (BuildContext context, AsyncSnapshot<List<Cast>> snapshot) {
        //si viene vacio
        if (!snapshot.hasData) {
          return Center(
            child: Container(
              padding: const EdgeInsets.all(30),
              width: 100,
              height: 100,
              child: const CircularProgressIndicator(),
            ),
          );
        }

        final cast = snapshot.data;
        return Container(
          width: double.infinity,
          height: 180,
          //color: Colors.red,
          margin: const EdgeInsets.only(bottom: 30),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast!.length,
            itemBuilder: (BuildContext context, int index) {
              //NUESTRAS CARDS
              return _CastCard(
                actor: cast[index],
              );
            },
          ),
        );
        ;
      },
    );
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 120,
      height: 100,
      //color: Colors.green,
      child: Expanded(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage("assets/no-image.jpg"),
                image: NetworkImage(actor.fullProfilePath),
                height: 140,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              actor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
