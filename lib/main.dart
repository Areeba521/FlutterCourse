
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/WidgetApi.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<List<Post>> fetchAllPosts() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.org/posts'));

    if(response.statusCode == 200){ //all okay data araha api say
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((post)=>Post.fromJson(post)).toList();
    }else{
       throw Exception("failed");
    }
  }


@override
Widget build(BuildContext context){
    return MaterialApp( // Wrap your Scaffold with MaterialApp
      home: Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(
         future: fetchAllPosts(),
         builder: (context, snap){
          if(snap.hasData){
            return  ListView.separated(
               separatorBuilder: (context, index) => const Divider(
                         color: Colors.grey,
                         thickness: 0.5,
                       ),
                   itemCount: 14,
                   itemBuilder: (context, index) {
                     return ListTile(
                       leading: Text('${index + 1}'),
                       trailing: const Text('end'),
                       title: const Text('Title'),
                       subtitle: const Text('subtitle'),
                     );
                   });
          }
          else if(snap.hasError){
            return Text('error in fetch');
          }
          return Center(child: CircularProgressIndicator(),);
         }
         ),
      ),
    ));
}

}



