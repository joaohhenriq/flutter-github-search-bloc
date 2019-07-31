import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'blocs/search_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SearchBloc _searchBloc;

  // initState executa somente uma vez, antes do componente ser montado
  @override
  void initState() {
    _searchBloc = new SearchBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Github Search"),
              SizedBox(
                width: 10,
              ),
              Icon(FontAwesomeIcons.github)
            ],
          ),
          backgroundColor: Colors.black87,
          centerTitle: true,
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.black.withOpacity(0.7),
            ),
            child: ListView(
              children: <Widget>[_searchField()],
            ),
          ),
        ));
  }

  Widget _searchField() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Material(
        elevation: 2,
        shadowColor: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        child: TextField(
          cursorColor: Colors.black87,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Enter a repository name",
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 14),
            suffixIcon: Material(
              elevation: 0.0,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Icon(Icons.search, color: Colors.black87,),
            )
          ),
        ),
      )
    );
  }
}
