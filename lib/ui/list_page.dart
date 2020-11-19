import 'package:flutter/material.dart';
import 'package:flutter_movie/http/movie_repository.dart';
import 'package:flutter_movie/ui/detail_page.dart';
import 'package:flutter_movie/ui/movie_item.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var _items = [];
  TextEditingController _textEditingController;
  var _query = "";

  @override
  void initState() {
    super.initState();

    MovieRepository().fetchMovieList().then((movies) {
      setState(() {
        _items = movies;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Center(child: Text('영화 정보 검색기')),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              TextField(
                onChanged: (text) {
                  setState(() {
                    _query = text;
                  });
                },
                autofocus: false,
                controller: _textEditingController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '검색',
                  hintStyle: TextStyle(color: Colors.white),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber[400]),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        SliverGrid.count(
            crossAxisCount: 3,
            childAspectRatio: 0.5,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            children: _items
                .where((movie) =>
                    movie.title.toLowerCase().contains(_query.toLowerCase()))
                .map((movie) => MovieItem(movie))
                .toList()),
      ],
    );
  }

  Widget _buildMovieItem(BuildContext context, item) {
    return Column(
      children: [
        InkWell(
          child: Image.network(
            'https://image.tmdb.org/t/p/w500/${item.posterPath}',
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailPage(item)),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            item.title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
