// import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MidPractice4'),
        ),
      //  floatingActionButton: FloatingActionButton(onPressed: fetchUsers, child: const Icon(Icons.add), focusColor: Colors.red, backgroundColor: Colors.yellow,),
        body: Builder(builder: (context){
          return Stack(
            children: [
          Padding(
            padding: const EdgeInsets.all(100.0),
            child: 
              Positioned(
                bottom: 20, right: 20,
              child: ElevatedButton(onPressed: () 
              {
            final message = 
            SnackBar(content: Text("Snackbar"),
            backgroundColor: Colors.pink,
            padding: EdgeInsets.all(10.0),
            duration: Duration(seconds: 3),
            action: SnackBarAction(label: 'Done',
           onPressed: () {},),
            );

            ScaffoldMessenger.of(context).showSnackBar(message);
            }, 
            child:  Text ('Click Me'))
            
            ),
          ),
            ],
          );
        }),
        bottomNavigationBar:   BottomAppBar(
          shape: const CircularNotchedRectangle(), // To accommodate FAB
          child: Row(
            children: [
              IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
              const Spacer(),
              IconButton(icon: const Icon(Icons.search), onPressed: () {}),
            ],
          ),

        
     

      ),
      ),
      
    );

       
  }

    // void fetchUsers() async{
    //  print('Fetch Users');
    //  const url = 'https://randomuser.me/api/?results=10';
    //  final uri = Uri.parse(url);
    //  final response = await http.get(uri);
    //  final body = response.body;
    //  final json = jsonDecode(body);
    // //  setState(){ (){
    // //   users = json['results'];
    // //  }
    //  }
}

