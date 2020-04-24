import 'package:flutter/material.dart';
import 'package:flutterchopper/data/post_api_service.dart';
import 'package:flutterchopper/ui/screens/home_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(

      create: (_)=> PostApiService.create(),
      dispose: (_ , PostApiService service)=> service.client.dispose() ,
      child:  MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}