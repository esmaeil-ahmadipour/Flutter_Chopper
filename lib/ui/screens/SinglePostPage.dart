import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutterchopper/data/post_api_service.dart';
import 'package:provider/provider.dart';

class SinglePostPage extends StatelessWidget {
  final int postId;

  const SinglePostPage({Key key, this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chopper Blog"),
      ),
      body: FutureBuilder<Response>(
        future: Provider.of<PostApiService>(context).getPost(postId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final Map post = json.decode(snapshot.data.bodyString);
            return _buildPost(post);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
Widget _buildPost(Map post){
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        Text(post['title'],style: TextStyle(fontWeight: FontWeight.bold),),
        SizedBox(height: 8.0,),
        Text(post['body']),
      ],
    ),
  );
}