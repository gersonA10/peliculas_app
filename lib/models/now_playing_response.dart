//Yo entiendo que este model sera una respuesta de alguna peticion
//  QuickType nos ayuda a crear un mapa que se adapte a un json que coloquemos
//MAPEAR UNA PETICION HTTP

import 'dart:convert';

import 'package:peliculas_app/models/movie.dart';

class NowPlayingResponse {
  //CONSTRUCTOR
  NowPlayingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  //propiedades de nuestra clase
  Dates dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  //crea una instancia basada en un json que recibe, que puede ser un mapa
  factory NowPlayingResponse.fromJson(String str) =>
      NowPlayingResponse.fromMap(json.decode(str));

  /*
  recibe un mapa que se llama json y luego crea una una instancia de NowPLayingResponse en
  el que toma las fecha que las mapea, page que lo toma del json, rsults que es un listado que barrera los resultados
  y retorna un resultado
  */
  factory NowPlayingResponse.fromMap(Map<String, dynamic> json) =>
      NowPlayingResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        //se recibe un listado y se reciben las movies
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );
}

class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  DateTime maximum;
  DateTime minimum;

  factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

  factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}

//esta es la pelicula
