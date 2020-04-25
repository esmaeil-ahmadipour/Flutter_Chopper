import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutterchopper/data/post_api_service.dart';
import 'package:flutterchopper/ui/screens/SinglePostPage.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {


  MyHomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chopper blog'),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final response = await Provider.of<PostApiService>(context)
              .postPost({'key': 'value'});
          print(response.body);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

FutureBuilder<Response> _buildBody(BuildContext context) {
  return FutureBuilder<Response>(
    future: Provider.of<PostApiService>(context).getPosts(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if(snapshot.hasError){
          return Center(
            child: Text(snapshot.error.toString(),textAlign: TextAlign.center,textScaleFactor: 1.3,),
          );
        }
        final List posts = json.decode(snapshot.data.bodyString);
        return _buildPosts(context, posts);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

ListView _buildPosts(BuildContext context, List posts) {
  return ListView.builder(
    itemCount: posts.length,
    padding: EdgeInsets.all(8.0),
    itemBuilder: (context, index) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(
            posts[index]['title'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(posts[index]['body']),
          onTap: () => _navigateToPost(context, posts[index]['id']),
        ),
      );
    },
  );
}

void _navigateToPost(BuildContext context, int id) {
  Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => SinglePostPage(postId: id)),
  );
}
