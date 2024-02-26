import 'dart:convert' as convert;

import 'package:coursera_tv/main.dart' as main;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SecondRoute extends StatelessWidget {
  final List<String> items;

  const SecondRoute({super.key, required this.items});

  Future<String> getCourseDetails(String slug) async {
    const String baseUrl = 'api.coursera.org';
    const String charactersPath = '/api/onDemandCourseMaterials.v1';
    final Map<String, String> queryParameters = <String, String>{
      'q': 'slug',
      'slug': slug,
    };
    final uri = Uri.https(baseUrl, charactersPath, queryParameters);
    var response = await http.get(uri, headers: {
      'Cookie':
          'CAUTH=iSnxUuUXexAVmDYebtjE896f7sAJW2qPFR2mmFvI6nmnGWRnuqyu2suTtABxT3xDxkwW5ZNhuLEk4SxmNgKBtQ.uHY97RxCQc62nmCxUP1jhg.vO5Z3SL-Zw-EXvJSD_wPd8Q8muyj9xXJIbhKg-lDxeUp4vKqIkFarZikHun2EPFfrYOlHbkAgIXOQkEONYd50wfj_O4ijoCBfxu6A_yRfU_9UGZLKucTyXS-cGx_8Nk246ZxYns0OLlDXOL0cePVhEeLi9FjdFXNg8JWngJLuqj3GhR5BpmwxKq8nHeo5GFZCqIgI-9izlJbNcqPj12mb1Q8fjPWWtZy8Q16P8wAGMUpeqOcRtZ0xolZqPE6onNd6Ay38adR3-ZsarG76DYqrrkwPlWiTH4R4Ukb3Sf0X_Ip_42QS8AfRFEQW9_NdCjjJZz8EfnecKsGTYb7OrmrP37dvo24Kvk72H0NqDhcj8U4d-lTeG3NNBC3H8KaWrGy1WaPVa7thNkTvfymxsZFPt9S7cIUC2dYQ5NI710ku6w'
    });
    // print('Response statusCode from getListOfCourses: ${response.statusCode}');
    // print('Response body from getListOfCourses: ${response.body}');

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
    print('test1');
    print(main.cauth);
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
                  return ListTile(
                    title: Text(items[index]),
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
