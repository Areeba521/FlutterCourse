import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class appBarNews extends StatelessWidget implements PreferredSizeWidget {
  const appBarNews({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Headlines News',
                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Read Top News Today',
                style: TextStyle(fontSize: 14)
              ),
            
            ],
  ),

  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 25),
      child: Image.asset(
        'assets/newspaper.png',
        height: 35,
        width: 35,
      ),
    ),
  ],
  );  }


   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}