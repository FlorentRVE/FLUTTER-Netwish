// import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class Api {
  getMovies($searchTerms) async {
    var url = Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=26a145d058cf4d1b17cbf084ddebedec&language=fr-FR&query=" +
            $searchTerms);

    var req = http.Request('GET', url);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return (resBody);
    } else {
      return (res.reasonPhrase);
    }
  }

  getMoviebyId($movieId) async {
    var url = Uri.parse("https://api.themoviedb.org/3/movie/" +
        $movieId +
        "?api_key=26a145d058cf4d1b17cbf084ddebedec&language=fr-FR&query=");

    var req = http.Request('GET', url);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return (resBody);
    } else {
      return (res.reasonPhrase);
    }
  }

  getGenre() async {
    var url = Uri.parse(
        "https://api.themoviedb.org/3/genre/movie/list?api_key=26a145d058cf4d1b17cbf084ddebedec&language=fr-FR");

    var req = http.Request('GET', url);

    var res = await req.send();
    final resBody = await res.stream.bytesToString();

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return (resBody);
    } else {
      return (res.reasonPhrase);
    }
  }
}
