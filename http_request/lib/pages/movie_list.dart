import 'package:flutter/material.dart';
import 'package:http_request/service/http_service.dart';

import 'movie_detail.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key});

  @override

  // ignore: library_private_types_in_public_api
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int? moviesCount;
  List? movies;
  String? result;
  HttpService? service;

  Future initialize() async {
    movies = [];
    movies = await service?.getPopularMovies();
    setState(() {
      moviesCount = movies?.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // service?.getPopularMovies().then((value) => {
    //       setState(() {
    //         result = value as String?;
    //       })
    //     });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Popular Movies"),
      ),
      // ignore: avoid_unnecessary_containers
      body: ListView.builder(
        itemCount: (moviesCount == null) ? 0 : moviesCount,
        itemBuilder: (context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: Transform.scale(
                scale: 0.9,
                child: ClipOval(
                  child: Image.network(
                    'https://image.tmdb.org/t/p/original/${movies![position]?.posterPath}',
                  ),
                ),
              ),
              title: Text(movies![position]?.title),
              subtitle: Text(
                'Rating = ${movies![position]?.voteAverage}',
              ),
              onTap: () {
                MaterialPageRoute route = MaterialPageRoute(
                    builder: (_) => MovieDetail(movies![position]));
                Navigator.push(context, route);
              },
            ),
          );
        },
      ),
    );
  }
}
