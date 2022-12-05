import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_request/models/movie.dart';

class HttpService {
  final String apiKey = '5b265a40fbb821bc9aa19f1eb2f27851';
  final String baseUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=';

  Future<List?> getPopularMovies() async {
    final String uri = baseUrl + apiKey;

    http.Response result = await http.get(Uri.parse(uri));
    if (result.statusCode == HttpStatus.ok) {
      // ignore: avoid_print
      print("Sukses");
      final jsonResponse = json.decode(result.body);
      final moviesMap = jsonResponse['results'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      return movies;
    } else {
      // ignore: avoid_print
      print("Fail");
      return null;
    }
  }
}
