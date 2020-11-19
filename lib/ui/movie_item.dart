import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie.dart';
import 'detail_page.dart';

class MovieItem extends StatelessWidget {
  Movie movie;

  MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          child: Image.network(
            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
            fit: BoxFit.cover,),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(movie)),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            movie.title, style: TextStyle(fontSize: 18, color: Colors.white),),
        ),
      ],
    );
  }
}
