import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApiWidget extends StatefulWidget {
  const MyApiWidget({super.key});

  @override
  State<MyApiWidget> createState() => _MyApiWidgetState();
}

//api call and parsing done
//next step is to show it on front end

class _MyApiWidgetState extends State<MyApiWidget> {
  
 Future<List<Post>> fetchAllPosts() async{
    final response = await http.get(Uri.parse('https://www.jsonplaceholder.org/posts'));

    if(response.statusCode == 200){ //all okay data araha api say
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((post)=>Post.fromJson(post)).toList();
    }else{
       throw Exception("failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}


class Post{
  final int id;
  final String slug;
  final String content;
  final String title;
  final String url;
  final String image;

  Post({
    required this.id,
    required this.slug,
    required this.url,
    required this.content,
    required this.title,
    required this.image
  });

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      id: json['id'],
      slug: json['slug'],
      url: json['url'],
      content: json['content'],
      image: json['image'],
      title: json['title'],
    );
  }
}

