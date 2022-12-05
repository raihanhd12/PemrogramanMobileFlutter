import 'package:flutter/material.dart';
import 'package:http_request/models/movie.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imgpPath = 'https://image.tmdb.org/t/p/w500/';

  const MovieDetail(this.movie, {super.key});

  @override
  Widget build(BuildContext context) {
    String path;
    if (movie.posterPath != null) {
      path = imgpPath + movie.posterPath!;
    } else {
      path =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title!),
      ),
      body: SingleChildScrollView(
          child: Center(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(16),
                height: height / 1.5,
                child: Image.network(path)),
            Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(movie.overview!),
            )
          ],
        ),
      )),
    );
  }
}
