import 'dart:convert' as convert;

import 'package:coursera_tv/course_details.dart';
import 'package:coursera_tv/main.dart' as main;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoursesList extends StatefulWidget {
  const CoursesList({super.key});

  @override
  State<CoursesList> createState() => _CoursesListState();
}

class _CoursesListState extends State<CoursesList> {
  late Future<List<String>> items;
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// class CoursesList extends StatelessWidget {
//   final List<String> items;
//
//   const CoursesList({super.key, required this.items});

  @override
  void initState() {
    super.initState();
    items = getListOfCourses();
  }

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

  Future<List<String>> getListOfCourses() async {
    const String baseUrl = 'api.coursera.org';
    const String charactersPath = '/api/memberships.v1';
    final Map<String, String> queryParameters = <String, String>{
      'includes': 'courseId,courses.v1',
      'q': 'me',
      'showHidden': 'true',
      'filter': 'current,preEnrolled',
    };
    final uri = Uri.https(baseUrl, charactersPath, queryParameters);
    var response =
        await http.get(uri, headers: {'Cookie': 'CAUTH=${main.cauth}'});
    // print('Response statusCode from getListOfCourses: ${response.statusCode}');
    // print('Response body from getListOfCourses: ${response.body}');

    if (response.statusCode == 200) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;
      var courseList = jsonResponse['linked']['courses.v1'];
      return [for (var element in courseList) element['slug']];
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return [];
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
          bottomNavigationBar: BottomAppBar(
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              FutureBuilder<List<String>>(
                  future: items,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        prototypeItem: ListTile(
                          title: Text(snapshot.data!.first),
                        ),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SizedBox(
                                width: 300,
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CourseDetails(
                                              courseSlug:
                                                  snapshot.data![index])),
                                    );
                                  },
                                  child: ListTile(
                                    title: Text(snapshot.data![index]),
                                  ),
                                ),
                              ),
                              TextButton(
                                style: ButtonStyle(
                                  foregroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.white),
                                  backgroundColor:
                                      WidgetStateProperty.all<Color>(
                                          Colors.blue),
                                  fixedSize: WidgetStateProperty.all<Size>(
                                      const Size.fromWidth(100)),
                                ),
                                onPressed: () async {
                                  var desc = await getCourseDetails(
                                      snapshot.data![index]);
                                  var snackBar = SnackBar(content: Text(desc));

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                child: const Text('Some test btn'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }),
              const Icon(Icons.account_circle),
            ],
          ),
        ),
      ),
    );
  }
}
