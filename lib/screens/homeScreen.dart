import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie_db/components/post.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_db/utils/api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String searchTerms = "a";

  var sortValue = 5.0;

  var myController = TextEditingController();

  Future<void> dialog(BuildContext context) async {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 43, 42, 42),
          title: const Text(
            'Search',
            style: TextStyle(color: Colors.red),
          ),
          content: TextField(
            style: TextStyle(color: Colors.white),
            controller: myController,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                setState(() {
                  searchTerms = myController.text;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> getPosts() async {
    var data = await Api().getMovies(searchTerms);
    var post = jsonDecode(data);

    return post;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //////////// AppBar //////////////////
      backgroundColor: const Color.fromARGB(255, 37, 36, 36),
      appBar: AppBar(
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
        future: Future.wait([getPosts()]),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            var posts = snapshot.data[0]["results"];

            return Column(
              children: [
                //////// Trie par note /////////
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Trier par note',
                      style: TextStyle(color: Colors.white),
                    ),
                    Slider(
                        value: sortValue,
                        min: 0,
                        max: 10,
                        onChanged: (value) {
                          setState(() {
                            sortValue = value;
                          });
                        }),
                  ],
                ),
                //////// posts /////////
                Expanded(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(15),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.5,
                    mainAxisSpacing: 10,
                    scrollDirection: Axis.vertical,
                    children: [
                      for (var i = 0; i < posts.length; i++)
                        if (posts[i]["vote_average"] >= sortValue)
                          GestureDetector(
                            onTap: () =>
                                {context.go('/movie?id=${posts[i]["id"]}')},
                            child: Post(
                                note: posts[i]["vote_average"],
                                postImage: posts[i]["poster_path"] ??
                                    'https://via.placeholder.com/150',
                                genre: posts[i]["genre_ids"]),
                          ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
      //////////////// footer //////////////////
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 37, 36, 36),
        unselectedItemColor: Color.fromARGB(255, 254, 254, 254),
        selectedItemColor: Colors.red,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () => searchTerms = " ",
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: GestureDetector(
              onTap: () {
                dialog(context);
              },
              child: Icon(Icons.search),
            ),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
