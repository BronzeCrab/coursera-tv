import 'package:flutter/material.dart';

class CourseDetails extends StatelessWidget {
  final String courseSlug;
  const CourseDetails({super.key, required this.courseSlug});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              Text("Name of this course: $courseSlug"),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
