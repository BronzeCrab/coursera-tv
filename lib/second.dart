import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  final List<String> items;

  const SecondRoute({super.key, required this.items});

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
