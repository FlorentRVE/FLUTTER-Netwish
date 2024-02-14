import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_db/utils/api.dart';

class Post extends StatelessWidget {
  final double note;
  final String postImage;
  final List<dynamic> genre;

  const Post({
    Key? key,
    required this.genre,
    required this.postImage,
    required this.note,
  }) : super(key: key);

  Future<dynamic> getGenres() async {
    var data = await Api().getGenre();
    var genre = jsonDecode(data);

    return genre;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([getGenres()]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            var genres = snapshot.data[0]["genres"];

            return Container(
              color: Color.fromARGB(255, 24, 24, 24),
              child: Column(
                children: [
                  // image
                  Image.network(
                    "https://image.tmdb.org/t/p/w300$postImage",
                    fit: BoxFit.cover,
                    height: 360,
                    width: 250,
                  ),
                  // title
                  Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 24, 24, 24)),
                    height: 30,
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: Text(
                        'Note: ' + note.toString() + '/10',
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(color: const Color.fromARGB(255, 12, 12, 12)),
                    height: 60,
                    padding: EdgeInsets.all(5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (var i = 0; i < genre.length; i++)
                            for (var j = 0; j < genres.length; j++)
                              if (genre[i] == genres[j]["id"])
                                Text(
                                  genres[j]["name"] + ' ',
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                ),
                        ]),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
