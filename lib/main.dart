//import 'dart:convert';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshighlights/app_bar.dart';
import 'package:http/http.dart' as http;
import 'package:newshighlights/news_display.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 249, 249, 249),
          foregroundColor: Colors.black,
          elevation: 0.4,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>      
          Scaffold(
        appBar: const appBarNews(),
        body: BlocProvider(
        create: (context) => NewsBloc()..add(FetchNewsEvent()),
        child: const NewsDisplay(),
        ),
      ),
      
      ));
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo.png', width: 150), 
            const SizedBox(height: 20),
          
          ],
        ),
      ),
    );
  }
}


const String apiKey = 'abb021fcd9124fe4a756d19365dc0136';
const String baseUrl = 'https://newsapi.org/v2/top-headlines?country=us'; // Replace with your base URL

class News {
  final String author;
  final String title;
  final String publishedAt;
  final String imageUrl;
  final String description;
  final String content;


  News({
    required this.author,
    required this.title,
    required this.publishedAt,
    required this.imageUrl,
    required this.description,
    required this.content
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      author: json['author'] ?? 'Unknown',
      title: json['title'] ?? 'No Title',
      publishedAt: _getDate(json['publishedAt'] ?? ''),
      imageUrl: json['urlToImage'] ?? '',
      description: json['description'] ?? 'No description available',
      content: json['content'] ?? 'No Content',
    );
  }
}


abstract class NewsEvent {}

class FetchNewsEvent extends NewsEvent {}

abstract class NewsState {}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {
}

class NewsLoaded extends NewsState {
  final List<News> news;
  NewsLoaded(this.news);
}

class NewsError extends NewsState {
  final String error;
  NewsError(this.error);
}

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<FetchNewsEvent>(_onFetchNews);
  }

Future<void> _onFetchNews(FetchNewsEvent event, Emitter<NewsState> emit) async {
  emit(NewsLoading());
  try {
    final response = await http.get(Uri.parse('$baseUrl&apiKey=$apiKey'));

    if (response.statusCode == 200) {

      Map<String, dynamic> newsData = json.decode(response.body);

      if (newsData['articles'] == null) {
        emit(NewsError('No articles found in the response'));
        return;
      }

      List<dynamic> jsonResponse = newsData['articles'];
      List<News> allNews = jsonResponse.map((newsJson) {
        return News.fromJson(newsJson);
      }).toList();

      emit(NewsLoaded(allNews));
    } else {
      emit(NewsError('Failed to load news: ${response.statusCode}'));
    }
  } catch (e) {
    emit(NewsError(e.toString()));
  }
}
}

String _getDate(String dateString) {
  if (dateString.isEmpty) return 'Unknown Date';
  DateTime dateTime = DateTime.parse(dateString);
  return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}';
}