import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie.dart';
import 'package:http/http.dart' as http;

import 'detail_page.dart';

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

    _fetchList();
  }

  Future<void> _fetchList() async {
    _items = await fetchMovieList();
    setState(() {});
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
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Column(
                children: [

                  InkWell(
                    child: Image.network('https://image.tmdb.org/t/p/w500/${_items[index].posterPath}', fit: BoxFit.cover,),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailPage(_items[index])),
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(_items[index].title, style: TextStyle(fontSize: 18, color: Colors.white),),
                  ),
                ],
              );
            },
            childCount: _items.length,
          ),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.5,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
          ),
        )
      ],
    );
  }

  Widget _buildMovieItem(BuildContext context, item) {
    return Column(
      children: [

        InkWell(
          child: Image.network('https://image.tmdb.org/t/p/w500/${item.posterPath}', fit: BoxFit.cover,),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(item)),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(item.title, style: TextStyle(fontSize: 18, color: Colors.white),),
        ),
      ],
    );
  }

  Future<List<Movie>> fetchMovieList() async {
    //await와 async는 한 셋트
    //await는 Future가 종료되는 것을 기다린다. async 키워드가 붙어있는 메서드 안에서만 사용 가능
    final http.Response response = await http.get(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=a64533e7ece6c72731da47c9c8bc691f&language=ko-KR&page=1');

    if (response.statusCode == 200) {
      //200 정상코드

      // //jsonDecode로 응답받은 값을 String에서 Map형태로 바꿔주는 것
      final Iterable json = jsonDecode(response.body)["results"];
      return json.map((e) => Movie.fromJson(e)).toList();
    } else {
      //에러가 나면 예외 발생시키고 종료
      throw Exception('Failed to load album');
    }
  }
}
