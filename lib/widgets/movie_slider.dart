import 'package:flutter/material.dart';
import 'package:peliculas_app/models/movie.dart';

class MovieSlider extends StatefulWidget {
  //cuando usamos el scrollController, necesitamos destruirlo cuando ya lo necestiemos para que flutter
  //no siga con eso en memoria
  final String title;
  final List<Movie> moviesPopular;
  final Function onNextPage;
  const MovieSlider({
    super.key,
    required this.moviesPopular,
    required this.title,
    required this.onNextPage,
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();
  //cuando el widget se construya por primera vez
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        //TODO: LLAMAR AL PROVIDER
        //print("obetener pagina");

        //aca ponemos lo que tenga nuestra funcion
        widget.onNextPage();
      }
      //print(scrollController.position.pixels);
      //print(scrollController.position.maxScrollExtent);
    });
  }

//cuando el widget sera destruido
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 270,
      //color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //Nos permite mostrar widgets dentro de nuestra Column como el ListView
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              //nos permite hacer el scroll de forma horizontal
              scrollDirection: Axis.horizontal,
              itemCount: widget.moviesPopular.length,
              itemBuilder: ((context, index) {
                //final movieP = moviesPopular[index];
                //y aca tenemos que mandar la instancia de acuerdo a la posicion index
                return _MoviePoster(
                  movie: widget.moviesPopular[index],

                  //nos inventamos un id
                  heoId:
                      '${widget.title}-${index}_${widget.moviesPopular[index].id}',
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  //nos creamos una variable que va a contener nuesto titulo, imagen y otros datos de nuestra Movie
  final Movie movie;
  //agregamos un mismo index
  final String heoId;
  const _MoviePoster({
    Key? key,
    required this.movie,
    required this.heoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //nos inventamos un id unico
    movie.heroId = heoId;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 130,
      height: 190,
      //color: Colors.green,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(
              context,
              "details",
              //para recibirlo
              arguments: movie,
            ),
            child: Hero(
              tag: movie.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage("assets/no-image.jpg"),
                  /*
                  Como ya tenemos nuestro variable de tipo Movie
                  Podemos acceder a las propiedades de nuestra movie
                  y entonces mostramos nuestro poster
                  */
                  image: NetworkImage(movie.fullPosterImg),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            //y aca mmostramos de igual manera con nuestra variable movie, mostramos el titulo
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
