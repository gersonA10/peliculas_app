import 'package:flutter/material.dart';
import 'package:peliculas_app/widgets/casting_cards.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //recibir el argumento
    //TODO: luego lo cambiaremos por una instancia de una pelicula
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    //
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          //son widgets, que nos dan un comportamiento cuando hacemos scroll
          const _CustomAppBar(),
          //Cuando nosotros nos encontramos dentro de un CustomScrollView
          // mas especifico dentro de los slivers no podemos usar widgets normales como el Text por ejemplo
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const _PosterAndTitle(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                const _Overview(),
                CastingCards()
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      //es parecido al appbar pero nos da un comportamiento interesante con el scroll
      backgroundColor: Colors.indigo,
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
          width: double.maxFinite,
          child: const Text(
            "movie.title",
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: const FadeInImage(
          placeholder: AssetImage("assets/loading.gif"),
          image: NetworkImage("https://via.placeholder.com/500X300.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage("assets/no-image.jpg"),
              image: NetworkImage("https://via.placeholder.com/200x300.jpg"),
              //tamano especifico
              height: 150,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "movie.title",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const Text(
                "movie.OriginalTitle",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              Row(
                children: const [
                  Icon(
                    Icons.star_outline,
                    size: 15,
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "movie.voteAverage",
                    style: TextStyle(fontSize: 12),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: const Text(
        "Esse elit eiusmod magna eiusmod fugiat anim do ad officia sint ahsdshad nabsdhjgsaudgsag jhagsdhgsahdgsahgdsa hasgdhsadsajdkhaslib",
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
