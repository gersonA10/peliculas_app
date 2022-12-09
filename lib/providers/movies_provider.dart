import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/helpers/debouncer.dart';
import 'package:peliculas_app/models/credits_response.dart';
import 'package:peliculas_app/models/movie.dart';
import 'package:peliculas_app/models/now_playing_response.dart';
import 'package:peliculas_app/models/popular_response.dart';
import 'package:peliculas_app/models/search_response.dart';

//extiende de change notifier

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '725c8288e083b7aabbc70f1bae3b462e';
  final String _language = 'es=ES';

  List<Movie> imagesOnDisplay = [];
  List<Movie> popularsMovies = [];

  //MANEJAR DE UNA MANERA DIFERENTE
  Map<int, List<Cast>> movieCast = {};

  //incrementar en un para mi infinite scroll
  int _popularPage = 1;

  //ponemos nuestro debouncer
  //y cuanto tiempo quiero esperar para emitir un valor
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  //nuestro steam controller
  //es como un future, nuestro steam sera una lista de movies
  final StreamController<List<Movie>> _suggestionStreamContoller =
      StreamController.broadcast();
  //para enviar ese stream y escucharlo
  Stream<List<Movie>> get suggestionStream => _suggestionStreamContoller.stream;

  MoviesProvider() {
    print("MoviesProvider inicializado");
    getOnDisplayMovies();
    getPopularMovies();
  }

  getOnDisplayMovies() async {
    //print("GetOnDisplayMovies");
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      //enviamos los parametros del query
      //que es un mapa
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });

    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    //convertir a un mapa para obtener facilmente la informacion
    //print(nowPlayingResponse.results[1].title);
    imagesOnDisplay = nowPlayingResponse.results;
    notifyListeners();
    //entonces hay que mapear todo el resultado a una instancia de una clase
  }

  //Mostrar las peliculas populares
  getPopularMovies() async {
    _popularPage++;
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      //enviamos los parametros del query
      //que es un mapa
      'api_key': _apiKey,
      'language': _language,
      'page': "$_popularPage",
    });

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    popularsMovies = [...popularsMovies, ...popularResponse.results];
    //print(popularsMovies);
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    //reviasr el mapa;
    print("pidiendo infor de cas");

    var url = Uri.https(_baseUrl, '3/movie/$movieId/credits', {
      //enviamos los parametros del query
      //que es un mapa
      'api_key': _apiKey,
      'language': _language,
      'page': '1',
    });
    final response = await http.get(url);
    final creditsResponse = CreditsResponse.fromJson(response.body);

    //almacenar en mi mapa
    movieCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  //buscar nuestras peliculas
  //necesitamos el query que es nuestro termino de busqueda
  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    //el debauncer esperara hasta que la persona deje de escribir
    debouncer.value = '';
    //metodo cuando pase las 500 milliseconds
    debouncer.onValue = (value) async {
      // print('Tenemos valor a buscar: $value');
      //tenemos los resultados de nuestras movies
      final results = await searchMovies(value);

      //emitimos el valor para agregar un nuevo evento que sera nuestra lsta de pelicuals
      _suggestionStreamContoller.add(results);
    };
    //se ejecuta cada x cantidad de tiempo
    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      //cada que pase el tiempo mandamos el debouncer value
      debouncer.value = searchTerm;
    });
    //esperar
    Future.delayed(const Duration(milliseconds: 301))
        //cuando ya se tenga una peticion cancelamos
        .then((_) => timer.cancel());
  }
}
