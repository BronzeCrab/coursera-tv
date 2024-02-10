import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

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
          body: const TabBarView(
            children: [
              Icon(Icons.my_library_books_rounded),
              Icon(Icons.account_circle),
            ],
          ),
        ),
      ),
    );
  }
}
