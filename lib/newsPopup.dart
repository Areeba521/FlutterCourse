import 'package:flutter/material.dart';
import 'package:assignment3/main.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: camel_case_types
class modelBottomNewsSheet extends StatelessWidget {
  final News news;
  const modelBottomNewsSheet({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
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
       ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox( 
              
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  news.imageUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.25, 
                  width: screenWidth,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/imagenotfound.jpg',
                     fit: BoxFit.cover,
                     height: MediaQuery.of(context).size.height * 0.25, 
                     width: screenWidth,
                    );
                  },
                ),
              ),
            ),
          ),

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
        
         const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            _launchUrl(news.articleUrl); 
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            'View Article',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        ],

       ),

       

      );
  }
}

Future<void> _launchUrl(String url) async {
  final Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    print("URL launched successfully: $url");
  } else {
    print("Could not launch the URL: $url");
   
  }
}
