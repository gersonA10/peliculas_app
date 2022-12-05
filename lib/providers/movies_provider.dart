import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/models/now_playing_response.dart';

//extendie de change notifier

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '725c8288e083b7aabbc70f1bae3b462e';
  final String _language = 'es=ES';

  MoviesProvider() {
    print("MoviesProvider inicializado");
    getOnDisplayMovies();
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
    //convertir a un mapa poara obtener facilmente la informacion
    //el decodeData no sabe que esta decodificando
    //TODO: este ya no es necesario: final Map<String, dynamic> decodeData = jsonDecode(response.body);
    //al trabajar como mapa no puedo obtener toda la informacion
    ////print(decodeData['results']);
    print(nowPlayingResponse.results[1].title);
    //entonces hay que mapear todo el resultado a una instancia de una clase
    //los models nos ayuda a que tengamos las clases que nos aydua a mapear otras cosas
  }
}
