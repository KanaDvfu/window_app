import 'package:flutter/material.dart';
import 'ListItem.dart';

enum Menu { itemOne, itemTwo }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Тут должно быть название ветки"),
        actions: <Widget>[
          PopupMenuButton<Menu>(
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                const PopupMenuItem<Menu>(
                  value: Menu.itemOne,
                  child: Text('Кнопка 1'),
                ),
                const PopupMenuItem<Menu>(
                  value: Menu.itemTwo,
                  child: Text('Кнопка2'),
                ),
              ]
          ),
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 2,
          prototypeItem: ListTile(
            title: Text("Предмет"),
          ),
          itemBuilder: (context, index) {
            return ListItem(text: "Предмет $index");
          },
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.apple),
      ),
    );
  }
}