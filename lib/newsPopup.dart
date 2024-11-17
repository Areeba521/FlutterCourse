import 'package:flutter/material.dart';
import 'package:newshighlights/main.dart';

class modelBottomNewsSheet extends StatelessWidget {
  final News news;
  const modelBottomNewsSheet({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Padding(
      
       padding: const EdgeInsets.all(16),
       child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            news.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            
             
          ),
          const SizedBox(height: 8),
           Text(
            'By ${news.author}',
            style: const TextStyle(
              fontSize: 12,
            ),
           ),

           const SizedBox(height: 2),
           Text(
            'Published on ${news.publishedAt}',
            style: const TextStyle(
              fontSize: 10,
               color: Colors.grey,
            ),
           ),
 const SizedBox(height: 8),
 Flexible(child:  ClipRRect(
borderRadius: BorderRadius.circular(10),
            child: AspectRatio(
             aspectRatio: 16 / 9,
              child: Image.network(
              news.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/imagenotfound.jpg',
                   fit: BoxFit.cover);
              },
            ),
            )
             
           ), ),
       


 const SizedBox(height: 8),
  Text(
            news.description,
            style: const TextStyle(
              fontSize: 10,
               fontWeight: FontWeight.bold,
            ),
           ),

            const SizedBox(height: 12),
  Text(
            news.content,
            style: const TextStyle(
              fontSize: 10,
               color: Colors.grey,
            ),
           ),
        ],
       ),

      );
  }
}