import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'Post.dart';

void main() {
  runApp(MaterialApp(
    home: NetworkApp(),
  ));
}

class NetworkApp extends StatefulWidget {
  const NetworkApp({Key? key}) : super(key: key);

  @override
  State<NetworkApp> createState() => _NetworkAppState();
}

class _NetworkAppState extends State<NetworkApp> {
  Dio dio = Dio();

  Future<List<Post>> getPost() async {
    var response = await dio.get('https://jsonplaceholder.typicode.com/posts');
    return listFromJson(response.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Network"),
      ),
      body: FutureBuilder(
          future: getPost(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      color: Colors.blue,
                      margin: EdgeInsets.all(10),
                      child: Text(snapshot.data?[index].title ?? "pustoy"),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
