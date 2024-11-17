import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newshighlights/main.dart';
import 'package:newshighlights/newsPopup.dart';
import 'package:newshighlights/shimmerLoading.dart';



class NewsDisplay extends StatelessWidget {
  const NewsDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
        if(state is NewsLoading){
                  //return const Center(child: CircularProgressIndicator());    
            return ListView.builder(
              itemCount: 6, // Placeholder count
              itemBuilder: (context, index) {
               return const newsShimmerLoading();
              },
            );
        }
        else if(state is  NewsLoaded){
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index){
                final news = state.news[index];

                return  GestureDetector(
      onTap: (){
        showModalBottomSheet(
          context: context, 
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18))
          ),
          builder: (context) =>
            modelBottomNewsSheet(news: news),
          
          );
      },
      child:  Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 2,
      shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
      shadowColor: Colors.pinkAccent.withOpacity(0.8), 
             
      color: Colors.white, 
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [ 
              Image.network(
                news.imageUrl,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Padding( 
                  padding: const EdgeInsets.only(top: 12.0),
                  child:Image.asset('assets/imagenotfound.jpg',
                   height: 80,
                   width: 80,
                   fit: BoxFit.cover)
                   );
                 
  },
  ),

            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14 ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        news.author,
                        style: const TextStyle(color: Color.fromARGB(255, 99, 97, 97),
                        fontSize: 12), 
                      ), 
                       const SizedBox(height: 5),
                      Text(
                        news.publishedAt,
                        style: const TextStyle(color: Color.fromARGB(255, 99, 97, 97),
                        fontSize: 12), 
                        ),
                    ],
                  ),
          
                ],
              ),
            ),
          ],
        ),
      ),
    ),
                );
                
               
              }
              );
        }
        else if(state is NewsError){
          return Center(
            child: Text(
              'Failed to load news: ${state.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        else {
          return const SizedBox.shrink();
        }
      }
    ),
    );
  }
}

 