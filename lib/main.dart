import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //TODO:2 here we call the class of search
                showSearch(context: context, delegate: DataSearch());
              },
              icon: Icon(Icons.search_outlined))
        ],
        title: Text(widget.title),
      ),
    );
  }
}

//TODO: 1 here we mange the search class
class DataSearch extends SearchDelegate {
  // here is a list we use  for search
  List names = [
    "beer",
    "ahmad",
    "sarah ",
    "samy",
    "soso",
    "msaa",
    "tees",
  ];

// this method for the close icon to clear the search
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

//this method for the back bottom icon to close the saerch
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
        child: Text(
      // show the query as a (((result))) ( you can show widget or whatever )
      query,
      style: TextStyle(fontSize: 30),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //here we filter the list while searching
    // we can search with contains/startWith/EndWith
    List filename = names.where((element) => element.contains(query)).toList();

    return ListView.builder(
        //here is the list
        itemCount: query == "" ? names.length : filename.length,
        itemBuilder: (context, i) {
          //inkwell is a bottom we need for the " on tap "
          return InkWell(
            onTap: () {
              // make the query == the name on the list
              query = query == "" ? names[i] : filename[i];
              //show result so we can go to the method build results
              showResults(context);
            },
            child: Container(
                padding: EdgeInsets.all(10),
                child: query == ""
                    ? Text(
                        "${names[i]}",
                      )
                    : Text(
                        "${filename[i]}",
                      )),
          );
        });
  }
}
