import 'dart:convert' as convert;

import 'package:coursera_tv/course_details.dart';
import 'package:coursera_tv/main.dart' as main;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoursesList extends StatelessWidget {
  final List<String> items;

  const CoursesList({super.key, required this.items});

  Future<String> getCourseDetails(String slug) async {
    const String baseUrl = 'api.coursera.org';
    const String charactersPath = '/api/onDemandCourses.v1';
    final Map<String, String> queryParameters = <String, String>{
      'q': 'slug',
      'slug': slug,
    };
    final uri = Uri.https(baseUrl, charactersPath, queryParameters);
    var response =
        await http.get(uri, headers: {'Cookie': 'CAUTH=${main.cauth}'});

    print('slug is $slug');
    print('Response statusCode from getCourseDetails: ${response.statusCode}');
    print('Response body from getCourseDetails: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      return jsonResponse['elements'][0]['description'];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.my_library_books_rounded)),
                Tab(icon: Icon(Icons.account_circle)),
              ],
            ),
            title: const Text('Tabs Demo'),
          ),
          bottomNavigationBar: const BottomAppBar(
            child: Center(child: Text("test", style: TextStyle(fontSize: 25))),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: items.length,
                prototypeItem: ListTile(
                  title: Text(items.first),
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // When the child is tapped, show a snackbar.
                    onTap: () async {
                      var desc = await getCourseDetails(items[index]);
                      var snackBar = SnackBar(content: Text(desc));

                      if (!context.mounted) return;

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CourseDetails()),
                      );
                    },
                    child: ListTile(
                      title: Text(items[index]),
                    ),
                  );
                },
              ),
              const Icon(Icons.account_circle),
            ],
          ),
        ),
      ),
    );
  }
}
