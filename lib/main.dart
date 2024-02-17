import 'package:coursera_tv/second.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

Future<String> postData(
  String login,
  String password,
) async {
  var url = Uri.https('example.com', 'whatsit/create');
  var response =
      await http.post(url, body: {'name': 'doodle', 'color': 'blue'});
  // print('Response body from postData: ${response.body}');

  return response.body;
}

Future<List<String>> getListOfCourses() async {
  final String baseUrl = 'api.coursera.org';
  final String charactersPath = '/api/memberships.v1';
  final Map<String, String> queryParameters = <String, String>{
    'includes': 'courseId,courses.v1',
    'q': 'me',
    'showHidden': 'true',
    'filter': 'current,preEnrolled',
  };
  final uri = Uri.https(baseUrl, charactersPath, queryParameters);
  var response = await http.get(uri, headers: {
    'Cookie':
        'CAUTH=iSnxUuUXexAVmDYebtjE896f7sAJW2qPFR2mmFvI6nmnGWRnuqyu2suTtABxT3xDxkwW5ZNhuLEk4SxmNgKBtQ.uHY97RxCQc62nmCxUP1jhg.vO5Z3SL-Zw-EXvJSD_wPd8Q8muyj9xXJIbhKg-lDxeUp4vKqIkFarZikHun2EPFfrYOlHbkAgIXOQkEONYd50wfj_O4ijoCBfxu6A_yRfU_9UGZLKucTyXS-cGx_8Nk246ZxYns0OLlDXOL0cePVhEeLi9FjdFXNg8JWngJLuqj3GhR5BpmwxKq8nHeo5GFZCqIgI-9izlJbNcqPj12mb1Q8fjPWWtZy8Q16P8wAGMUpeqOcRtZ0xolZqPE6onNd6Ay38adR3-ZsarG76DYqrrkwPlWiTH4R4Ukb3Sf0X_Ip_42QS8AfRFEQW9_NdCjjJZz8EfnecKsGTYb7OrmrP37dvo24Kvk72H0NqDhcj8U4d-lTeG3NNBC3H8KaWrGy1WaPVa7thNkTvfymxsZFPt9S7cIUC2dYQ5NI710ku6w'
  });
  print('Response statusCode from getListOfCourses: ${response.statusCode}');
  print('Response body from getListOfCourses: ${response.body}');
  return ['test'];
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Coursera flutter app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String commonLoginStr = 'Enter your coursera';
  final myLoginController = TextEditingController();
  final myPassController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myLoginController.dispose();
    myPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: '$commonLoginStr username',
                ),
                controller: myLoginController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  border: const UnderlineInputBorder(),
                  labelText: '$commonLoginStr password',
                ),
                controller: myPassController,
              ),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                fixedSize:
                    MaterialStateProperty.all<Size>(const Size.fromWidth(100)),
              ),
              onPressed: () async {
                await postData(myLoginController.text, myPassController.text);
                await getListOfCourses();
                if (!context.mounted) return;
                final List<String> items =
                    List<String>.generate(5, (i) => 'Item $i');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecondRoute(items: items)),
                );
              },
              child: const Text('Login'),
            )
          ],
        ),
      ),
    );
  }
}
