import 'package:flutter/material.dart';

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
        title: Text("Github Search"),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
//          _textField
        ],
      ),
    );
  }


}
