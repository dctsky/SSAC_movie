import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie.dart';

class DetailPage extends StatelessWidget {
  final Movie movie;

  DetailPage(this.movie);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
      body: Column(
        children: [
          Text(movie.title),
          Image.network('https://image.tmdb.org/t/p/w500/${movie.posterPath}', fit: BoxFit.cover,),
        ],
      ),
    );
  }
}
