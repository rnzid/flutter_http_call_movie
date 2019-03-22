import 'package:flutter/material.dart';
import './detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  Future<List> getMovies() async {
    http.Response res = await http.Client().get(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=e21cd99d5396e8a21001aefd7c8b56bd&language=en-US&page=1');
    return json.decode(res.body)['results'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upcoming English Movies"),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: getMovies(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.hasError)
              return Center(
                child: Text("There is Error"),
              );
            List results = snapshot.data;
            return ListView.builder(
              itemCount: results == null ? 0 : results.length,
              padding: EdgeInsets.all(2.0),
              itemBuilder: (BuildContext context, int index) {
                Movies movie = Movies.fromMap(results[index]);
                var user = results[index];
                if (index.isOdd) return Divider();
                return ListTile(
                  title: Text(
                    movie.title,
                    //or results[index]["title"]
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // trailing: Image.asset("${results[index]['poster_path']}"),
                  leading: CircleAvatar(
                      radius: 25.0,
                      child: Text(
                        "${results[index]['title'][0].toString().toUpperCase()}",
                        style: TextStyle(fontSize: 25.0),
                      )
                      //Image.asset("${results[index]['poster_path']}"),
                      //   backgroundImage:
                      //       NetworkImage("${results[index]['poster_path']}"),
                      //   //NetworkImage("${results[index]['poster_path']}"),
                      ),
                  // subtitle: Text(movie.popularity.toString()),
                  subtitle: Text(
                      "Average Vote  :" + " ${results[index]['vote_average']}"),
                      trailing: IconButton(icon: Icon(Icons.info),onPressed:()=> Navigator.push(
                       context,
                       MaterialPageRoute(
                           builder: (_) => DetailPage(user: user))),),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class Movies {
  int id;
  String title;
  int popularity;
  String poster_path;
  String overview;

  Movies.fromMap(Map results)
      : id = results['id'],
        title = results['title'],
        popularity = results['results'],
        poster_path = results['poster_path'],
        overview = results['overview'];
}