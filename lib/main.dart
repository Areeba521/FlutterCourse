import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //setting the theme
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, 
          foregroundColor: Colors.black, 
          elevation: 4.0, // to mak it a bit shadowed
        ),
      ),
      debugShowCheckedModeBanner: false,  //removes debug banner
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Jobs'),
          elevation: 0.8,  //making appbar shadowed
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(  //bell/Notification icon
                Icons.notifications_none_outlined,
                color: Color(0xFF671076),
              ),
            ),
          ],
        ),
        body: JobListings(),
        //setting icons on the bottom of display
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.work_outline_outlined),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Resume',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

class JobListings extends StatefulWidget {
  @override
  _JobListingsState createState() => _JobListingsState();
}

class _JobListingsState extends State<JobListings> {
  List<Job> allJobs = [];

  @override
  void initState() {
    super.initState();
    fetchJobs(); // Fetch jobs when the widget is initialized
  }


  Future<void> fetchJobs() async {
    final response = await http.get(Uri.parse('https://mpa0771a40ef48fcdfb7.free.beeceptor.com/jobs'));

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      Map<String, dynamic> jobData = json.decode(utf8.decode(response.body.codeUnits));
      List<dynamic> jsonResponse = jobData['data'];

      setState(() {
        allJobs = jsonResponse.map((jobJson) => Job.fromJson(jobJson['job'])).toList();
      });
    } else {
      // If the server did not return a 200 OK response, throw an exception
      throw Exception('Failed to load jobs');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allJobs.length,
      itemBuilder: (context, index) {
        final job = allJobs[index];
        return JobCard(job: job);
      },
    );
  }
}


//this method is ccustomizing the time being displayed and replacing 'about a' with '1'
String timeFormatted(DateTime dateTime){
  final timeAgo = timeago.format(dateTime);  //uses dependency
  return timeAgo.replaceFirst('about a', '1');
}

class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 1.2, //elevation of boxes of jobs
      color: Colors.white,  //background color of job boxes on display
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //used for making rounded corners
            ClipRRect(  
                borderRadius: BorderRadius.circular(8.0), 
                child: Image.network(
                job.imageUrl,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
  ),
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
                        job.jobTitle,  //displays jobTitle
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16 ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        job.companyName, //displays companyName
                        style: const TextStyle(color: Color.fromARGB(255, 99, 97, 97)), 
                      ), 
                      Text(
                        '${job.location}. ${job.workPlaceType}. ${job.jobType}',  //displays jobLocation and other info
                        style: const TextStyle(color: Color.fromARGB(255, 99, 97, 97)), 
                        ),
                    ],
                  ),
                  const SizedBox(height: 10), 
                  //aligns the time posted in the bottom right corner
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      timeFormatted(DateTime.parse(job.timePosted)),
                      style: const TextStyle(color: Colors.grey), 
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


//Job class with its attributes and constructor
class Job {
  final String imageUrl; // Change to a string for the image URL
  final String jobTitle;
  final String companyName;
  final String location;
  final String timePosted;
  final String jobType;
  final String workPlaceType;

  Job({
    required this.imageUrl, // Use a URL instead of ImageIcon
    required this.jobTitle,
    required this.companyName,
    required this.location,
    required this.timePosted,
    required this.jobType,
    required this.workPlaceType,
  });


//factory model that takes data from json (API)
  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      imageUrl: json['company']['logo'], 
      jobTitle: json['title'],
      companyName: json['company']['name'],
      location: json['location']['name_en'],
      timePosted: json['created_date'],
      jobType: json ['type']['name_en'],
      workPlaceType: json['workplace_type']['name_en'],
    );
  }
}
