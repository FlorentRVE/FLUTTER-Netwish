import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/utils/api.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({Key? key}) : super(key: key);

  @override
  State<MovieScreen> createState() => MovieScreenState();
}

class MovieScreenState extends State<MovieScreen> {
  Future<dynamic> getPosts(movieID) async {
    var data = await Api().getMoviebyId(movieID);
    var post = jsonDecode(data);

    return post;
  }

  @override
  Widget build(BuildContext context) {
    var params =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    var id = params?["id"];
    return Scaffold(
      //////////// AppBar //////////////////
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Center(
          child: const Text(
            'NetWish',
            style: TextStyle(
                color: Color.fromARGB(255, 244, 3, 3),
                fontSize: 25,
                fontWeight: FontWeight.w800),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 37, 36, 36),
        elevation: 20,
      ),

      //////////// Body //////////////////
      body: FutureBuilder(
        future: Future.wait([getPosts(id)]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            var posts = snapshot.data[0];
            return Column(
              children: [
                //////// Title /////////
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    posts["title"],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ///////// Image ///////////
                Image(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w300" + posts["poster_path"]),
                  height: 300,
                  width: 250,
                ),
                ///////// bouton ///////////
                Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.red,
                      height: 50,
                      width: 400,
                      child: Center(
                        child: Text(
                          'PLAY',
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                ),
                //////// review /////////
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    color: Color.fromARGB(255, 43, 42, 42),
                    child: Text(
                      posts["overview"],
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
